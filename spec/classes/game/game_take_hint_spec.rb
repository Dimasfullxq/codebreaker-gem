# frozen_string_literal: true

RSpec.describe Codebreaker::Game do
  let(:game) { Codebreaker::Game.new(Codebreaker::Player.new('Dima'), :easy) }
  context '#take_hint' do
    it 'raises error when there is no hints left' do
      game.instance_variable_set(:@hints, 0)
      expect { game.take_hint }.to raise_error(Codebreaker::HintsError)
    end
    it 'returns number' do
      expect(game.take_hint.class).to eq(Integer)
    end
    it 'returns only one number' do
      expect(game.take_hint.to_s.size).to eq(1)
    end
    it 'returns one random number from secret code' do
      expect(game.secret_code.digits).to include(game.take_hint)
    end
    it 'removes one element from list of hints' do
      expect { game.take_hint }.to change { game.instance_variable_get(:@list_of_hints).size }.by(-1)
    end
    it 'reduces hint counter by 1' do
      expect { game.take_hint }.to change { game.hints }.by(-1)
    end
  end
end
