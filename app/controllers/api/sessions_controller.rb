class Api::SessionsController < Devise::SessionsController
  skip_before_filter :verify_authenticity_token, if: Proc.new { |c| c.request.format == 'application/json' }
  before_filter :authenticate_user!, :only => [:destroy]
  skip_before_filter :authorize

  respond_to :json

  def create
    user = User.find_by_email(params[:user][:email])

    if user && user.valid_password?(params[:user][:password])
      current_user = User.find_by_email(params[:user][:email])
      warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#failure")
      current_user.reset_authentication_token
      current_user.save
      p current_user.errors
      render status: 200, json: { success: true, info: "Logged in", user: current_user, auth_token: current_user.authentication_token }
    else
      render status: 401, json: { status: false, info: "Login failed", data: {} }
    end
  end

  def destroy
    warden.authenticate!(scope: resource_name, recall: "#{controller_path}#failure")
    current_user.update_column(:authentication_token, nil)
    render status: 200, json: { success: true, info: "Logged out", data: {} }
  end

  def failure
    render status: 401, json: { status: false, info: "Login failed", data: {} }
  end
end
