class PlayersController < ApplicationController

  def show
    @user = User.find_by(api_key: player_params[:api_key])
    unless @user
      render json: { error: "Invalid API key #{player_params[:api_key]}" }
      return
    end
    info_hash = {}
    players = Player.where(torn_id: player_params[:ids]).includes(:player_info_updates)
    players.each { |player| info_hash[player.torn_id] = player_info(player) }
    render json: info_hash.select { |_, info| info }
  end

  private

  def player_info(player)
    difficulty = @user.player.difficulty(player)
    info = player.player_info_updates.sort_by(&:timestamp).last
    relevant_stats = { 'difficulty' => difficulty }
    if info
      relevant_stats.merge!(info.attributes.slice('xanax_taken', 'refills', 'stat_enhancers_used'))
    end
    relevant_stats.each { |k, v| relevant_stats[k] = 0 if v.nil? }
    relevant_stats
  end

  def player_params
    params.permit(:api_key, ids: [])
  end
end
