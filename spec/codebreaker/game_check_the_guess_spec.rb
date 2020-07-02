# frozen_string_literal: true

RSpec.describe Codebreaker::Game do
  let(:game) { described_class.new(Codebreaker::Player.new('Dima'), :easy) }

  describe '#check_the_guess' do
    it 'reduces attempts counter by 1' do
      expect { game.check_the_guess(5421.digits, 1234.digits) }.to change(game, :attempts).by(-1)
    end

    it 'returns string' do
      expect(game.check_the_guess(5421.digits, 1234.digits).class).to eq(String)
    end

    it 'returns string with 4 chars' do
      expect(game.check_the_guess(5421.digits, 1234.digits).size).to eq(4)
    end

    it "returns '+' '-' or ' ' " do
      expect(game.check_the_guess(5421.digits, 1234.digits)).to match(/['+''-'' ']/)
    end

    data = [[6543, 5643, '++--'], [6543, 6411, '+-  '], [6543, 6544, '+++ '], [6543, 3456, '----'],
            [6543, 6666, '+   '], [6543, 2666, '-   '], [6543, 2222, '    '], [6666, 1661, '++  '],
            [1234, 3124, '+---'], [1234, 1524, '++- '], [1234, 1234, '++++']]
    data.each do |d|
      it "returns #{d[2]} with guess #{d[1]} and code #{d[0]} " do
        expect(game.check_the_guess(d[0].digits, d[1].digits)).to eq(d[2])
      end
    end
  end
end
