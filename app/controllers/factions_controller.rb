class FactionsController < ApplicationController
  before_action :set_faction, only: [:show, :update, :destroy]

  # GET /factions
  def index
    @factions = Faction.all

    render json: @factions
  end

  # GET /factions/1
  def show
    render json: @faction
  end

  # POST /factions
  def create
    @faction = Faction.new(faction_params)

    if @faction.save
      render json: @faction, status: :created, location: @faction
    else
      render json: @faction.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /factions/1
  def update
    if @faction.update(faction_params)
      render json: @faction
    else
      render json: @faction.errors, status: :unprocessable_entity
    end
  end

  # DELETE /factions/1
  def destroy
    @faction.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_faction
      @faction = Faction.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def faction_params
      params.require(:faction).permit(:torn_id, :api_key)
    end
end
