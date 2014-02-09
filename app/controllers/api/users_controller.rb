class Api::UsersController < ApplicationController
  before_filter :authenticate

  def index
    @users = User.where("role < 2")
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      render :show, id: @user.id, status: 201
    else
      render :json => { :errors => @user.errors }, status: 400
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(edit_params)
      render :show, id: @user.id, status: 200
    else
      render :json => { :errors => @user.errors }, status: 400
    end
  rescue
    render nothing: true, status: 400
  end

  def destroy
    User.find(params[:id]).destroy
    render nothing: true, status: 204
  end

  def disciplinary_cards
    user = User.find(params[:id])
    @disciplinary_cards = user.disciplinary_cards
  end

private
  def edit_params
    params.require(:user).permit(:first_name, :last_name, :address_line_1, :address_line_2, :city, :postcode, :email, :job, :health_issues, :is_supervisor, :cscs_number, :cscs_expiry_date, :date_of_birth, :contact_number, :completed_pre_enrolment) unless params[:user].blank?
  end

end
