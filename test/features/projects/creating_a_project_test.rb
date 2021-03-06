require "test_helper"

feature "Creating a Project" do
  scenario "editors can add a new project" do
    # Given an editor is signed in
    sign_in

    # Given the form is filled in with valid data
    visit new_project_path
    fill_in("Name", with: "Test Project")
    fill_in("Technologies used", with: "Test Description")

    # When I submit the form
    click_on("Create Project")

    # Then I should see the new project
    page.text.must_include("Project has been created")
    page.text.must_include("Test Project")

  end

  scenario "editors cannot add a new project with invalid data" do
    # Given an editor is signed in
    sign_in

    # Given the form is filled in with invalid data
    visit new_project_path
    fill_in("Name", with: "A")
    fill_in("Technologies used", with: "")

    # When I submit the form
    click_on("Create Project")

    # Then I should get an error message, and the form should be displayed again
    current_path.must_match(/projects$/)
    page.text.must_include("Project could not be saved")
    page.text.must_include("Name is too short")
    page.text.must_include("Technologies used can't be blank")
  end

  scenario "unauth'd users cannot add new projects" do
    # Given a user is not signed in

    # When I go to the new projects path
    visit new_project_path

    # Then I should be denied and redirected
    page.must_have_content("You are not authorized to perform this action")
  end
end
