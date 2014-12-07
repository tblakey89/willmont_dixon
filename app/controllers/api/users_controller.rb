class Api::UsersController < ApplicationController
  require 'RMagick'
  before_filter :authenticate
  skip_before_filter :authorize, only: [:cscs_check]
  skip_before_filter :authenticate, only: [:cscs_check]
  skip_before_filter :verify_authenticity_token, :only => [:cscs_check, :update]

  def index
    @users = User.where("role < 2")
    respond_to do |format|
      format.json
      format.csv {send_data @users.to_csv}
      format.xls
    end
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
    if params[:file].blank? && params[:photo].blank?
      @user = User.find(params[:id])
      if @user.update_attributes(edit_params)
        render :show, id: @user.id, status: 200
      else
        render :json => { :errors => @user.errors }, status: 400
      end
    elsif params[:file] && params[:photo]
      @user = User.find(params[:id])
      current_user = @user.attributes
      if @user.update_attributes(new_params)
        directory = Rails.root.join("public", "images")
        extension = params[:file].original_filename[-4..-1]
        if @user.extension_valid? extension.downcase
          path = File.join(directory, @user.id.to_s + extension)
          @user.update_attributes(profile: @user.id.to_s + extension)
          File.open(path, "wb") { |f| f.write(params[:file].read) }
          img = Magick::Image::read(path).first
          img = img.resize_to_fit(200, 200)
          img.write(path)
          render :show, id: @user.id, status: 200
        else
          @user.update_attributes(@user.attributes)
          render json: { errors: { passport_photo: "There was a problem with the profile picture" } }
        end
      else
        render json: { errors: @user.errors }, status: 400
      end
    end
  #rescue
    #render nothing: true, status: 400
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
    errors = {}
    if params[:user][:last_name] && params[:user][:cscs_number] && params[:user][:national_insurance] 
      @user = User.where("lower(cscs_number) = ? and lower(national_insurance) = ?", params[:user][:cscs_number].downcase, params[:user][:national_insurance].downcase).first
      @user = User.create(cscs_number: params[:user][:cscs_number], role: 1, national_insurance: params[:user][:national_insurance], last_name: params[:user][:last_name]) if @user.nil? && params[:search].nil?
      if @user.id
        render :show_acc_info, id: @user.id, status: 200
      else
        errors[:message] = "Error: You have entered either your CSCS Card Number or Last Name incorrectly. Please check the information you have entered and try again." if @user.errors.messages[:cscs_number].blank?
        errors[:message] = "Error: You have entered either your National Insurance or Last Name incorrectly. Please check the information you have entered and try again." if @user.errors.messages[:national_insurance].blank?
        render json: { errors: errors }, status: 400
      end
    else
      errors[:last_name] = ["Your last name can't be blank"] if params[:user][:last_name].blank?
      errors[:national_insurance] = ["Your national insurance number can't be blank"] if params[:user][:national_insurance].blank?
      errors[:cscs_number] = ["Your CSCS number can't be blank"] if params[:user][:cscs_number].blank?
      render json: { errors: errors }, status: 400
    end
  end

  def find_by_auth_token
    @user = User.find_by(authentication_token: params[:auth_token])
    render :show, id: @user.id, status: 200
  end

  def submit_results
    current_user.update_attributes(completed_pre_enrolment: DateTime.now, pre_enrolment_due: 1.year.from_now, reminder: nil, exam_progress: nil)
    Reminder.send_completion(current_user).deliver
    render nothing: true, status: 200
  end

  def save_progress
    current_user.update_progress params[:progress]
    render nothing: true, status: 200
  end

private
  def edit_params
    params.require(:user).permit(:first_name, :last_name, :address_line_1, :address_line_2, :city, :postcode, :email, :job, :health_issues, :is_supervisor, :cscs_number, :cscs_expiry_date, :date_of_birth, :contact_number, :completed_pre_enrolment, :national_insurance, :lift_loads, :work_at_height, :scaffolder, :ground_worker, :operate_machinery) unless params[:user].blank?
  end

  def new_params
    params.permit(:first_name, :last_name, :address_line_1, :address_line_2, :city, :postcode, :email, :job, :health_issues, :is_supervisor, :cscs_number, :cscs_expiry_date, :date_of_birth, :contact_number, :completed_pre_enrolment, :national_insurance, :lift_loads, :work_at_height, :scaffolder, :ground_worker, :operate_machinery) unless params.blank?
  end

  def cscs_params
    params.require(:user).permit(:last_name, :cscs_number, :cscs_expiry_date, :national_insurance)
  end

end
