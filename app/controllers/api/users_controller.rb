class Api::UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      render :show, id: @user.id, status: 201
    else
      render nothing: true, status: 400
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      render :show, id: @user.id, status: 200
    else
      render nothing: true, status: 400
    end
  rescue
    render nothing: true, status: 400
  end

  def destroy
    User.find(params[:id]).destroy
    render nothing: true, status: 204
  rescue
    render nothing: true, status: 400
  end

end
