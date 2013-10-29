class AdminMailer < ActionMailer::Base
  default from: "no-reply@wishable-production.herokuapp.com"

  def send_validation(user, wish)
  	@user = user
  	@wish = wish

  	mail(to: "brian@bkenny.com", subject: "A new wish has been posted")
  end
end
