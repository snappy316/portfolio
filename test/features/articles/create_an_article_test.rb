require "test_helper"

feature "Creating an Article" do
  scenario "author can create an article and will be unpublished" do
    # Given I am signed in as an author, and new article form is filled out
    sign_in(:author)

    visit new_article_path
    fill_in_form(:unpub_au)

    # When I submit the form
    click_on('Create Article')

    # Then a new article is created and displayed
    page.text.must_include("Article was successfully created")
    page.text.must_include(articles(:unpub_au).title)
    page.has_css?("#author")
    page.text.must_include(users(:author).email)
    page.text.must_include("Status: Unpublished")
  end

  scenario "unauthenticated site visitors cannot access new_article_path" do
    # Given I am not authenticated
    # When I visit the new article page
    visit new_article_path

    # Then I should be denied and redirected
    page.must_have_content("You need to sign in or sign up before continuing")
  end

  scenario "unauthenticated site visitors cannot see new article button" do
    # Given I am not authenticated
    # When I visit the blog index page
    visit articles_path

    # Then I should not see the "New Article" button
    page.wont_have_link("New Article")
  end

  scenario "authors can't publish" do
    # Given I am signed in as an author
    sign_in(:author)

    # When I visit the new page
    visit new_article_path

    # Then I should not see a checkbox for published
    page.wont_have_field('Published')
  end

  scenario "editors can publish" do
    # Given I am signed in as an editor
    sign_in(:editor)

    # When I visit the new page
    visit new_article_path

    # Then I should see a checkbox for published
    page.must_have_field('Published')

    # When I submit the form
    fill_in_form(:pub_ed)
    check('Published')
    click_on('Create Article')

    # Then I should see the published article
    page.text.must_include("Status: Published")
  end
end
