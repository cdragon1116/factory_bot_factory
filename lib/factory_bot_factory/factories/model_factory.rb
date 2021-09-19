module FactoryBotFactory
  class ModelFactory < BaseFactory
    def build_factory(name, value, level, _options = {})
      output = LineWriter.wrap_factory(name, value.class.name) do
        inner_output = []
        value.attributes.each do |key, value|
          inner_output += build_nested_attribute(value.class.name, key, value, 1, 1)
        end
        inner_output
      end
      output
    end
  end
end
