module FactoryBotFactory
  class LineWriter
    NEW_LINE     = "\n".freeze
    WHITE_SPACE  = "\s".freeze
    INDENT_SPACE = 2

    attr_reader :hash_converter, :string_converter, :numertic_converter, :open_struct_converter, :nil_converter

    def initialize(options = {})
      @options               = options
    end

    def build(key, value)
      options = [key, value, @options]

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

      wrap_block(key, values)
    end

    def build_nested_line(prefix, key)
      ["#{key} { build(:#{prefix}_#{key}) }"]
    end

    private

    def wrap_block(key, values)
      values = [values] unless values.is_a?(Array)

      if values.size > 1
        ["#{key} do"] + values.map { |v| LineWriter.indent(1, v) } + ["end"]
      else values.is_a?(Array)
        ["#{key} { #{values[0]} }"]
      end
    end

    class << self
      def indent(level, value)
        "#{WHITE_SPACE * INDENT_SPACE * level}#{value}"
      end

      def wrap_definition(&_block)
        output = ["FactoryBot.define do"]
        output += yield.map { |s| indent(1, s) }
        output << "end"
        output
      end

      def wrap_factory(name, target, &_block)
        output = ["factory :#{name}, class: #{target} do"]
        output += yield.map { |s| indent(1, s) }
        output << "end"
        output
      end
    end
  end
end
