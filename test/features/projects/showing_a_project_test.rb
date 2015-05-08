require "test_helper"

feature "Showing a single project" do
  scenario "editors can view a single project" do
    # Given I am signed in
    sign_in

    # Given projects already in the database from fixtures

    # When I visit a specific project's path
    visit project_path(projects(:portfolio).id)

    # Then I should see the technologies used
    page.text.must_include("Ruby, Rails, Zurb")
  end

  scenario "unauth'd users can view a single project" do
    # Given projects already in the database from fixtures

    # When I visit a specific project's path
    visit project_path(projects(:portfolio).id)

    # Then I should see the technologies used
    page.text.must_include("Ruby, Rails, Zurb")
  end
end
