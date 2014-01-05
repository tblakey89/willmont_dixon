def sign_in_user
  user = double(User)
  allow_message_expectations_on_nil
  request.env['warden'].stub(:authenticate).and_return(user)
  ApplicationController.any_instance.stub(:current_user).and_return(user)
  ApplicationController.any_instance.stub(:authorize).and_return(true)
end
