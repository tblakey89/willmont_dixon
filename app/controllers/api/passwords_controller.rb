class Api::PasswordsController < ApplicationController

  def index
    @password = Password.first
  end

  def update
    @password = Password.first
    if @password.update_attributes(safe_params)
      render :index, status: 200
    else
      render json: { errors: @password.errors }, status: 400
    end
  end

  def check_password
    @password = Password.first
    if params[:password] == @password.password
      render json: { data: true }, status: 200
    else
      render json: { errors: { password: "The password was incorrect" } }, status: 400
    end
  end

private
  def safe_params
    params.require(:password).permit(:password)
  end
end
