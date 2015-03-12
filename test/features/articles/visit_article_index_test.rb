require "test_helper"

feature "Visit the Article Index" do
  scenario "with existing articles, show list" do
    # Given an existing article

    # When I go to the articles page
    visit articles_path

    # Then I should see the existing article
    page.text.must_include(articles(:ror).title)
  end
end
