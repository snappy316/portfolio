# require 'simplecov'
# SimpleCov.start

require "simplecov"
require "coveralls"

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter
]
SimpleCov.start('rails')

ENV["RAILS_ENV"] = "test"
require File.expand_path("../../config/environment", __FILE__)
require "rails/test_help"
require 'capybara/poltergeist'
require "minitest/rails"
require "minitest/rails/capybara"
require "minitest/reporters"

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, debug: true, js_errors: true)
end

Capybara.javascript_driver = :poltergeist

class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!
  fixtures :all
end

def sign_in(role = :editor)
  visit new_user_session_path
  fill_in('Email', with: users(role).email)
  fill_in('Password', with: "password")
  click_on('Log in')
end

def fill_in_form(article = :ror)
  fill_in('Title', with: articles(article).title)
  fill_in('Body', with: articles(article).body)
end
