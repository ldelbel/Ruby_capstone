def test
  if
     array = [1,2,3,4,5]
    new_array = []
     array.each_with_index { |line_content, line_num| new_array << {line_content => line_num} } 
    puts new_array
  end
    end
 three = 3 
array = ["one", "two", "#{three}","four","five"] 
   array_string = array.to_s
new_array = []
array.size.times do |i|
  new_array << array[i].replace('#{three}').include?('#{')
end