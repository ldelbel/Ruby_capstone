require_relative '../lib/checker.rb'

describe SmallChecks do
  let(:small) { SmallChecks.new }
  let(:line_mock_1) { ' ' }
  let(:line_mock_2) { '  elsif when  ' }
  let(:line_mock_3) { ' when elsif ' }
  let(:line_mock_4) { ' end ' }
  let(:expec_indent) { 2 }
  let(:control) { Control.new }
  let(:array) { [1, 2, 3] }
  let(:array2){ [2, 4, 6] }

  describe '#check_end' do
    context 'when line only contains an end statement' do
      it 'returns true' do
        expect(small.check_end(line_mock_4)).to eql(true)
      end
    end

    context 'when line only contains an end statement' do
      it 'returns false' do
        expect(small.check_end(line_mock_3)).to eql(false)
      end
    end
  end

  describe '#check_elsif_else' do
    context 'when line begins with "elsif"' do
      it 'returns true' do
        expect(small.check_elsif_else(line_mock_2)).to eql(true)
      end
    end

    context 'when line doesn\'t begin with "elsif"' do
      it 'returns false' do
        expect(small.check_end(line_mock_3)).to eql(false)
      end
    end
  end

  describe '#check_when' do
    context 'when line begins with "when"' do
      it 'returns true' do
        expect(small.check_when(line_mock_3)).to eql(true)
      end
    end

    context 'when line doesn\'t begin with "when"' do
      it 'returns false' do
        expect(small.check_end(line_mock_2)).to eql(false)
      end
    end
  end

  describe '#check_indent' do
    context 'when expec_indent matches indentation' do
      it 'returns true' do
        expect(small.check_indent(line_mock_2, expec_indent)).to eql(true)
      end
    end

    context 'when expec_indent doesn\'t match indentation' do
      it 'returns false' do
        expect(small.check_indent(line_mock_3, expec_indent)).to eql(false)
      end
    end
  end

  describe '#check_empty' do
    context 'when line is empty' do
      it 'returns true' do
        expect(small.check_empty(line_mock_1)).to eql(true)
      end
    end

    context 'when line is not empty' do
      it 'returns false' do
        expect(small.check_empty(line_mock_2)).to eql(false)
      end
    end
  end

  describe '#check_indent_end' do
    context 'when indentation is equal to indentation minus factor' do
      it 'returns true' do
        expect(small.check_indent_end(line_mock_2, 4)).to eql(true)
      end
    end

    context 'when indentation is not equal to indentation minus factor' do
      it 'returns false' do
        expect(small.check_indent_end(line_mock_2, 6)).to eql(false)
      end
    end
  end

  describe '#block_status_check' do
    context 'when reserved_words_count and end_count return the same value' do
      it 'returns 0' do
        allow(control).to receive(:reserved_words_count).and_return(1)
        allow(control).to receive(:end_count).and_return(1)
        expect(small.block_status_check(control)).to eql(0)
      end
    end

    context 'when reserved_words_count is greater than end_count' do
      it 'returns 1' do
        allow(control).to receive(:reserved_words_count).and_return(2)
        allow(control).to receive(:end_count).and_return(1)
        expect(small.block_status_check(control)).to eql(1)
      end
    end
  end

  describe '#consec?' do
    context 'when two consecutive arguments of an array are consecutive integers' do
      it 'returns true' do
        expect(small.consec?(array, 1)).to eql(true)
      end
    end

    context 'when two consecutive arguments of an array are not consecutive integers' do
      it 'returns false' do
        expect(small.consec?(array2, 1)).to eql(false)
      end
    end
  end
end
