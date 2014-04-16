class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :authorize

  delegate :allow?, to: :current_permission
  helper_method :allow?

  delegate :allow_param?, to: :current_permission
  helper_method :allow_param?

  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:first_name, :last_name, :date_of_birth, :email, :national_insurance, :cscs_number, :cscs_expiry_date, :role, :postcode, :contact_number, :password, :password_confirmation) }
  end

  def current_permission
    @current_permission ||= Permission.new(current_user)
  end

  def current_resource
    nil
  end

  def authorize
    if request.headers["auth-token"].present?
      @current_user = User.find_by_authentication_token(request.headers["auth-token"])
    end
    if current_permission.allow?(params[:controller], params[:action], current_resource)
      true
    else
      if @current_user
        render status: 401, json: { id: @current_user.id, role: @current_user.role, controller: params[:controller], action: params[:action], status: false, info: "You are not allowed to view this inforation" }
      else
        render status: 401, json: { status: false, info: "Please log in" }
      end
    end
  end

  def authenticate
    if request.headers["auth-token"].present?
      @current_user = User.find_by_authentication_token(request.headers["auth-token"])
      unless @current_user
        render status: 401, json: { status: false, info: request.headers["auth-token"], data: {} }
      end
    else
      render status: 401, json: { status: false, info: "You are not logged in", data: {} }
    end
  end

  def record_not_found
    render nothing: true, status: 404
  end
end
