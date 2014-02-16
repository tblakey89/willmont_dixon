class Api::EmployersController < ApplicationController
  before_filter :load_user
  before_filter :authenticate

  def index
    @employers = @user.employers
  end

  def show
    @employer = @user.employers.find(params[:id])
  end

  def create
    @employer = @user.employers.new(safe_params)
    if @employer.save
      render :show, user_id: @user.id, id: @employer.id, status: 201
    else
      render :json => { :errors => @employer.errors }, status: 400
    end
  end

  def update
    @employer = @user.employers.find(params[:id])
    if @employer.update_attributes(safe_params)
      render :show, user_id: @user.id, id: @employer.id, status: 200
    else
      render :json => { :errors => @employer.errors }, status: 400
    end
  end

  def destroy
    @employer = @user.employers.find(params[:id]).destroy
    render nothing: true, status: 204
  end

private
  def load_user
    @user = User.find(params[:user_id])
  end

  def safe_params
    params.require(:employer).permit(:company_name, :address_line_1, :address_line_2, :city, :postal_code, :contact_number) unless params[:employer].blank?
  end
end
