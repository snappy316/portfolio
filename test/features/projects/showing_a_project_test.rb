require "test_helper"

feature "Showing a single project" do
  scenario "can view a single project" do
    # Given projects already in the database from fixtures

    # When I visit a specific project's path
    visit project_path(projects(:portfolio).id)

    # Then I should see the technologies used
    page.text.must_include("Ruby, Rails, Zurb")
  end
end
