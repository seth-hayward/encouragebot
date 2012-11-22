class UserMailer < ActionMailer::Base
  default from: "no-reply@encouragebot.com"

  def welcome_email(user)
  	@user = user
  	@url = "http://encouragebot.heroku.com/login"
  	mail(:to => user.email, :subject => "Welcome to Encourage Bot")
  end
end
