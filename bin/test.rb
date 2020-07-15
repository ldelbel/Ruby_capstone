class String
  def blank?
    strip.empty?
  end
end

class Control
  attr_accessor :reserved_words_count, :error_list, :identation_value, :end_count
  attr_reader :reserved_words

  def initialize
    @reserved_words = ['begin', '\\case', 'class', 'def', 'do', 'if', 'module', 'unless']
    @error_list = []
    @reserved_words_count = 0
    @end_count = 0
    @identation_value = 0
  end

  def line_iteration_and_counts(line, control_instance)
    return if line[0].strip == '#'

    if control_instance.reserved_words.include?(line.split(' ')[0]) || line.include?(' do ')
      control_instance.reserved_words_count += 1
      control_instance.identation_value += 1
    elsif line.strip == 'end'
      control_instance.end_count += 1
      control_instance.identation_value -= 1
    end
  end

  def reset
    @error_list = []
    @reserved_words_count = 0
    @end_count = 0
    @identation_value = 0
  end
end

class ErrorListing
  attr_accessor :list
  def initialize
    @list = []
  end

  def list_ident_error(line_n, expec_ident)
    @list << { 'line' => line_n, 'error' => "Identation error detected. Expected #{expec_ident} whitespaces." }
  end

  def list_trail_error(line_n)
    @list << { 'line' => line_n + 1, 'error' => 'C: Trailing whitespace detected.' }
  end

  def list_end_error(status)
    case status
    when 1 then @list << { 'error' => 'syntax error, unexpected end-of-input, expecting end' }
    when -1 then @list << { 'error' => 'syntax error, unexpected end, expecting end-of-input' }
    end
  end

  def list_empty_lines_error(line_n, index)
    @list << { 'line' => line_n[index + 1], 'error' => 'Extra empty lines detected.' }
  end
end

class SmallChecks
  def check_end(line_c)
    line_c.strip == 'end'
  end

  def check_ident(line_c, expec_ident)
    line_c.index(/[^ ]/).eql?(expec_ident)
  end

  def check_ident_end(line_c, expec_ident)
    line_c.index(/[^ ]/).eql?(expec_ident.zero? ? 0 : expec_ident - 2)
  end

  def block_status_check(control_instance)
    control_instance.reserved_words_count <=> control_instance.end_count
  end

  def consec?(line_n, index)
    (line_n[index + 1] - line_n[index]).eql?(1)
  end
end
