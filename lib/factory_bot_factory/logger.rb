module FactoryBotFactory
  class Logger
    PREFIX = "[FactoryBotFactory Logger]".freeze

    def self.alert(message)
      message = message.split("\n").map { |m| "#{PREFIX} #{m}" }.join("\n")
      puts ColorString.new(message).yellow
    end
  end
end

class ColorString < String
  # colorization
  def colorize(color_code)
    "\e[#{color_code}m#{self}\e[0m"
  end

  def red
    colorize(31)
  end

  def green
    colorize(32)
  end

  def yellow
    colorize(33)
  end

  def blue
    colorize(34)
  end

  def pink
    colorize(35)
  end

  def light_blue
    colorize(36)
  end
end
