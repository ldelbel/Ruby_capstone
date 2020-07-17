require_relative './read.rb'
require_relative './control.rb'
require_relative './errorlisting.rb'
require_relative './smallchecks.rb'

class Checker
  attr_reader :end_error_check, :error_output
  attr_accessor :file_lines, :control, :small # rules only for RSpec testing, except for file_lines
  def initialize(file)
    @file_lines = Read.new(file).file_lines
    @control = Control.new
    @error = ErrorListing.new
    @error_output = @error.list
    @small = SmallChecks.new
    @end_error_check = false
  end

  def trailing_spaces_check
    @file_lines.each_with_index do |line_content, line_num|
      @error.list_trail_error(line_num) if line_content[-2].eql?(' ') && !line_content.blank?
    end
  end

  def indentation_check
    @control.reset
    current_value = 0
    @file_lines.each_with_index do |line_content, line_num|
      expected_indentation = current_value * 2
      @control.line_iteration_and_counts(line_content, line_num)
      smcheck_indent = @small.check_indent(line_content, expected_indentation)
      smcheck_indent_end = @small.check_indent_end(line_content, expected_indentation)
      smcheck_end = @small.check_end(line_content)
      smcheck_elsif_else = @small.check_elsif_else(line_content)
      smcheck_empty = @small.check_empty(line_content)
      smcheck_when = @small.check_when(line_content)

      next if smcheck_empty

      if smcheck_end
        @error.list_indent_error(line_num + 1, expected_indentation - 2) unless smcheck_indent_end
      elsif smcheck_elsif_else
        @error.list_indent_error(line_num + 1, expected_indentation - 2) unless smcheck_indent_end
      elsif smcheck_when
        @error.list_indent_error(line_num + 1, expected_indentation - 2) unless smcheck_indent_end
      elsif !smcheck_indent
        @error.list_indent_error(line_num + 1, expected_indentation)
      end

      current_value = @control.indentation_value
    end
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
  end

  def missing_end_check
    @control.reset
    @file_lines.each_with_index do |line_content, line_num|
      @control.line_iteration_and_counts(line_content, line_num)
    end
    status = @small.block_status_check(@control)
    message = @error.list_end_error(status, @control)
    @end_error_check = @control.end_error_check
    message
  end
end
