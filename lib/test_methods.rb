require_relative './test.rb'

file_lines = []
error_list = []
File.readlines('./test.rb').each {|line| file_lines << line  }


$reserved_words = ["begin","\\case","class","def","do","if","module", "unless"]
$reserved_words_count = 0
$end_count = 0

class String
  def blank?
    self.strip.empty?
  end
end

# VERIFIED - ONLY REFACTORING REMAINING
def trailing_spaces_check(file_lines)
  error_list = []
  file_lines.each_with_index do |line_content, line_num|
    if line_content[-2] == " " 
      error_list << {line: line_num+1, error: 'C: Trailing whitespace detected.' } 
    end 
  end
  error_list
end

# VERIFIED - ONLY REFACTORING REMAINING
def extra_empty_lines_check(file_lines)
  error_list = []
  lines = []
  lines_error = []
  file_lines.each_with_index do |line_content, line_num|
    lines << line_num if file_lines[line_num].blank?
  end
  i = 0
    while i < lines.length - 1
      error_list << { line: lines[i+1], error: 'Extra empty lines detected.'} if lines[i+1] - lines[i] == 1 
      i += 1
    end
  error_list
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
  end
  status = $reserved_words_count <=> $end_count
  puts ({:status => status})
end

def identation_check(file_lines)
  current_identation = 0
  file_lines.each_with_index do |line_content, line_num|
  if line_content[0].include?($reserved_words) {                   }

  end
end



block_status_check(file_lines)