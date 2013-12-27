class Api::NextOfKinsController < ApplicationController
  before_filter :load_user

  def index
    @next_of_kins = @user.next_of_kins
  end

  def show
    @next_of_kin = @user.next_of_kins.find(params[:id])
  end

  def create
    @next_of_kin = @user.next_of_kins.new(params[:next_of_kin])
    if @next_of_kin.save
      render :show, user_id: @user.id, id: @next_of_kin.id, status: 201
    else
      render nothing: true, status: 400
    end
  end

  def update
    @next_of_kin = @user.next_of_kins.find(params[:next_of_kin])
    if @next_of_kin.update_attributes(params[:next_of_kin])
      render :show, user_id: @user.id, id: @next_of_kin.id, status: 200
    else
      render nothing: true, status: 400
    end
  rescue
    render nothing: true, status: 400
  end

  def destroy
    @next_of_kin = @user.next_of_kins.find(params[:next_of_kin]).destroy
    render nothing: true, status: 204
  rescue
    render nothing: true, status: 400
  end

private
  def load_user
    @user = User.find(params[:user_id])
  end
end
