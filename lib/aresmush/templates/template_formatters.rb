module AresMUSH
  module TemplateFormatters
    def left(str, width)
      return "".ljust(width) if str.nil?
      str.truncate(width).ljust(width)
    end

    def center(str, width)
      return "".ljust(width) if str.nil?
      str.truncate(width).center(width)
    end

    def right(str, width)
      return "".rjust(width) if str.nil?
      str.truncate(width).rjust(width)
    end
  
    def line(number = 1)
      @output << "%l#{number}"
      return ""
    end
    
    def one_line(&block)
      str = capture(&block)
      @output << str.gsub(/\n/, "")
      @output << "\n" if str.ends_with? "\n"
      return ""
    end
  
    def capture(*args)
      old_buffer = @output
      @output = ""
      yield(*args)
      new_buffer = @output
      @output  = old_buffer
      new_buffer
    end
  end
end