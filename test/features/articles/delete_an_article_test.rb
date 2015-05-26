require "test_helper"

feature "Deleting an Article" do
  scenario "editors can delete articles" do
    # Given I am signed in as an editor
    sign_in(:editor)

    # When I visit the article index page
    visit articles_path

    # Then I can see and click on "Delete" to delete an article
    page.text.must_include('Delete')
    page.first('.article').click_on('Delete')

    # When I visit an individual article's page
    visit article_path(articles(:pub_au).id)

    # Then I can see and click on "Delete" to delete an article
    page.text.must_include('Delete')
    page.first('.article_links').click_on('Delete')
  end

  scenario "authors cannot delete articles" do
    # Given I am signed in as an author
    sign_in(:author)

    # When I visit the article index page
    visit articles_path

    # Then I cannot see a "Delete" link
    page.text.wont_include('Delete')

    # When I visit an individual article's page
    visit article_path(articles(:unpub_au).id)

    # Then I cannot see a "Delete" link
    page.text.wont_include('Delete')
  end

  scenario "unauthorized users cannot delete articles" do
    # Given I am not signed in

    # When I visit the article index page
    visit articles_path

    # Then I cannot see a "Delete" link
    page.text.wont_include('Delete')

    # When I visit an individual article's page
    visit article_path(articles(:unpub_au).id)

    # Then I cannot see a "Delete" link
    page.text.wont_include('Delete')
  end
end
