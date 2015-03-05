require "test_helper"

feature "Editing an Article" do
  scenario "can edit an existing article" do
    # Given an existing article
    article = articles(:ror)
    visit article_path(article)

    #When I click edit and submit updated data
    click_on('Edit')
    fill_in 'Body', with: '...is incredibly awesome!'
    click_on('Update Article')

    #Then the article is updated
    page.text.must_include('Article was successfully updated')
    page.text.must_include('is incredibly awesome')
  end
end
