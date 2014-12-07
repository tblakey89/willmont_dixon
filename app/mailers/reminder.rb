class Reminder < ActionMailer::Base
  default from: "admin@allsafetowork.co.uk"

  def send_reminder user
    @user = user
    if @user.employer.email
      mail(to: @user.employer.email, cc: @user.email, subject: "Renewal Due for Pre Enrolment")
    else
      mail(to: @user.email, subject: "Renewal Due for Pre Enrolment")
    end
  end

  def send_completion user
  	@user = user
  	if @user.employer.email
      mail(to: @user.employer.email, cc: @user.email, subject: "Confirmation of Completion of Pre Enrolment")
    else
      mail(to: @user.email, subject: "Confirmation of Completion of Pre Enrolment")
    end
  end
end
