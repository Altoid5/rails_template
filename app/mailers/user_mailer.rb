class UserMailer < ApplicationMailer
  default from: "altoid.portales@gmail.com"

  def verification_code_email(user)
    @user = user
    mail(to: @user.email, subject: "Your UTRGV Login Code")
  end
end
