require_relative './support.rb'

class Checker
  attr_accessor :error_output
  def initialize(file)
    @file_lines = Read.new(file).file_lines
    @control = Control.new
    @error = ErrorListing.new
    @error_output = @error.list
    @small = SmallChecks.new
  end

  def trailing_spaces_check
    @file_lines.each_with_index do |line_content, line_num|
      @error.list_trail_error(line_num) if line_content[-2].eql?(' ') && !line_content.blank?
    end
    @error.list
  end

  def indentation_check
    current_value = 0
    @file_lines.each_with_index do |line_content, line_num|
      expected_indentation = current_value * 2
      @control.line_iteration_and_counts(line_content, line_num)
      smcheck_ident = @small.check_ident(line_content, expected_indentation)
      smcheck_ident_end = @small.check_ident_end(line_content, expected_indentation)
      smcheck_end = @small.check_end(line_content)
      smcheck_elsif = @small.check_elsif(line_content)
      smcheck_empty = @small.check_empty(line_content)
      smcheck_when = @small.check_when(line_content)
      if smcheck_empty
      elsif !smcheck_ident && !smcheck_end && !smcheck_elsif && !smcheck_when
        @error.list_ident_error(line_num + 1, expected_indentation)
      elsif !smcheck_ident_end && smcheck_end
        @error.list_ident_error(line_num + 1, expected_indentation - 2)
      elsif !smcheck_ident_end && smcheck_elsif
        @error.list_ident_error(line_num + 1, expected_indentation - 2)
      elsif !smcheck_ident_end && smcheck_when
        @error.list_ident_error(line_num + 1, expected_indentation - 2)
      end
      current_value = @control.indentation_value
    end
    @error.list
  end

  def extra_empty_lines_check
    lines = []
    @file_lines.each_with_index do |_line_content, line_num|
      lines << line_num if @file_lines[line_num].blank?
    end
    i = 0
    while i < lines.length - 1
      @error.list_empty_lines_error(lines, i) if @small.consec?(lines, i)
      i += 1
    end
    @error.list
  end

  def missing_end_check
    @file_lines.each_with_index do |line_content, line_num|
      @control.line_iteration_and_counts(line_content, line_num)
    end
    status = @small.block_status_check(@control)
    @error.list_end_error(status)
    @error.list
  end
end
