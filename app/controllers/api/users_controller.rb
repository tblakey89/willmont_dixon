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
    if params[:user][:last_name] && (params[:user][:cscs_number] || params[:user][:national_insurance])
      if !params[:user][:cscs_number].blank?
        @user = User.find_by(cscs_number: params[:user][:cscs_number])
        @user = User.create(cscs_number: params[:user][:cscs_number], role: 1, national_insurance: params[:user][:national_insurance], last_name: params[:user][:last_name]) if @user.nil? && params[:search].nil?
      elsif !params[:user][:national_insurance].blank?
        @user = User.find_by(national_insurance: params[:user][:national_insurance])
        @user = User.create(national_insurance: params[:user][:national_insurance], role: 1, last_name: params[:user][:last_name], cscs_number: params[:user][:cscs_number]) if @user.nil? && params[:search].nil?
      end
      if @user && @user.errors.blank?
        render :show_acc_info, id: @user.id, status: 200
      else
        if @user
          render json: { errors: @user.errors }, status: 400
        else
          render nothing: true, status: 400
        end
      end
    else
      if params[:user][:last_name].blank? && params[:user][:cscs_number].blank? && params[:user][:national_insurance].blank?
        render json: { errors: { last_name: ["Your last name can't be blank"], cscs_number: ["Your CSCS number or national insurance number can't be blank"], national_insrance: ["Your national insurance number or your CSCS number can't be blank"] } }, status: 400
      elsif params[:user][:last_name].blank?
        render json: { errors: { last_name: ["Your last name can't be blank"] } }, status: 400
      else
        render nothing: true, status: 400
      end
    end
  end

  def find_by_auth_token
    @user = User.find_by(authentication_token: params[:auth_token])
    render :show, id: @user.id, status: 200
  end

  def submit_results
    current_user.update_attributes(completed_pre_enrolment: DateTime.now, pre_enrolment_due: 1.year.from_now, reminder: nil)
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
