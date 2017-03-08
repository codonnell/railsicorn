class PlayersController < ApplicationController
  before_action :authorize_user

  def show
    @player = @user.player
    info_hash = {}
    players = Player.where(torn_id: player_params[:ids]).includes(:player_info_updates)
    create_unknown_players(players)
    players.each { |player| info_hash[player.torn_id] = player_info(player) }
    render json: info_hash.select { |_, info| info }
  end

  private

  def create_unknown_players(players)
    Player.create(
      (Set.new(player_params[:ids]) - Set.new(players.map(&:torn_id))).map { |id| {torn_id: id} }
    )
  end

  def player_info(player)
    difficulty = @player.difficulty(player)
    info = player.player_info_updates.sort_by(&:timestamp).last
    relevant_stats = { 'difficulty' => difficulty }
    if info
      relevant_stats.merge!(info.attributes.slice('xanax_taken', 'refills', 'stat_enhancers_used'))
    end
    relevant_stats.each { |k, v| relevant_stats[k] = 0 if v.nil? }
    relevant_stats
  end

  def authorize_user
    @user = User.find_by(api_key: player_params[:api_key])
    unless @user
      render json: { error: "Unknown API key #{player_params[:api_key]}" }
      return
    end
    render json: { error: "Unauthorized faction" } unless @user.faction.authorized?
  end

  def player_params
    params.permit(:api_key, ids: [])
  end
end
