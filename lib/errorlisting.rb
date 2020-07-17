class ErrorListing
  attr_accessor :list
  def initialize
    @list = []
  end

  def list_ident_error(line_n, expec_ident)
    @list << { 'line' => line_n, 'error' => "Indentation error detected. Expected #{expec_ident} whitespaces." }
  end

  def list_trail_error(line_n)
    @list << { 'line' => line_n + 1, 'error' => 'Trailing whitespace detected.' }
  end

  def list_end_error(status, control_instance)
    case status
    when 1
      control_instance.end_error_check = true
      "syntax error, unexpected end-of-input, expecting end"
    when -1
      control_instance.end_error_check = true
      "syntax error, unexpected end, expecting end-of-input"
    end
  end

  def list_empty_lines_error(line_n, index)
    @list << { 'line' => line_n[index + 1], 'error' => 'Extra empty lines detected.' }
  end
end