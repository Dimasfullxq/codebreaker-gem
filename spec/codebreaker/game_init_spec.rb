# frozen_string_literal: true

RSpec.describe Codebreaker::Game do
  let(:game) { described_class.new(Codebreaker::Player.new('Dima'), :easy) }

  describe '.initialize' do
    it 'saves a secret code' do
      expect(game.secret_code).not_to be nil
    end

    it 'secret code has 4 numbers' do
      expect(game.secret_code.digits.size).to eq(4)
    end

    it 'secret code with numbers from 1 to 6' do
      expect(game.secret_code.to_s).to match(/[1-6]+/)
    end

    it 'its difficulty is easy' do
      expect(game.difficulty).to eq(:easy)
    end

    it 'has attempts for each difficulty' do
      expect(game.attempts).to eq(Codebreaker::Game::DIFFICULTIES[game.difficulty][:attempts])
    end

    it 'has hints for each difficulty' do
      expect(game.hints).to eq(Codebreaker::Game::DIFFICULTIES[game.difficulty][:hints])
    end

    it 'has list of hints equal to secret code' do
      expect(game.instance_variable_get(:@list_of_hints)).to eq(game.secret_code.digits.reverse)
    end
  end
end
