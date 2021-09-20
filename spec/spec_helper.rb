require "bundler/setup"
require "pry"
require "json"
require "factory_bot"
require "factory_bot_factory"
require "shared_context/factory"
require "active_record"
require "helpers/configration"
require "initializers/active_record"
require "initializers/factory_bot_factory"

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
  config.include Helpers::Configuration

  config.around do |example|
    ActiveRecord::Base.transaction do
      example.run

      raise ActiveRecord::Rollback
    end
  end

  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
