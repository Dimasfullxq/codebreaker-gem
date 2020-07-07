# frozen_string_literal: true

RSpec.describe Codebreaker::Game do
  describe '.valid?' do
    it 'raises WrongCommandError to choose correct difficulty' do
      expect { described_class.valid?('easyyyyyyyyy') }.to raise_error(Codebreaker::WrongCommandError)
    end
  end

  describe '.guess_valid?' do
    it 'raises WrongCommandError to enter correct code size' do
      expect { described_class.guess_valid?('12') }.to raise_error(Codebreaker::WrongCommandError)
    end

    it 'raises WrongCommandError to put only numbers from 1 to 6' do
      expect { described_class.guess_valid?('0077') }.to raise_error(Codebreaker::WrongCommandError)
    end
  end
end
