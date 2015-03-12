require "test_helper"

feature "Deleting an Article" do
  scenario "can delete an existing article" do
    # Given an existing article (created in the fixtures)
    sign_in
    article = articles(:ror)

    # When I click "destroy"
    visit articles_path
    click_on('Destroy')

    # Then the article should no longer appear in the list
    page.text.wont_include(article.title)
  end
end
