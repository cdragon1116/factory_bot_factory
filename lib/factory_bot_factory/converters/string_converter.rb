module FactoryBotFactory
  module Converters
    class StringConverter
      def self.call(key, value)
        ["#{key} { \"#{value}\" }"]
      end
    end
  end
end
