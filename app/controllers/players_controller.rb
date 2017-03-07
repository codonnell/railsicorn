class PlayersController < ApplicationController
  # before_action :set_player, only: [:show, :update, :destroy]

  # GET /players
  # def index
  #   @players = Player.all

  #   render json: @players
  # end

  # GET /players/1
  def show
    @user = User.find_by(api_key: params[:api_key])
    info_hash = {}
    params[:ids].each { |id| info_hash[id] = player_info(id) }
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

  def player_info(player_id)
    player = Player.find_or_create_by(torn_id: player_id)
    difficulty = @user.player.difficulty(player)
    return nil unless difficulty || player.info
    relevant_stats = { 'difficulty' => difficulty }
    if player.info
      relevant_stats.merge!(player.info.attributes.slice('xanax_taken', 'refills', 'stat_enhancers_used'))
    end
    relevant_stats.each { |k, v| relevant_stats[k] = 0 if v.nil? }
    relevant_stats
  end

    # Use callbacks to share common setup or constraints between actions.
    # def set_player
    #   @player = Player.find(params[:id])
    # end

    # Only allow a trusted parameter "white list" through.
    # def player_params
    #   params.require(:ids, :api_key)
    # end
end
