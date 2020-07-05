# frozen_string_literal: true

module Codebreaker
  # validataor module
  module Validator
    include Errors
    NAME_MIN_SIZE = 3
    NAME_MAX_SIZE = 20
    DIFFICULTY_LIST = %w[easy medium hell].freeze

    private

    def validate_name?(name)
      name.match?(/[\d_\s]/) ? raise(ClassError) : true
      name.size < NAME_MIN_SIZE ? raise(ShortNameError) : true
      name.size > NAME_MAX_SIZE ? raise(LongNameError) : true
    end

    def validate_difficulty?(difficulty)
      !DIFFICULTY_LIST.include?(difficulty) ? raise(WrongCommandError, 'Choose correct difficulty') : true
    end

    def validate_guess?(guess)
      return true if guess == 'hint'

      condition = guess.size < Codebreaker::Game::SECRET_CODE_SIZE || guess.size > Codebreaker::Game::SECRET_CODE_SIZE
      condition ? raise(WrongCommandError, "Code size must be #{Codebreaker::Game::SECRET_CODE_SIZE}") : true
      guess.match?(/[a-zA-Z\s_07-9*&%$#]/) ? raise(WrongCommandError, 'Put only numbers from 1 to 6') : true
    end
  end
end
