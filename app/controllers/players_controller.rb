class PlayersController < ApplicationController
  before_action :authorize_user

  def show
    # render json: {}
    # return
    infos = RelevantPlayerInfo.where(torn_id: player_params[:ids])
    all_ids = Set.new(player_params[:ids])
    create_unknown_players(all_ids, infos.map(&:torn_id))
    @player = @user.player
    @infos = to_h(infos)
    add_difficulties
    sanitize
    render json: @infos
  end

  private

  def create_unknown_players(all_ids, known_ids)
    Player.create((all_ids - known_ids).map { |id| { torn_id: id } })
  end

  def add_difficulties
    @infos.each_value do |info|
      info['difficulty'] = @player.difficulty(info.symbolize_keys)
    end
  end

  def sanitize
    @infos.each_value do |info|
      info.delete('player_id')
      info.delete('torn_id')
      info.delete('xanax_taken') if info['xanax_taken'].nil?
      info.delete('refills') if info['refills'].nil?
      info.delete('stat_enhancers_used') if info['stat_enhancers_used'].nil?
    end
  end

  def to_h(infos)
    h = {}
    infos.each { |info| h[info.torn_id] = info.attributes }
    h
  end

  def authorize_user
    @user = User.find_by(api_key: player_params[:api_key])
    unless @user
      render json: { error: "Unknown API key: #{player_params[:api_key]}" }
      return
    end
    render json: { error: "Unauthorized faction" } unless @user.faction.authorized?
  end

  def player_params
    params.permit(:api_key, ids: [])
  end
end
