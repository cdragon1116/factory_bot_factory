module FactoryBotFactory
  class Config
    DEFAULT_CONVERTERS = {
      hash_converter:        Converters::HashConverter,
      string_converter:      Converters::StringConverter,
      numeric_converter:     Converters::NumericConverter,
      big_decimal_converter: Converters::NumericConverter,
      open_struct_converter: Converters::HashConverter,
      nil_converter:         Converters::NilConverter,
      date_time_converter:   Converters::DateTimeConverter,
      date_converter:        Converters::StringConverter,
      array_converter:       Converters::HashConverter
    }

    DEFAULT_OPTIONS = {
      factory_path: nil,
      print_output: false
    }.merge(DEFAULT_CONVERTERS)

    attr_accessor *DEFAULT_OPTIONS.keys

    def initialize(options = {})
      options = DEFAULT_OPTIONS.merge(options)
      options.each { |k, v| instance_variable_set(:"@#{k}", v) }
    end

    def factory_path=(path)
      path = path[0..-2] if path&.end_with?("/")
      @factory_path = path
    end
  end
end
