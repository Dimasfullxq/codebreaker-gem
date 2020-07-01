# frozen_string_literal: true

RSpec.describe Codebreaker::Game do
  let(:game) { Codebreaker::Game.new(Codebreaker::Player.new('Dima'), :easy) }
  context '#save_results' do
    after(:each) { File.delete(Codebreaker::Game::GAME_RESULTS_FILE) }
    it 'creates file if it does not exist', :focus do
      game.save_results(Codebreaker::Game::GAME_RESULTS_FILE, 'data')
      expect(File.file?(Codebreaker::Game::GAME_RESULTS_FILE)).to be(true)
    end
    it 'addes one element to files array in a single call' do
      game.save_results(Codebreaker::Game::GAME_RESULTS_FILE, 'data1')
      expect { game.save_results(Codebreaker::Game::GAME_RESULTS_FILE, 'data1') }
        .to change { YAML.load_file(Codebreaker::Game::GAME_RESULTS_FILE).size }.by(1)
    end
  end
end
