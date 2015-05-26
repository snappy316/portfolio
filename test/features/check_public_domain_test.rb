require "test_helper"

feature "Public Domain dker.us" do
  scenario "Website is live" do
    skip
    visit('http://dker.us')
    page.text.must_include("Hi, I'm David!")
  end
end
