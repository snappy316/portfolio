ENV["RAILS_ENV"] = "test"
require File.expand_path("../../config/environment", __FILE__)
require 'capybara/poltergeist'
require "minitest/rails"
require "minitest/rails/capybara"
require "minitest/reporters"
require "rails/test_help"

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, debug: true, js_errors: true)
end

Capybara.javascript_driver = :poltergeist

class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!
  fixtures :all
end
