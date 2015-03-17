require 'test_helper'

feature "Approving comments" do
  scenario "authors can approve comments" do
    # Given I am signed in as an author
    sign_in(:author)

    # When I visit an articles page
    visit article_path(articles(:pub_au).id)

    # Then I should see unapproved comments
    page.text.must_include('Unapproved')

    # When I approve a comment
    click_on("Approve")

    # Then I should see it as approved
    page.text.must_include('Approved')
  end

  scenario "editors can approve comments" do
    # Given I am signed in as an editor

    # When I visit an articles page
    visit article_path(articles(:pub_ed).id)

    # Then I should see unapproved comments
    page.text.must_include('Unapproved')

    # When I approve a comment
    click_on("Approve")

    # Then I should see it as approved
    page.text.must_include('Approved')
  end
end
