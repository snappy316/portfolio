class Contact < MailForm::Base
  attribute :name, validate: true
  attribute :email, validate: /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attribute :message
  attribute :nickname, captcha: true

  def headers
    {
      subject: "dker.us contact",
      to: "snappy316@gmail.com",
      from: 'dave@daknotes.com'
    }
  end
end
