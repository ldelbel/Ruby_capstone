require_relative './support.rb'

class Checker 
  attr_reader :file_lines
  def initialize(file)
    @file_lines = Read.new(file).file_lines
    @control = Control.new
    @error = ErrorListing.new
    @small = SmallChecks.new
  end

  def trailing_spaces_check
    @file_lines.each_with_index do |line_content, line_num|
      @error.list_trail_error(line_num) if line_content[-2].eql?(" ")
    end
    @error.list
  end

  def identation_check
    current_value = 0
    @file_lines.each_with_index do |line_content, line_num|
      expected_identation = current_value * 2
      @control.line_iteration_and_counts(line_content, @control)
      smcheck_ident = @small.check_ident(line_content, expected_identation)
      smcheck_ident_end = @small.check_ident_end(line_content, expected_identation)
      smcheck_end = @small.check_end(line_content)
      case
      when !smcheck_ident && !smcheck_end  
        @error.list_ident_error(line_num + 1, expected_identation)
      when !smcheck_ident_end && smcheck_end 
        @error.list_ident_error(line_num + 1, expected_identation - 2)
      end
      current_value = @control.identation_value
    end
    @error.list
  end

  def extra_empty_lines_check
    lines = []
    @file_lines.each_with_index do |line_content, line_num|
      lines << line_num if @file_lines[line_num].blank?
    end
    i = 0
      while i < lines.length - 1
        @error.list_empty_lines_error(lines, i) if @small.consec?(lines,i)
        i += 1
      end
    @error.list
  end

  def missing_end_check
    @file_lines.each do |line_content| #HERE I CAN USE ONLY EACH - TAKE A LOOK LATER
      @control.line_iteration_and_counts(line_content, @control)
    end
    status = @small.block_status_check(@control)
    @error.list_end_error(status)
    @error.list
  end
  
end

check = Checker.new('./test.rb')
p check.identation_check

