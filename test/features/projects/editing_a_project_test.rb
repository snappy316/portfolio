require "test_helper"

feature "Editing a Project" do
  scenario "can edit a project with valid data" do
    # Given an existing project, and valid data entered into the "edit" form
    skip
    visit edit_project_path(projects(:portfolio))
    fill_in("Name", with: "Awesome Portfolio")

    # When I submit the form
    click_on("Update Project")

    # Then it should show the updated project
    page.text.must_include("Project was successfully updated")
    page.text.must_include("Awesome Portfolio")
    page.text.wont_include("Code Fellows Portfolio")
  end

  scenario "cannot edit a project with invalid data" do
    # Given an existing project, and invalid data entered into the "edit" form
    visit edit_project_path(projects(:portfolio))
    fill_in("Name", with: "Q")
    fill_in("Technologies used", with: "")

    # When I submit the form
    click_on("Update Project")

    # Then I should get an error message, and the form should be displayed again
    current_path.must_match(/projects/)
    page.text.must_include("prohibited")
    page.text.must_include("Name is too short")
    page.text.must_include("Technologies used can't be blank")
  end
end
