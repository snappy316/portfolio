require "test_helper"

feature "Contact Page" do
  scenario "visitor can send a message" do
    email = UserMailer.create_contact("test@example.com", "Test User")
    email.must_deliver_to("test@example.com")
  end
end
