require 'simplecov'
SimpleCov.start 'rails'

# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../spec/dummy/config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'vcr'
require 'rake'
require 'elasticsearch/extensions/test/cluster/tasks'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/../../spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  config.extend ControllerMacros, :type => :controller

  config.before :suite do
    Elasticsearch::Extensions::Test::Cluster.start(port: 9200) unless Elasticsearch::Extensions::Test::Cluster.running?(on: 9200)
  end

  config.after :suite do
    Elasticsearch::Extensions::Test::Cluster.stop(port: 9200) if Elasticsearch::Extensions::Test::Cluster.running?(on: 9200)
  end
end

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassette_library'
  c.hook_into :fakeweb
  c.configure_rspec_metadata!
  c.allow_http_connections_when_no_cassette = true
end
