require "test_helper"

feature "Sign out from the website" do
  scenario "can successfully sign out from the website" do
    # Given that a user is signed into the website
    sign_in

    # When the user clicks "Sign Out"
    visit root_path
    click_on "Sign Out"

    # Then the user should be signed out
    page.text.must_include("Signed out successfully")
    page.text.must_include("Sign In")
  end
end
