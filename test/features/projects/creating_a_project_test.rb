require "test_helper"

feature "Projects" do
  scenario "can add a new project" do
    # Given a projects resource
    visit projects_path
    click_on("New Project")

    # When I fill-in and submit a new project form
    fill_in("Name", with: "Test Project")
    fill_in("Technologies used", with: "Test Description")
    click_on("Create Project")

    # Then I should see the new project
    page.text.must_include("Project has been created")
    page.text.must_include("Test Project")
  end
end
