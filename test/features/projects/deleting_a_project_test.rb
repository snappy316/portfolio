require "test_helper"

feature "Deleting a project" do
  scenario "can delete a project" do
    # Given projects in the database from fixtures

    # When I click "Destroy" on a project's show page
    visit project_path(projects(:portfolio).id)
    click_on("Destroy")

    # Then I should not see the project on the index
    visit projects_path
    page.text.wont_include("How meta")
  end
end
