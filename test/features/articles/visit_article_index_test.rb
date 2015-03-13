require "test_helper"

feature "Visit the Article Index" do
  scenario "unauth user can only see published articles" do
    # Given an unauthenticated user

    # When I go to the articles page
    visit articles_path

    # Then I should only see published articles, and no unpublished articles
    page.text.must_include(articles(:pub_ed).title)
    page.text.must_include(articles(:pub_au).title)
    page.text.wont_include(articles(:unpub_ed).title)
    page.text.wont_include(articles(:unpub_au).title)
  end

  scenario "author can only see their published/unpublished articles" do
    # Give an an author is signed
    sign_in(:author)

    # When I go to the articles page
    visit articles_path

    # Then I should only see my published/unpublished articles
    page.text.must_include(articles(:pub_au).title)
    page.text.must_include(articles(:unpub_au).title)
    page.text.wont_include(articles(:pub_ed).title)
    page.text.wont_include(articles(:unpub_ed).title)
  end

  scenario "editor can see all published and unpublished articles" do
    # Given an editor is signed in
    sign_in(:editor)

    # When I go to the articles page
    visit articles_path

    # Then I should see all articles, published and unpublished
    page.text.must_include(articles(:pub_ed).title)
    page.text.must_include(articles(:pub_au).title)
    page.text.must_include(articles(:unpub_ed).title)
    page.text.must_include(articles(:unpub_au).title)
  end
end
