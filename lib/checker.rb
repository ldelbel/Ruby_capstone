require_relative './test.rb'
require_relative './support.rb'

class Checker 
  attr_reader :file_lines
  def initialize(file)
    @file_lines = Read.new(file).file_lines
    @control = Control.new
    @error = ErrorListing.new
    @small = SmallChecks.new
  end

  def identation_check
    current_value = 0
    @file_lines.each_with_index do |line_content, line_num|
      expected_identation = current_value * 2
      @control.line_iteration_and_counts(line_content, @control)
      test_ident = test_ident(line_content, expected_identation)
      test_ident_end = test_ident_end(line_content, expected_identation)
      test_end = test_end(line_content)
      case
      when !test_ident && !test_end then list_ident_error(line_num + 1, expected_identation)
      when !test_ident_end && test_end then list_ident_error(line_num + 1, expected_identation - 2)
      end
      current_value = @control.identation_value
    end
    @control.error_list
  end

  def list_ident_error(line_n, expec_ident)
    @control.error_list << { line: line_n, error: "Identation error detected. Expected #{expec_ident} whitespaces."}
  end
  
  def test_end(line_c)
    line_c.strip == 'end'
  end
  
  def test_ident(line_c, expec_ident)
    line_c.index(/[^ ]/).eql?(expec_ident)
  end
  
  def test_ident_end(line_c, expec_ident)
    line_c.index(/[^ ]/).eql?(expec_ident == 0 ? 0 : expec_ident - 2)
  end
end

class String
  def blank?
    self.strip.empty?
  end
end

check = Checker.new('./test.rb')
p check.identation_check





