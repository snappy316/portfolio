require 'test_helper'

feature "Adding a Comment" do
  scenario "visitor can add a comment, but will not immediately appear" do
    # Given I am an unauthenticated user (visitor)

    # When I visit an article, and add a comment
    visit article_path(articles(:ror).id)
    fill_in('New comment', with: 'Trolling!')
    click_on('Create Comment')

    # Then I should see a message saying "Submitted", but the comment should not appear on the page
    page.text.must_include('Comment submitted for approval')
    page.text.wont_include('Trolling')
  end
end
