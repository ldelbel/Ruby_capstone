class Test1
  def test
    strip.nil?
  end
end

class Test2
  attr_accessor :test_variable
  attr_reader :test2_variable

      def initialize(param)
    @array = [1,2,3,4,5]
    @array2 = [6,7,8,9,10]
    @array3 = []
    @param = param
  end

  def testing(line, control_instance)
    if @array.include? param
      @array3 << param
    elsif @array2.include? param
      @array3 << param - 1
    else
      @param += 1
    end
  end
end