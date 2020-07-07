# frozen_string_literal: true

RSpec.describe Codebreaker::Player do
  let(:player) { described_class.new('Liza') }

  describe '.initialize' do
    it 'has name field' do
      expect(player.instance_variables).to include(:@name)
    end

    it 'name is Liza' do
      expect(player.name).to eq('Liza')
    end
  end

  describe '.valid?' do
    it 'raises ShortNameError' do
      expect { described_class.valid?('Di') }.to raise_error(Codebreaker::ShortNameError)
    end

    it 'raises LongNameError' do
      expect { described_class.valid?('Dimonchikmangoddamnboy') }.to raise_error(Codebreaker::LongNameError)
    end

    it 'raises ClassError' do
      expect { described_class.valid?('Dimon123') }.to raise_error(Codebreaker::ClassError)
    end
  end
end
