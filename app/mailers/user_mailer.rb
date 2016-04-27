class UserMailer < ApplicationMailer
  default from: 'fake@example.com'

  def goodbye_email(user)
    @user = user
    @url = 'http://rottenmangoes.example'
    mail(to: @user.email, subject: 'Your account was deleted!')
  end
end

