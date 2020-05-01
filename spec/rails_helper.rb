if ENV.fetch("COVERAGE", false)
  require "simplecov"

  SimpleCov.profiles.define "coverage" do
    load_profile "rails"
    # Don't include vendored stuff
    add_filter ".vendor"
    add_filter "lib/tasks"
  end

  if ENV["CIRCLE_ARTIFACTS"]
    dir = File.join(ENV["CIRCLE_ARTIFACTS"], "coverage")
    SimpleCov.coverage_dir(dir)
  end

  SimpleCov.start "coverage"
end

ENV["RACK_ENV"] ||= "test"

require File.expand_path("../config/environment", __dir__)

require "rspec/rails"
require "sidekiq/testing"
require "cancan/matchers"
require "sidekiq/testing"

Sidekiq::Testing.fake!

Dir[Rails.root.join("spec", "support", "**", "*.rb")].sort.each { |file| require file }

RSpec.configure do |config|
  config.include ActiveSupport::Testing::TimeHelpers, type: :service
  config.infer_base_class_for_anonymous_controllers = false
  config.infer_spec_type_from_file_location!
  config.use_transactional_fixtures = false

  config.expect_with :rspec do |expectations|
    expectations.syntax = :expect
  end

  config.mock_with :rspec do |mocks|
    mocks.syntax = :expect
    mocks.verify_partial_doubles = true
  end

  config.example_status_persistence_file_path = "tmp/rspec_examples.txt"
  config.order = :random
end

Faker::Config.locale = "ru"
ActiveRecord::Migration.maintain_test_schema!
