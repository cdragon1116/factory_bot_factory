module FactoryBotFactory
  module Converters
    class NumericConverter
      def self.call(key, value, options = {})
        value.to_s
      end
    end
  end
end
