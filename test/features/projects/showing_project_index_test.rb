require "test_helper"

feature "Showing the Project Index" do
  scenario "can view the project index" do
    # Given projects in the database from fixtures

    # When I visit the projects path
    visit projects_path

    # Then I should see the projects
    page.text.must_include("How meta")
    page.text.must_include("Barnyard Cereal")
  end
end
