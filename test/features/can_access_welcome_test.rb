require "test_helper"

class CanAccessWelcomeTest < Capybara::Rails::TestCase
  def test_homepage_has_content
    visit root_path
    page.text.must_include("Hi, I'm David")
  end
end
