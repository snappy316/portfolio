require "test_helper"

feature "Deleting an Article" do
  scenario "can delete an existing article" do
    # Given an existing article
    Article.create(title: 'Bad Press', body: 'Alcohol can cause bad mistakes')
    visit articles_path

    # When I click "destroy"
    click_on('Destroy')

    # Then the article should no longer appear in the list
    page.text.wont_include('Bad Press')
  end
end
