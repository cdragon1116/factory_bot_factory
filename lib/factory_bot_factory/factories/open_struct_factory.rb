require 'factory_bot_factory/factories/base_factory.rb'

module FactoryBotFactory
  class OpenStructFactory < BaseFactory
    def build_factory(name, value, level)
      output = LineWriter.wrap_factory(name, 'OpenStruct') do
        inner_output = []
        value = value.attributes if value.respond_to?(:attributes)
        value = value.to_h if value.respond_to?(:to_h)
        value.each do |key, value|
          value = build_nested_attribute(name, key, value, 1, level)
          inner_output += value
          inner_output
        end
        inner_output << "to_create {}"
      end
      output
    end
  end
end
