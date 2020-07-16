require_relative '../lib/checker.rb'
require 'colorize'

file_input = ARGV[0]
check = Checker.new(file_input)

class Linter
  def initialize(file_input, check)
    @file_input = file_input
    @check = check
  end

  def run_checks
    if @file_input.nil?
      puts 'Point a file to be checked'
    else
      @check.trailing_spaces_check
      @check.indentation_check
      @check.extra_empty_lines_check
      @check.missing_end_check
    end
  end

  def print_result
    puts "\n **Traceback:".light_white.on_black.bold
    puts "\n"
    if @check.end_error_check 
      puts " #{@file_input.yellow}:#{@check.file_lines.length}   #{@check.missing_end_check.red}"
    else
      @check.error_output.each do |hash|
        case hash['line'].digits.count
        when 1
          print "#{@file_input}:#{hash['line']}".red
          puts "       #{hash['error']}".yellow
        when 2
          print "#{@file_input}:#{hash['line']}".red
          puts "      #{hash['error']}".yellow
        when 3
          print "#{@file_input}:#{hash['line']}".red
          puts "     #{hash['error']}".yellow
        when 4
          print "#{@file_input}:#{hash['line']}".red
          puts "    #{hash['error']}".yellow
        when 5
          print "#{@file_input}:#{hash['line']}".magenta
          puts "   #{hash['error']}".yellow
        end
      end
      if @check.error_output.empty?
        puts "\n"
        puts " ----> #{@check.error_output.length} offenses detected.".black.on_cyan
        puts @check.end_error_check
      else
        puts "\n"
        puts " ----> #{@check.error_output.length} offenses detected.".white.on_red
      end
    end
  end
end

linter = Linter.new(file_input, check)
linter.run_checks
linter.print_result
