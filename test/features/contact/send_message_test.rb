require "test_helper"

feature "Contact Page" do
  scenario "visitor can send a message" do
    skip
    email = UserMailer.contact_email(Contact.new(email: "test@example.com", name: "Test User", message: "test"))
    email.must_deliver_to("test@example.com")
  end
end
