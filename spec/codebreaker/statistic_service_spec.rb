# frozen_string_literal: true

RSpec.describe Codebreaker::StatisticService do
  let(:game) { Codebreaker::Game.new(Codebreaker::Player.new('Dima'), 'easy') }
  let(:statistic) { described_class.new(game, 'results.yml') }

  describe '#save_results' do
    after { File.delete('results.yml') }

    it 'creates file if it does not exist' do
      statistic.save_results
      expect(File.file?('results.yml')).to be(true)
    end

    it 'addes one element to files array in a single call' do
      statistic.save_results
      expect { statistic.save_results }
        .to change { YAML.load_file('results.yml').size }.from(1).to(2)
    end
  end
end
