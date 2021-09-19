module Helpers
  module Configuration
    def set_to_default
      FactoryBotFactory.configure do |c|
        c.hash_converter = FactoryBotFactory::Converters::HashConverter
        c.string_converter = FactoryBotFactory::Converters::StringConverter
        c.numertic_converter = FactoryBotFactory::Converters::NumericConverter
        c.open_struct_converter = FactoryBotFactory::Converters::HashConverter
        c.nil_converter = FactoryBotFactory::Converters::NilConverter
        c.factory_path = nil
      end
    end
  end
end
