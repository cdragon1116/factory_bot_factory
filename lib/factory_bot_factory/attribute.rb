require 'bigdecimal'
require 'date'

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
      elsif value.is_a?(DateTime) || value.is_a?(Time)
        FactoryBotFactory.config.date_time_converter.call(*options)
      elsif value.is_a?(Date)
        FactoryBotFactory.config.date_converter.call(*options)
      elsif value.is_a?(String) || value.is_a?(Symbol)
        FactoryBotFactory.config.string_converter.call(*options)
      elsif value.is_a?(Numeric)
        FactoryBotFactory.config.numeric_converter.call(*options)
      elsif value.is_a?(BigDecimal)
        FactoryBotFactory.config.big_decimal_converter.call(*options)
      elsif value.is_a?(Hash)
        FactoryBotFactory.config.hash_converter.call(*options)
      elsif value.is_a?(Array)
        FactoryBotFactory.config.array_converter.call(*options)
      else value.is_a?(OpenStruct)
        FactoryBotFactory.config.open_struct_converter.call(*options)
      end
    end
  end
end
