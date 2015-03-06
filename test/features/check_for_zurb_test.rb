require "test_helper"

feature "Zurb Foundation" do
  scenario "Foundation is styling the home page" do
    visit root_path
    page.must_have_css('div.columns')
  end
end
