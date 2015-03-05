require "test_helper"

feature "Editing an Article" do
  scenario "can edit an existing article" do
    # Given an existing article
    article = Article.create(title: 'Test Article', body: 'This is a test')
    visit article_path(article)

    #When I click edit and submit updated data
    click_on('Edit')
    fill_in 'Title', with: 'Updated Test Article'
    click_on('Update Article')

    #Then the article is updated
    page.text.must_include('Updated Test Article')
  end
end
