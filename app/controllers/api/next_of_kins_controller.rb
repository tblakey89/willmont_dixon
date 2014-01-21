class Api::NextOfKinsController < ApplicationController
  before_filter :load_user
  before_filter :authenticate

  def index
    @next_of_kins = @user.next_of_kins
  end

  def show
    @next_of_kin = @user.next_of_kins.find(params[:id])
  end

  def create
    @next_of_kin = @user.next_of_kins.new(safe_params)
    if @next_of_kin.save
      render :show, user_id: @user.id, id: @next_of_kin.id, status: 201
    else
      render :json => { :errors => @next_of_kin.errors }, status: 400
    end
  end

  def update
    @next_of_kin = @user.next_of_kins.find(params[:id])
    if @next_of_kin.update_attributes(safe_params)
      render :show, user_id: @user.id, id: @next_of_kin.id, status: 200
    else
      render :json => { :errors => @next_of_kin.errors }, status: 400
    end
  rescue
    render nothing: true, status: 400
  end

  def destroy
    @next_of_kin = @user.next_of_kins.find(params[:id]).destroy
    render nothing: true, status: 204
  rescue
    render nothing: true, status: 400
  end

private
  def load_user
    @user = User.find(params[:user_id])
  end

  def safe_params
    params.require(:next_of_kin).permit(:first_name, :last_name, :address_line_1, :address_line_2, :city, :postcode, :contact_number, :relationship) unless params[:next_of_kin].blank?
  end
end
