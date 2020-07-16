class String
  def blank?
    strip.empty?
  end


class Control
  attr_accessor :reserved_words_count, :error_list, :indentation_value, :end_count
  attr_reader :reserved_words

  def initialize
    @reserved_words = ['begin', 'case', 'class', 'def', 'do', 'if', 'module', 'unless']
    @error_list = []
    @reserved_words_count = 0
    @end_count = 0
    @indentation_value = 0
  end

  def line_iteration_and_counts(line, control_instance)
    return if line[0].strip == '#'

    if control_instance.reserved_words.include?(line.split(' ')[0]) || line.include?(' do ')
      control_instance.reserved_words_count += 1
      control_instance.indentation_value += 1
    elsif line.strip == 'end'
      control_instance.end_count += 1
      control_instance.indentation_value -= 1
    end
  end

  def reset
    @error_list = []
    @reserved_words_count = 0
    @end_count = 0
    @indentation_value = 0
  end
end