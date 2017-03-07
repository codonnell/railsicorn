class UsersController < ApplicationController
  # before_action :set_user, only: [:show, :update, :destroy]

  # GET /users
  # def index
  #   @users = User.all

  #   render json: @users
  # end

  # GET /users/1
  # def show
  #   render json: @user
  # end

  # POST /users
  def create
    puts user_params.inspect
    api_key = user_params[:api_key]
    @user = User.find_by(api_key: api_key)
    if @user
      render json: { success: true }
      return
    end
    @user = UserRegistrar.new(api_key).call
    if @user
      render json: { success: true }
    else
      render json: { error: "Invalid API Key: #{api_key}"}
    end
  end

  # PATCH/PUT /users/1
  # def update
  #   if @user.update(user_params)
  #     render json: @user
  #   else
  #     render json: @user.errors, status: :unprocessable_entity
  #   end
  # end

  # DELETE /users/1
  # def destroy
  #   @user.destroy
  # end

  # private
    # Use callbacks to share common setup or constraints between actions.
    # def set_user
    #   @user = User.find(params[:id])
    # end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.permit(:api_key)
    end
end
