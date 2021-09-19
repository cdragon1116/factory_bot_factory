require "json"
require "factory_bot_factory/version"
require 'factory_bot_factory/line_writer.rb'

# Load all Factories and Converters
Dir.glob("#{File.dirname(__FILE__)}/factory_bot_factory/factories/*").each { |file| require(file) }
Dir.glob("#{File.dirname(__FILE__)}/factory_bot_factory/converters/*").each { |file| require(file) }

module FactoryBotFactory
  class Error < StandardError; end
  class NestedToDeepError < Error; end

  def self.build(factory_name, klass, data, nested_level: 1, file_path: nil)
    raise NestedToDeepError, 'Only support 5 nested levels' if nested_level > 5

    factory(klass, data).new(
      factory_name: factory_name,
      nested_level: nested_level,
      file_path: file_path
    ).generate(data)
  rescue => e
    puts "Please check your input data and make sure you pass supported type of factory."
  end

  private

  def self.factory(klass, data)
    if data.respond_to?(:attributes) && klass == data.class
      Object.const_get("FactoryBotFactory::ModelFactory")
    else
      Object.const_get("FactoryBotFactory::#{klass}Factory")
    end
  end
end
