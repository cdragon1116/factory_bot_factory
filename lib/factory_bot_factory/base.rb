module FactoryBotFactory
  class Base
    class << self
      def build(factory_name, klass, data, options = {})
        raise NestedToDeepError, 'Only support 5 nested levels' if options[:nested_level].to_i > 5

        factory(klass, data).new(options.merge(factory_name: factory_name)).generate(data)
      rescue => e
        puts "Please check your input data and make sure you pass supported type of factory."
      end

      private

      def factory(klass, data)
        if data.respond_to?(:attributes) && klass == data.class
          Object.const_get("FactoryBotFactory::ModelFactory")
        else
          Object.const_get("FactoryBotFactory::#{klass}Factory")
        end
      end
    end
  end
end
