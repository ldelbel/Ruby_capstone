class Read
  attr_reader :file_lines

  def initialize(file)
    @file = file
    @file_lines = []
    begin
      File.readlines(@file).each { |line| @file_lines << line }
    end
  end
end

