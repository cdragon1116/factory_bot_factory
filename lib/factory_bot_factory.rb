require "json"
require "factory_bot_factory/version"

# Load all Factories and Converters
Dir.glob("#{File.dirname(__FILE__)}/factory_bot_factory/converters/*").each { |file| require(file) }
require "factory_bot_factory/config"

require 'factory_bot_factory/base.rb'
require 'factory_bot_factory/line_writer.rb'
require 'factory_bot_factory/file_writer.rb'
Dir.glob("#{File.dirname(__FILE__)}/factory_bot_factory/factories/*").each { |file| require(file) }


module FactoryBotFactory
  class Error < StandardError; end
  class NestedToDeepError < Error; end
  class FileExistsError < ::FactoryBotFactory::Error; end
  class FactoryExistsError < ::FactoryBotFactory::Error; end

  class << self
    def build(data, options = {})
      configure

      Base.build(data, options)
    end

    def configure
      yield config if block_given?
      config
    end

    def config
      @_config ||= Config.new
    end
  end
end
