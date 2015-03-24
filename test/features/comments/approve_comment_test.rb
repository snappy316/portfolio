require 'test_helper'

feature "Approving comments" do
  scenario "unauthorized users cannot approve comments" do
    # Given I am not signed in

    # When I visit an articles page
    visit article_path(articles(:pub_au).id)

    # Then I should only see approved comments
    page.text.must_include("Approved Comment")
    page.text.wont_include("Unapproved Comment")
  end

  scenario "authors cannot approve comments" do
    # Given I am signed in as an author
    sign_in(:author)

    # When I visit an articles page
    visit article_path(articles(:pub_au).id)

    # Then I should only see approved comments
    page.text.must_include("Approved Comment")
    page.text.wont_include("Unapproved Comment")
  end

  scenario "editors can approve comments" do
    # Given I am signed in as an editor
    sign_in(:editor)

    # When I visit an articles page
    visit article_path(articles(:pub_au).id)

    # Then I should see unapproved comments
    page.text.must_include('Unapproved Comment')

    # When I approve a comment
    click_on("Approve")

    # Then I should see it as approved
    page.text.must_include('Approved')
  end
end
