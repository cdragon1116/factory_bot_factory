module FactoryBotFactory
  class BaseFactory
    def initialize(factory_name:, nested_level: 1, file_path: nil)
      @factory_name  = factory_name
      @nested_level  = nested_level
      @line_writer   = LineWriter.new
      @file_path     = file_path
      @factory_queue = []
    end

    def generate(data)
      output = LineWriter.wrap_definition do
        @factory_queue << [@factory_name, data, @nested_level]
        inner_output = []

        loop do
          factory_option = @factory_queue.shift
          inner_output += build_factory(*factory_option)
          break if @factory_queue.empty?
          inner_output << LineWriter::WHITE_SPACE
        end

        inner_output
      end

      output = output.join(LineWriter::NEW_LINE)
      File.open(@file_path, 'w') {|f| f.write(output) } if @file_path
      output
    end

    private

    def build_factory(name, value, level)
      raise "This method should be implemented in a subclass"
    end

    def build_nested_attribute(name, key, value, current_level, max_level)
      return @line_writer.build(key, value) if current_level == max_level

      if is_key_value_pair?(value)
        push_to_factory_queue(name, key, value, max_level)
        @line_writer.build_nested_line(name, key)
      else
        @line_writer.build(key, value)
      end
    end

    def push_to_factory_queue(name, key, value, max_level)
      @factory_queue.push(["#{name}_#{key}", value, max_level - 1])
    end

    def is_key_value_pair?(value)
      value.is_a?(Hash) || value.is_a?(OpenStruct)
    end
  end
end
