# frozen_string_literal: true

RSpec.describe Codebreaker::Validator do
  include ValidateHelper

  context '#validate_name?' do
    it 'raises ShortNameError' do
      expect { validate_field('Di', 'name') }.to raise_error(Codebreaker::ShortNameError)
    end
    it 'raises LongNameError' do
      expect { validate_field('Dimonchikmangoddamnboy', 'name') }.to raise_error(Codebreaker::LongNameError)
    end
    it 'raises ClassError' do
      expect { validate_field('Dima1234__ ', 'name') }.to raise_error(Codebreaker::ClassError)
    end
  end
  context '#validate_difficalty?' do
    it 'raises WrongCommandError to choose correct difficalty' do
      expect { validate_field('easyyyyy', 'difficalty') }.to raise_error(Codebreaker::WrongCommandError)
    end
  end
  context '#validate_guess?' do
    it 'raises WrongCommandError to enter correct code size ' do
      expect { validate_field('12345', 'guess') }.to raise_error(Codebreaker::WrongCommandError)
    end
    it 'raises WrongCommandError to put only numbers from 1 to 6' do
      expect { validate_field('0077', 'guess') }.to raise_error(Codebreaker::WrongCommandError)
    end
  end
end
