require "test_helper"

class CanAccessWelcomeTest < Capybara::Rails::TestCase
  def test_homepage_has_content
    visit root_path
    assert page.has_content?("Hi, I'm David")
  end
end
