# frozen_string_literal: true

RSpec.describe Codebreaker::StatisticSorter do
  include_context 'when creates stats'
  let(:player) { Codebreaker::Player.new('Dima') }

  describe '#create_table' do
    it 'returns array' do
      stats_sorter = described_class.new('res.yml')
      expect(stats_sorter.create_table.class).to eq(Array)
    end
  end
end
