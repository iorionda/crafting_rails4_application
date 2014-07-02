class ContactForm < MailForm::Base
  attributes :name, :email, :message

  def headers
    { to: "recepient@example.com", from: self.email }
  end
end
