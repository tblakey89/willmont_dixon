class Api::UsersController < ApplicationController
  before_filter :authenticate
  skip_before_filter :authorize, only: [:cscs_check]
  skip_before_filter :authenticate, only: [:cscs_check]

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

  def cscs_check
    if params[:user][:cscs_number]
      @user = User.find_by(cscs_number: params[:user][:cscs_number])
      @user = User.create(cscs_number: params[:user][:cscs_number], role: 1) if @user.nil?
      if @user.errors.blank?
        render :show_acc_info, id: @user.id, status: 200
      else
        render json: { errors: @user.errors }, status: 400
      end
    else
      render json: { errors: { cscs_number: ["Your CSCS number can't be  blank"] } }, status: 400
    end
  end

  def find_by_auth_token
    @user = User.find_by(authentication_token: params[:auth_token])
    render :show, id: @user.id, status: 200
  end

  def submit_results
    current_user.update_attributes(completed_pre_enrolment: DateTime.now, pre_enrolment_due: 1.year.from_now)
    render nothing: true, status: 200
  end

private
  def edit_params
    params.require(:user).permit(:first_name, :last_name, :address_line_1, :address_line_2, :city, :postcode, :email, :job, :health_issues, :is_supervisor, :cscs_number, :cscs_expiry_date, :date_of_birth, :contact_number, :completed_pre_enrolment, :national_insurance, :lift_loads, :work_at_height, :scaffolder, :ground_worker, :operate_machinery) unless params[:user].blank?
  end

  def cscs_params
    params.require(:user).permit(:last_name, :cscs_number, :cscs_expiry_date, :national_insurance)
  end

end
