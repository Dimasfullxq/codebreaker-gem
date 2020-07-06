# frozen_string_literal: true

RSpec.describe Codebreaker::Game do
  let(:game) { described_class.new(Codebreaker::Player.new('Dima'), :easy) }

  describe '#save_results' do
    after { File.delete('results.yml') }

    it 'creates file if it does not exist' do
      game.save_results('results.yml', 'data')
      expect(File.file?('results.yml')).to be(true)
    end

    it 'addes one element to files array in a single call' do
      game.save_results('results.yml', 'data1')
      expect { game.save_results('results.yml', 'data1') }
        .to change { YAML.load_file('results.yml').size }.by(1)
    end
  end
end
