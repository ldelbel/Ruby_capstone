require_relative '../lib/checker.rb'

describe Control do
  let(:control) { Control.new }
  let(:line1) { ' def test ' }
  let(:line2) { ' array test ' }
  let(:line3) { ' end ' }
  let(:line_num) { 10 }

  describe '#line_iteration_and_counts' do
    context 'when line starts with reserved word' do
      it 'sets reserved_words_count += 1' do
        control.line_iteration_and_counts(line1, line_num)
        expect(control.reserved_words_count).to eql(1)
      end

      it 'sets identation_value += 1' do
        control.line_iteration_and_counts(line1, line_num)
        expect(control.indentation_value).to eql(1)
      end
    end

    context 'when line doesn\'t start with reserved words and is not end' do
      it 'doesn\'t change reserved_words_count' do
        control.line_iteration_and_counts(line2, line_num)
        expect(control.reserved_words_count).to eql(0)
      end

      it 'doesn\'t change identation_value' do
        control.line_iteration_and_counts(line2, line_num)
        expect(control.reserved_words_count).to eql(0)
      end
    end

    context 'when line is end' do
      it 'sets end_count += 1' do
        control.line_iteration_and_counts(line3, line_num)
        expect(control.end_count).to eql(1)
      end

      it 'sets identation_value -= 1' do
        control.indentation_value = 2
        control.line_iteration_and_counts(line3, line_num)
        expect(control.indentation_value).to eql(1)
      end
    end
  end
end
