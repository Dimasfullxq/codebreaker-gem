# frozen_string_literal: true

RSpec.describe Codebreaker::Game do
  let(:game) { described_class.new(Codebreaker::Player.new('Dima'), 'easy') }

  describe '#check_the_guess' do
    it 'reduces attempts counter by 1' do
      expect { game.check_the_guess(1234.digits) }.to change(game, :attempts).by(-1)
    end

    it 'returns hash' do
      expect(game.check_the_guess(1234.digits).class).to eq(Hash)
    end

    it 'returns hash with 3 keys' do
      expect(game.check_the_guess(1234.digits).keys.size).to eq(3)
    end

    it 'returns integer hash' do
      game.check_the_guess(1234.digits).each_value { |el| expect(el.class).to eq(Integer) }
    end

    data = [[6543, 5643, [2, 2, 0]], [6543, 6411, [1, 1, 2]], [6543, 6544, [3, 0, 1]], [6543, 3456, [0, 4, 0]],
            [6543, 6666, [1, 0, 3]], [6543, 2666, [0, 1, 3]], [6543, 2222, [0, 0, 4]], [6666, 1661, [2, 0, 2]],
            [1234, 3124, [1, 3, 0]], [1234, 1524, [2, 1, 1]], [1234, 1234, [4, 0, 0]]]
    data.each do |d|
      it "returns #{d[2]} with guess #{d[1]} and code #{d[0]} " do
        game.instance_variable_set(:@secret_code, d[0])
        expect(game.check_the_guess(d[1].digits).values).to eq(d[2])
      end
    end
  end
end
