# frozen_string_literal: true

RSpec.describe Codebreaker::Game do
  let(:game) { Codebreaker::Game.new(Codebreaker::Player.new('Dima'), :easy) }
  context '#create_stats' do
    it 'returns a hash' do
      expect(game.create_stats.class).to eq(Hash)
    end
    it 'creates a hash with 6 keys' do
      expect(game.create_stats.keys.size).to eq(6)
    end
  end
end
