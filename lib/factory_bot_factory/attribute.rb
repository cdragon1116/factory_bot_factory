module FactoryBotFactory
  class Attribute
    attr_reader :key, :value, :options

    def initialize(key, value, options = {})
      @key     = key
      @value   = value
      @options = options
    end

    def build
      options = [key, value, options]

      values = if value.nil? || value == "null"
        FactoryBotFactory.config.nil_converter.call(*options)
      elsif value.is_a?(String) || value.is_a?(Symbol)
        FactoryBotFactory.config.string_converter.call(*options)
      elsif value.is_a?(Numeric)
        FactoryBotFactory.config.numertic_converter.call(*options)
      elsif value.is_a?(Hash) || value.is_a?(Array)
        FactoryBotFactory.config.hash_converter.call(*options)
      else value.is_a?(OpenStruct)
        FactoryBotFactory.config.open_struct_converter.call(*options)
      end
    end
  end
end
