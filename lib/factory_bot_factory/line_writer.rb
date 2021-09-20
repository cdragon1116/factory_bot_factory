require "factory_bot_factory/attribute"

module FactoryBotFactory
  class LineWriter
    NEW_LINE     = "\n".freeze
    WHITE_SPACE  = "\s".freeze
    INDENT_SPACE = 2

    def initialize(options = {})
      @options = options
    end

    def write(key, value)
      wrap_block(key, Attribute.new(key, value, @options).build)
    end

    def write_nested_line(prefix, key)
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

      def indent_lines(level, value)
        value.map { |s| indent(level, s) }
      end

      def join(lines)
        lines.join(LineWriter::NEW_LINE)
      end

      def wrap_definition(&_block)
        output = ["FactoryBot.define do"]
        output += yield.map { |s| indent(1, s) }
        output << "end"
        output.join(LineWriter::NEW_LINE)
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
