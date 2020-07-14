require_relative './test.rb'

class Checker 

  def initialize(file)
    @file = file
    @check_validation = true
    @errors_list = []
    @line_count = 0
    @file_lines = []
    begin
      File.readlines(file).each { |line| @file_lines << line }
      @line_count = file_lines.length
    rescue StandardError
      @check_validation = false
    end
  end

  def trailing_spaces_check(file_lines)
    file_lines.each_with_index do |line_content, line_num|
      if line_content[-2] == ' '
        @errors_list << {line: line_num, error: 'No trailing spaces allowed' } 
      end 
    end
  end

  # def double_quotes_check
  #   file_lines.each_with_index do |line_content, line_num|
  #     unless line_content.scan(/"([^"]*)"/).include?('#{' || '\\') do
  #       @error_list << { line: line_num, error: 'Unnecessary use of double quotes' }
  #     end
  #   end
  # end

  def extra_empty_lines_check
    @file_lines.each_with_index do |line_content, line_num|
      if @file_lines[line_num].strip.empty? && @file_lines[line_num+1].strip.empty?
        @error_list.push( { line: line_num, error: 'Extra empty lines'} ) 
      end
    end
    puts @error_list
  end

  # def print_error_list
  #   puts @error_list
  # end



  # def identation_check
    # end



  
end

class String
  def blank?
    self.strip.empty?
  end
end

check = Checker.new('./test.rb')
check.extra_empty_lines_check