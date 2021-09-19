module FactoryBotFactory
  class Base
    class << self
      def build(*args)
        factory_name, klass, data, options = build_args(*args)
        options ||= {}

        raise ArgumentError if factory_name.nil? || klass.nil? || !valid_data?(data)
        raise NestedToDeepError, 'Only support 5 nested levels' if options[:nested_level].to_i > 5

        factory(klass, data).new({ factory_name: factory_name }.merge(options)).generate(data)
      end

      private

      def build_args(*args)
        # To be deprecated
        if args[0].is_a?(String) || args[0].is_a?(Symbol) && args.size >= 3
          args
        else
          arg = args[0]
          options = args[1..-1].inject({}) { |h, _h| h.merge(_h) } if args[1..-1]
          [arg.class.name.downcase, (options[:klass] || arg.class), arg, options]
        end
      end

      def valid_data?(data)
        data.is_a?(Hash) || data.is_a?(OpenStruct) || data.respond_to?(:attributes)
      end

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
