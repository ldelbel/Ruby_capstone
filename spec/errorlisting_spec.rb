require_relative '../lib/checker.rb'

describe ErrorListing do
  let(:error) { ErrorListing.new }
  let(:line_n) { 14 }
  let(:expec_indent) { 2 }
  let(:status) { 1 }
  let(:control) { Control.new }
  let(:index) { 10 }

  describe '#list_indent_error' do
    context 'when line_n and expect_indent are given' do
      it 'adds error message to @list with arguments' do
        list = error.list
        error.list_indent_error(line_n, expec_indent)
        expect(list).to eql([{ 'line' => line_n, 'error' => "Indentation error detected. Expected #{expec_indent} whitespaces." }])
      end
    end

    context 'when one or both arguments are not given' do
      it 'raises ArgumentError' do
        expect { error.list_indent_error(line_n) }.to raise_error(ArgumentError)
      end
    end
  end

  describe '#list_trail_error' do
    context 'when line_n is given' do
      it 'adds error message to @list with argument' do
        list = error.list
        error.list_trail_error(line_n)
        expect(list).to eql([{ 'line' => line_n + 1, 'error' => 'Trailing whitespace detected.' }])
      end
    end

    context 'when argument is not given' do
      it 'raises ArgumentError' do
        expect { error.list_trail_error }.to raise_error(ArgumentError)
      end
    end
  end

  describe '#list_end_error' do
    context 'when arguments are given and status is 1' do
      it 'returns error message' do
        expect(error.list_end_error(status, control)).to eql('syntax error, unexpected end-of-input, expecting end')
      end
      it 'sets end_error_check to true' do
        error.list_end_error(status, control)
        expect(control.end_error_check).to be(true)
      end
    end

    context 'when arguments are given and status is 0' do
      it 'returns nil' do
        expect(error.list_end_error(0, control)).to eql(nil)
      end
      it 'doesn\'t set end_error_check to true' do
        error.list_end_error(0, control)
        expect(control.end_error_check).to be(false)
      end
    end
  end

  describe '#list_empty_lines_error' do
    context 'when arguments are given' do
      it 'adds error message to @list with arguments' do
        list = error.list
        error.list_empty_lines_error(line_n, index)
        expect(list).to eql([{ 'line' => line_n[index + 1], 'error' => 'Extra empty lines detected.' }])
      end
    end

    context 'when one or both arguments are not given' do
      it 'raises ArgumentError' do
        expect { error.list_empty_lines_error }.to raise_error(ArgumentError)
      end
    end
  end
end
