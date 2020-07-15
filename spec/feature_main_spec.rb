require_relative '../lib/checker.rb'

describe SmallChecks do
  let(:small) { SmallChecks.new }
  let(:line_mock_1)  {' '}
  let(:line_mock_2)  {'  elsif when  '}
  let(:line_mock_3)  {' when elsif '}
  let(:line_mock_4)  {' end '}
  let(:expec_ident)  {2}
  let(:control) { Control.new }
  let(:array) {[1,2,3]}

  describe '#check_end' do
    context 'when line only contains an end statement' do
      it 'returns true' do
        expect(small.check_end(line_mock_4)).to eql(true)
      end
    end 
  end

  describe '#check_elsif' do
    context 'when line begins with "elsif"' do
      it 'returns true' do
        expect(small.check_elsif(line_mock_2)).to eql(true)
      end
    end 
  end

  describe '#check_when' do
    context 'when line begins with "when"' do
      it 'returns true' do
        expect(small.check_when(line_mock_3)).to eql(true)
      end
    end 
  end

  describe '#check_ident' do
    context 'when expec_ident matches identation' do
      it 'returns true' do
        expect(small.check_ident(line_mock_2, expec_ident)).to eql(true)
      end
    end 
  end

  describe '#check_empty' do
    context 'when line is empty' do
      it 'returns true' do
        expect(small.check_empty(line_mock_1)).to eql(true)
      end
    end 
  end

  describe '#check_ident_end' do
    context 'when identation is equal to identation minus factor' do
      it 'returns true' do
        expect(small.check_ident_end(line_mock_2, 4)).to eql(true)
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
  end

  describe '#consec?' do
    context 'when two consecutive arguments of an array are consecutive integers' do
      it 'returns true' do
        expect(small.consec?(array,1)).to eql(true)
      end
    end 
  end
end

