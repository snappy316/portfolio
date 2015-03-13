require "test_helper"

feature "Editing an Article" do
  scenario "author can edit own articles" do
    # Given I am signed in as an author
    sign_in(:author)

    # When I edit one of my articles
    visit edit_article_path(articles(:unpub_au).id)
    fill_in('Body', with: 'This is an edited article')
    click_on('Update Article')

    # Then the article should be updated
    page.text.must_include('This is an edited article')
  end

  scenario "author cannot edit other people's articles" do
    # Given I am signed in as an author
    sign_in(:author)

    # When I view the editor's articles
    visit article_path(articles(:pub_ed).id)

    # Then I should not see an "Edit" link
    page.wont_have_link('Edit')

    # When I try to hack it and go to the edit path
    visit edit_article_path(articles(:pub_ed).id)

    # Then I should see an unauthorized message
    page.text.must_include('You are not authorized')
  end

  scenario "editor can edit any article" do
    # Given I am signed in as an editor
    sign_in(:editor)

    # When I edit an author's article
    visit edit_article_path(articles(:ror).id)
    fill_in('Body', with: '...is awesome!')
    click_on('Update Article')

    # Then the article should be updated
    page.text.must_include('is awesome')
  end

  scenario "unauthenticated users cannot edit" do
    # Given I am not signed in
    # When I visit the index path
    visit articles_path

    # Then I should not see an "Edit" link
    page.wont_have_link('Edit')

    # When I visit an individual article page
    visit article_path(articles(:ror).id)

    # Then I should not see an "Edit" link
    page.wont_have_link('Edit')

    # When I try to hack it and go to the edit path
    visit edit_article_path(articles(:ror).id)

    # Then I should be redirected to login
    page.text.must_include('You need to sign in or sign up')
  end
end
