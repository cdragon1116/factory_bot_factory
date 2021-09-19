require 'factory_bot_factory/factories/base_factory.rb'

module FactoryBotFactory
  class HashFactory < BaseFactory
    def build_factory(name, value, level)
      output = LineWriter.wrap_factory(name, 'Hash') do
        inner_output = []
        value = value.attributes if value.respond_to?(:attributes)
        value = value.to_h if value.respond_to?(:to_h)
        value.each do |key, value|
          inner_output += build_nested_attribute(name, key, value, 1, level)
        end
        inner_output << "initialize_with { attributes }"
        inner_output
      end
      output
    end
  end
end
