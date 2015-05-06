require "test_helper"

feature "Sign up for the website" do
  scenario "can sign up using Devise" do
    # Given a sign up form
    #visit root_path
    #click_on "Sign Up"
    visit new_user_registration_path

    # When I put in valid data
    fill_in("Email", with: "test@test.com")
    fill_in("Password", with: "testing123")
    fill_in("Password confirmation", with: "testing123")
    click_on("Sign up")

    # Then I expect to have successfully signed up
    page.text.must_include("signed up successfully")
    page.text.wont_include("problem with your sign up")
  end
end
