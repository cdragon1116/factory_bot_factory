module FactoryBotFactory
  module Converters
    class StringConverter
      def self.call(key, value, options = {})
        "\"#{value}\""
      end
    end
  end
end
