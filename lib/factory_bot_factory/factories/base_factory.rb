require "factory_bot_factory/file_writer"

module FactoryBotFactory
  class BaseFactory

    attr_reader :file_path

    def initialize(options = {})
      @factory_name  = options[:factory_name]
      @file_path     = build_file_path(options[:file_path])
      @nested_level  = [(options[:nested_level] || 1), 5].min
      @line_writer   = LineWriter.new(options)
      @factory_queue = []
    end

    def generate(data)
      push_to_factory_queue(@factory_name, data, @nested_level)
      output = []

      loop do
        factory_option = @factory_queue.shift
        output += build_factory(*factory_option)
        break if @factory_queue.empty?
        output << LineWriter::WHITE_SPACE
      end

      if @file_path
        write_file(output)
      else
        output = LineWriter.wrap_definition { output }
      end

      output
    ensure
      FactoryBot.reload if Object.const_defined?("FactoryBot")
      puts(output) if FactoryBotFactory.config.print_output
    end

    private

    def build_file_path(input_path = nil)
      return input_path if input_path
      return if FactoryBotFactory.config.factory_path.nil?
      FactoryBotFactory.config.factory_path + "/#{@factory_name}.rb"
    end

    def write_file(output)
      validate_existing_factory!
      FileWriter.new(@file_path).write(output)
    end

    def validate_existing_factory!
      return unless Object.const_defined?("FactoryBot") && FactoryBot.factories.registered?(@factory_name.to_s)
      raise FactoryExistsError, "[FactoryBotFactory] Factory #{@factory_name} already exists. Please check your existing factories."
    end

    def build_factory(name, value, level, options)
      raise "This method should be implemented in a subclass"
    end

    def build_nested_attribute(name, key, value, current_level, max_level)
      return @line_writer.write(key, value) if current_level == max_level

      if is_key_value_pair?(value)
        push_to_factory_queue("#{name}_#{key}", value, max_level - 1)
        @line_writer.write_nested_line(name, key)
      else
        @line_writer.write(key, value)
      end
    end

    def push_to_factory_queue(name, value, max_level, options = {})
      @factory_queue.push([name, value, max_level, options])
    end

    def is_key_value_pair?(value)
      value.is_a?(Hash) || value.is_a?(OpenStruct)
    end
  end
end
