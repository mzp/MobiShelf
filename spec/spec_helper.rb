# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'rspec/rails'
require 'wisper/rspec/matchers'

ActiveJob::Base.queue_adapter = :test
ActiveRecord::Migration.maintain_test_schema!

Dir[Rails.root.join('spec', 'support', '*.rb')].each { |f| require f }

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.before(:suite) do
    DatabaseRewinder.clean_all
  end

  config.after(:each) do
    DatabaseRewinder.clean
  end

  config.include FactoryGirl::Syntax::Methods
  config.include JsonSpec::Helpers
  config.include RSpec::Benchmark::Matchers
  config.include FactoryGirlHelper
  config.include Wisper::RSpec::BroadcastMatcher

  config.example_status_persistence_file_path = 'spec/examples.txt'
  config.filter_rails_from_backtrace!
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.infer_spec_type_from_file_location!
  config.order = :random
  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.use_transactional_fixtures = false
end
