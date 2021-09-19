module FactoryBotFactory
  module Converters
    class DateTimeConverter
      def self.call(key, value, options = {})
        "\"#{value}\""
      end
    end
  end
end
