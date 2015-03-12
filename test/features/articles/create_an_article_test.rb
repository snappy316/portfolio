require "test_helper"

feature "Creating an Article" do
  scenario "submit an article" do
    # Given a user is signed in, and new article form is filled out
    sign_in

    visit new_article_path
    fill_in('Title', with: articles(:ror).title)
    fill_in('Body', with: articles(:ror).body)

    # When I submit the form
    click_on('Create Article')

    # Then a new article is created and displayed
    page.text.must_include("Article was successfully created")
    page.text.must_include(articles(:ror).title)
    page.has_css?("#author")
    page.text.must_include users(:bit).email
  end
end
