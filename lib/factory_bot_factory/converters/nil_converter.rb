module FactoryBotFactory
  module Converters
    class NilConverter
      def self.call(key, value, options = {})
        "nil"
      end
    end
  end
end
