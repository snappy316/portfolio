require "test_helper"

feature "Visit the Article Index" do
  scenario "with existing articles, show list" do
    # Given an existing article
    Article.create(title: 'Example title', body: 'body')

    # When I go to the articles page
    visit articles_path

    # Then I should see the existing article
    page.text.must_include("Example title")
  end
end
