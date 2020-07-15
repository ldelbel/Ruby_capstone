require_relative './test.rb'
require_relative './data.rb'
require_relative './read.rb'

read = Read.new('./test.rb')
file_lines = read.file_lines
$error_list = []
$reserved_words = ["begin","\\case","class","def","do","if","module", "unless"]
$reserved_words_count = 0
$end_count = 0
$identation_value = 0

class String
  def blank?
    self.strip.empty?
  end
end

# VERIFIED - ONLY REFACTORING REMAINING
def trailing_spaces_check(file_lines)
  file_lines.each_with_index do |line_content, line_num|
    if line_content[-2] == " " 
      $error_list << {line: line_num+1, error: 'C: Trailing whitespace detected.' } 
    end 
  end
  $error_list
end

# VERIFIED - ONLY REFACTORING REMAINING
def extra_empty_lines_check(file_lines)
  lines = []
  lines_error = []
  file_lines.each_with_index do |line_content, line_num|
    lines << line_num if file_lines[line_num].blank?
  end
  i = 0
    while i < lines.length - 1
      $error_list << { line: lines[i+1], error: 'Extra empty lines detected.'} if lines[i+1] - lines[i] == 1 
      i += 1
    end
  $error_list
end

def missing_end_check

end


def block_status_check(file_lines)
  for line in file_lines do
    unless line[0].strip == '#'
      if $reserved_words.include?(line.split(' ')[0]) || line.include?(' do ')
        puts line.split(' ')[0].to_s.strip
        $reserved_words_count += 1
        puts ({:reserved_words_count => $reserved_words_count})
      elsif line.strip == 'end'
        $end_count += 1
        puts ({:end_count => $end_count})
      end
    end
    # it ends here // I need to find a way to use that inside other methods
   end
  status = $reserved_words_count <=> $end_count
  puts ({:status => status})
end

def line_iteration_and_counts(line)
  unless line[0].strip == '#'
    if $reserved_words.include?(line.split(' ')[0]) || line.include?(' do ')
      $reserved_words_count += 1
      $identation_value += 1
    elsif line.strip == 'end'
      $end_count += 1
      $identation_value -= 1
    end
  end
end


puts identation_check(file_lines)