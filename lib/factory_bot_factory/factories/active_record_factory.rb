require 'factory_bot_factory/factories/model_factory'

module FactoryBotFactory
  class ActiveRecordFactory < ModelFactory
    def build_factory(name, value, level, _options = {})
      super
    end
  end
end
