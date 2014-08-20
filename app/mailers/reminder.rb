class Reminder < ActionMailer::Base
  default from: "admin@allsafetowork.co.uk"

  def send_reminder user
    @user = user
    mail(to: @user.email, subject: "Pre enrolment overdue")
  end
end
