class Api::AdminsController < ApplicationController
  before_filter :authenticate

  def index
    @admins = User.where("role > 1")
  end

  def show
    @admin = User.find(params[:id])
  end

  def create
    @admin = User.new(safe_params)
    @admin.add_role(@current_user, params[:admin][:role])
    if @admin.save
      render :show, id: @admin.id, status: 201
    else
      render :json => { :errors => @admin.errors }, status: 400
    end
  end

  def update
    @admin = User.find(params[:id])
    if @admin.update_attributes(safe_params)
      render :show, id: @admin.id, status: 200
    else
      render :json => { :errors => @admin.errors }, status: 400
    end
  end

  def destroy
    User.find(params[:id]).destroy
    render nothing: true, status: 204
  end

private
  def safe_params
    params.require(:admin).permit(:first_name, :last_name, :email, :password, :password_confirmation, :role) unless params[:admin].blank?
  end
end
