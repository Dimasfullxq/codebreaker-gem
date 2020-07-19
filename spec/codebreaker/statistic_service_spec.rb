# frozen_string_literal: true

RSpec.describe Codebreaker::StatisticService do
  let(:player) { Codebreaker::Player.new('Dima') }
  let(:game) { Codebreaker::Game.new(player, 'easy') }

  describe '#save_results' do
    let(:statistic) { described_class.new('results.yml') }

    after { File.delete('results.yml') }

    it 'creates file if it does not exist' do
      statistic.save_results(game)
      expect(File.file?('results.yml')).to be(true)
    end

    it 'addes one element to files array in a single call' do
      statistic.save_results(game)
      expect { statistic.save_results(game) }
        .to change { YAML.load_file('results.yml').size }.from(1).to(2)
    end
  end

  describe '#show_stats' do
    include_context 'when creates stats'

    it 'returns array if file exists' do
      statistic = described_class.new('res.yml')
      expect(statistic.show_results.class).to eq(Array)
    end

    it 'raises error that there is no statistic if file does not exist' do
      statistic = described_class.new('res1.yml')
      expect { statistic.show_results }.to raise_error(Codebreaker::StatisticError)
    end
  end
end
