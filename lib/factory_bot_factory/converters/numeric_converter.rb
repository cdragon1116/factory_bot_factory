module FactoryBotFactory
  module Converters
    class NumericConverter
      def self.call(key, value)
        ["#{key} { #{value} }"]
      end
    end
  end
end
