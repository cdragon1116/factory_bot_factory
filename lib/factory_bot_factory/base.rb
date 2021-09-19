module FactoryBotFactory
  class Base
    class << self
      def build(data, options = {})
        options[:klass] ||= data.class
        options[:factory_name] ||= data.class.name.downcase

        raise ArgumentError, "Unsupported data type. Supported format: Hash, OpenStruct, ActiveRecord instance." unless valid_data?(data)
        raise NestedToDeepError, 'Only support 5 nested levels' if options[:nested_level].to_i > 5

        factory(options[:klass], data).new(options).generate(data)
      end

      private

      def factory(klass, data)
        if active_record?(data) && klass == data.class
          Object.const_get("FactoryBotFactory::ActiveRecordFactory")
        elsif data.respond_to?(:attributes) && klass == data.class
          Object.const_get("FactoryBotFactory::ModelFactory")
        else
          Object.const_get("FactoryBotFactory::#{klass}Factory")
        end
      end

      def valid_data?(data)
        data.is_a?(Hash) || data.is_a?(OpenStruct) || data.respond_to?(:attributes)
      end

      def active_record?(data)
        Object.const_defined?("ActiveRecord::Base") && data.class.is_a?(ActiveRecord::Base)
      end
    end
  end
end
