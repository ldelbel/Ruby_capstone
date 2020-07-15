require_relative '../lib/checker.rb'
require 'colorize'

$file_input = ARGV[0]
$check = Checker.new($file_input)

def run_checks
  if $file_input.nil?
    puts "Point a file to be checked"
  else
    $check.trailing_spaces_check
    $check.identation_check
    $check.extra_empty_lines_check
    $check.missing_end_check
  end
end

def print_result
  puts "\n **Traceback:".light_white.on_black.bold
  puts "\n"

  for hash in $check.error_output do
    if hash['line'].nil?
      
    else
      case hash['line'].digits.count
      when 1 
        print "#{$file_input}:#{hash['line']}".red
        puts "       #{hash['error']}".yellow 
      when 2 
        print "#{$file_input}:#{hash['line']}".red
        puts "      #{hash['error']}".yellow 
      when 3 
        print "#{$file_input}:#{hash['line']}".red
        puts "     #{hash['error']}".yellow 
      when 4 
        print "#{$file_input}:#{hash['line']}".red
        puts "    #{hash['error']}".yellow 
      when 5 
        print "#{$file_input}:#{hash['line']}".magenta
        puts "   #{hash['error']}".yellow 
      end
    end
  end
  if $check.error_output.length == 0
    puts "\n"
    puts (" ----> #{$check.error_output.length} offenses detected.").black.on_cyan
  else
    puts "\n"
    puts (" ----> #{$check.error_output.length} offenses detected.").white.on_red
  end
end

run_checks
print_result

