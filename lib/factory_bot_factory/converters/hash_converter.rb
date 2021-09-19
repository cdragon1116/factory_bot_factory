module FactoryBotFactory
  module Converters
    class HashConverter
      EMPTY_PAIR_REGEX = /(?<content>"(?:[^\\"]|\\.)+")|(?<open>\{)\s+(?<close>\})|(?<open>\[)\s+(?<close>\])/m

      def self.call(key, value, options = {})
        value = value.to_h if value.is_a?(OpenStruct)

        value = JSON
          .pretty_generate(value)
          .gsub(EMPTY_PAIR_REGEX, '\k<open>\k<content>\k<close>')
          .split("\n")
      end
    end
  end
end
