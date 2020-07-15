require_relative './test.rb'

class Read
  
  attr_accessor :file_lines
  
  def initialize(file)
    @file = file
    @file_lines = []
    begin
      File.readlines(@file).each {|line| @file_lines << line  }   
    rescue StandardError
      
    end
  end

end


