ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
ENV["MT_RAILS_NO_AUTORUN"] = "true"
require 'capybara/rails'
require 'capybara/poltergeist'
require 'minitest/rails'
require 'minitest/rails/capybara'
require 'policy_assertions'
Capybara.javascript_driver = :poltergeist

    Capybara.register_driver :poltergeist do |app|
    Capybara::Poltergeist::Driver.new(app,
                                      :phantomjs_options => ['--debug=no', '--load-images=no', '--ignore-ssl-errors=yes', '--ssl-protocol=TLSv1'], :debug => false)
  end

require "minitest/reporters"
reporter_options = { color: true }
Minitest::Reporters.use! [Minitest::Reporters::SpecReporter.new]

# Requires supporting ruby files with custom matchers and macros, etc,
# in test/support/ and its subdirectories.
Dir[Rails.root.join("test/support/**/*.rb")].each { |f| require f }

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

class ActionController::TestCase
  include Devise::TestHelpers
end

class ActionDispatch::IntegrationTest
  include Capybara::DSL
  include Capybara::Assertions
  include Warden::Test::Helpers
  
  CarrierWave.root = 'test/fixtures/files'
  def teardown
    Warden.test_reset!
  end
  Capybara.default_max_wait_time = 30
end
