module FactoryBotFactory
  class LineWriter
    NEW_LINE     = "\n".freeze
    WHITE_SPACE  = "\s".freeze
    INDENT_SPACE = 2

    attr_reader :hash_converter, :string_converter, :numertic_converter, :open_struct_converter, :nil_converter

    def initialize(opt = {})
      @hash_converter        = opt[:hash_converter]        || Converters::HashConverter
      @string_converter      = opt[:string_converter]      || Converters::StringConverter
      @numertic_converter    = opt[:numertic_converter]    || Converters::NumericConverter
      @open_struct_converter = opt[:open_struct_converter] || Converters::HashConverter
      @nil_converter         = opt[:nil_converter]         || Converters::NilConverter
    end

    def build(key, value)
      if value.nil? || value == "null"
        nil_converter.call(key, value)
      elsif value.is_a?(String) || value.is_a?(Symbol)
        string_converter.call(key, value)
      elsif value.is_a?(Numeric)
        numertic_converter.call(key, value)
      elsif value.is_a?(Hash) || value.is_a?(Array)
        hash_converter.call(key, value)
      else value.is_a?(OpenStruct)
        open_struct_converter.call(key, value)
      end
    end

    def build_nested_line(prefix, key)
      ["#{key} { build(:#{prefix}_#{key}) }"]
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
