require "test_helper"

feature "Showing the Project Index" do
  scenario "editors can view the project index and can see the uploader" do
    # Given I am signed in
    sign_in

    # Given projects in the database from fixtures

    # When I visit the projects path
    visit projects_path

    # Then I should see the projects
    page.text.must_include("How meta")
    page.text.must_include("Barnyard Cereal")

    # And I should see the uploader
    assert has_button?("Upload Image")
  end

  scenario "unauth'd users can view the project index but cannot see the uploader" do
    # Given I am not signed in

    # When I visit the projects path
    visit projects_path

    # Then I should see the projects
    page.text.must_include("How meta")
    page.text.must_include("Barnyard Cereal")

    # And I should not see the uploader
    refute has_button?("Upload Image")
  end
end
