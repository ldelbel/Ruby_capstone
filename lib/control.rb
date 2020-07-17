class Control
  attr_accessor :reserved_words_count, :indentation_value, :end_count, :end_error_check
  attr_reader :reserved_words

  def initialize
    @reserved_words = %w[begin case class def do if module unless]
    @reserved_words_count = 0
    @end_count = 0
    @indentation_value = 0
    @end_error_check = false
  end

  def line_iteration_and_counts(line, line_num)
    unless line[0].strip == '#'
      if reserved_words.include?(line.split(' ')[0]) || line.include?(' do ')
        self.reserved_words_count += 1
        self.indentation_value += 1
      elsif line.strip == 'end'
        self.end_count += 1
        self.indentation_value -= 1
      end
    end
  end

  def reset
    @reserved_words_count = 0
    @end_count = 0
    @indentation_value = 0
  end
end