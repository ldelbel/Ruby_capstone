require_relative '../lib/checker.rb'
require_relative 'control_spec.rb'

describe Checker do
  let(:file) { File.new('a.rb', 'w') }
  let(:check) { Checker.new(file) }
  let(:control) { check.control }
  let(:small) { check.small }
  let(:line2) { ' array test ' }
  let(:array_correct) { ['def test', '  if check test', "    puts 'true'", '  else', "    puts 'false'", '  end', 'end'] }
  let(:array_wrong) { ['def test', 'if check test', "    puts 'true'  ", ' ', ' ', '  else', "    puts 'false'", '  end', 'end'] }
  let(:array_missing_end) { ['def test', 'if check test', "    puts 'true'  ", ' ', ' ', '  else', "    puts 'false'", '  end'] }
  let(:line_num) { 10 }

  describe '#trailing_spaces_check' do
    context 'when any of the non-empty file_lines contains trailing spaces' do
      it 'adds error message to error_output with line' do
        check.file_lines = array_wrong
        check.trailing_spaces_check
        expect(check.error_output).to eql([{ 'line' => 3, 'error' => 'Trailing whitespace detected.' }])
      end
    end

    context 'when no lines from file_lines contains trailing spaces' do
      it 'returns file_lines' do
        check.file_lines = array_correct
        expect(check.trailing_spaces_check).to be(array_correct)
      end
    end
  end

  describe '#indentation_check' do
    context 'when checked indentation is not expected indentation' do
      it 'adds error message to output with arguments' do
        check.file_lines = array_wrong
        check.indentation_check
        expect(check.error_output).to eql([{ 'line' => 2, 'error' => 'Indentation error detected. Expected 2 whitespaces.' }])
      end
    end

    context 'when all lines checks true for expected indentation' do
      it 'returns file_lines' do
        check.file_lines = array_correct
        expect(check.indentation_check).to be(array_correct)
      end
    end
  end

  describe '#extra_empty_lines_check' do
    context 'when there are more than one empty line in sequence' do
      it 'adds error message to error_output with lines' do
        check.file_lines = array_wrong
        check.extra_empty_lines_check
        expect(check.error_output).to eql([{ 'line' => 4, 'error' => 'Extra empty lines detected.' }])
      end
    end

    context 'when no lines from file_lines contains trailing spaces' do
      it 'returns file_lines' do
        check.file_lines = array_correct
        expect(check.extra_empty_lines_check).to be(nil)
      end
    end
  end

  describe '#missing_end_check' do
    context 'when the number of ends are less than the number of reserved words' do
      it 'returns error message' do
        check.file_lines = array_missing_end
        allow(small).to receive(:block_status_check).with(control).and_return(1)
        check.missing_end_check
        expect(check.missing_end_check).to eql('syntax error, unexpected end-of-input, expecting end')
      end

      it 'sets end_error_check to true' do
        check.file_lines = array_correct
        allow(small).to receive(:block_status_check).with(control).and_return(1)
        check.missing_end_check
        expect(check.end_error_check).to be(true)
      end
    end

    context 'when number of ends and reserved words are equal' do
      it 'doesn\'t change end_error_check' do
        check.file_lines = array_correct
        allow(small).to receive(:block_status_check).with(control).and_return(0)
        check.missing_end_check
        expect(check.end_error_check).to be(false)
      end
    end
  end
end
