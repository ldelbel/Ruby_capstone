require_relative './read.rb'

class Control
  
  attr_accessor :reserved_words, :reserved_words_count, :error_list, :identation_value, :end_count
  
  def initialize
    @reserved_words = ["begin","\\case","class","def","do","if","module", "unless"]
    @error_list = []
    @reserved_words_count = 0
    @end_count = 0
    @identation_value = 0
  end

  def line_iteration_and_counts(line, control_instance)
    unless line[0].strip == '#'
      if control_instance.reserved_words.include?(line.split(' ')[0]) || line.include?(' do ')
        control_instance.reserved_words_count += 1
        control_instance.identation_value += 1
      elsif line.strip == 'end'
        control_instance.end_count += 1
        control_instance.identation_value -= 1
      end
    end
  end
end

class ErrorListing
  
  def initialize
    @error_list = []
  end
  
  def list_ident_error(line_n, expec_ident)
    @error_list << { line: line_n, error: "Identation error detected. Expected #{expec_ident} whitespaces."}
  end
end

class SmallChecks
  
  def initialize
    
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