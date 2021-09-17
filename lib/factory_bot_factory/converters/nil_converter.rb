module FactoryBotFactory
  module Converters
    class NilConverter
      def self.call(key, value)
        ["#{key} { nil }"]
      end
    end
  end
end
