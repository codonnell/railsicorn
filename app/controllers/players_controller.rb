class PlayersController < ApplicationController
  # before_action :set_player, only: [:show, :update, :destroy]

  # GET /players
  # def index
  #   @players = Player.all

  #   render json: @players
  # end

  # GET /players/1
  def show
    puts player_params.inspect
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

  # POST /players
  # def create
  #   @player = Player.new(player_params)

  #   if @player.save
  #     render json: @player, status: :created, location: @player
  #   else
  #     render json: @player.errors, status: :unprocessable_entity
  #   end
  # end

  # PATCH/PUT /players/1
  # def update
  #   if @player.update(player_params)
  #     render json: @player
  #   else
  #     render json: @player.errors, status: :unprocessable_entity
  #   end
  # end

  # DELETE /players/1
  # def destroy
  #   @player.destroy
  # end

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

    # Use callbacks to share common setup or constraints between actions.
    # def set_player
    #   @player = Player.find(params[:id])
    # end

    # Only allow a trusted parameter "white list" through.
    def player_params
      params.permit(:api_key, ids: [])
    end
end
