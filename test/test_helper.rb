require 'simplecov'

SimpleCov.start

ENV['RAILS_ENV'] = 'test'

require File.expand_path('../../test/dummy/config/environment.rb', __FILE__)
ActiveRecord::Migrator.migrations_paths = [File.expand_path('../../test/dummy/migrate', __FILE__)]
ActiveRecord::Migrator.migrations_paths << File.expand_path('../../db/migrate', __FILE__)
require 'rails/test_help'

Minitest.backtrace_filter = Minitest::BacktraceFilter.new

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

if ActiveSupport::TestCase.respond_to?(:fixture_path=)
  ActiveSupport::TestCase.fixture_path = File.expand_path('../fixtures', __FILE__)
  ActiveSupport::TestCase.fixtures :all
end

module Knock
  class MyCustomException < StandardError
  end
end

class ActiveSupport::TestCase
  setup :reset_knock_configuration

  private

  def reset_knock_configuration
    knock.token_signature_algorithm = 'HS256'
    knock.token_secret_signature_key = -> { Rails.application.secrets.secret_key_base }
    knock.token_public_key = nil
    knock.token_audience = nil
    knock.token_lifetime = 1.day
  end
end
