class UserMailer < ApplicationMailer
  default to: 'snappy316@gmail.com'

  def contact_email(user)
    @user = user
    mail(from: 'dave@daknotes.com', subject: 'dker.us contact')
  end
end
