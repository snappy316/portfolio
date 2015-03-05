require "test_helper"

feature "Creating an Article" do
  scenario "submit an article" do
    # Given a new article form is filled out
    visit new_article_path
    fill_in('Title', with: 'New Article')
    fill_in('Body', with: 'Content of the Article')

    # When I submit the form
    click_on('Create Article')

    #Then a new article is created and displayed
    page.text.must_include('New Article')
  end
end
