class UsersController < ApplicationController

  def create
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

  private

  def user_params
    params.permit(:api_key)
  end
end
