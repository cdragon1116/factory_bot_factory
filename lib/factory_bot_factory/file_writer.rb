require 'factory_bot_factory/logger'

module FactoryBotFactory
  class FileWriter
    attr_reader :file_paht, :output

    def initialize(file_path)
      @file_path = file_path
    end

    def write(output)
      if File.file?(@file_path)
        output  = regroup_existing_lines(output)
        message = "New Factory successfully write to an existing file."
      else
        output  = LineWriter.wrap_definition { output }
        message = "New Factory successfully write to a new file."
      end

      FactoryBot.reload if Object.const_defined?("FactoryBot")

      File.open(@file_path, 'w') {|f| f.write(output) }
      Logger.alert(message + "\nPlease check your file in #{@file_path}")
      output
    end

    def regroup_existing_lines(output)
      File.read(@file_path) + LineWriter::NEW_LINE + LineWriter.wrap_definition { output }
    end
  end
end
