# frozen_string_literal: true

module Codebreaker
  # validataor module
  module Validator
    include Errors
    NAME_MIN_SIZE = 3
    NAME_MAX_SIZE = 20
    SECRET_CODE_SIZE = 4
    SECRET_CODE_NUMBERS = (1..6).freeze
    DIFFICULTY_LIST = "'easy', 'medium', 'hell'"
    WRONG_GUESS_SIZE_MESSAGE = "Code size must be #{SECRET_CODE_SIZE}"
    GUESS_MATCHING = /[^#{SECRET_CODE_NUMBERS.first}-#{SECRET_CODE_NUMBERS.last}]/.freeze
    WRONG_GUESS_MATCHING_MESSAGE = "Put only numbers from #{SECRET_CODE_NUMBERS.first} " \
                                   "to #{SECRET_CODE_NUMBERS.last}"

    private

    def validate_name?(name)
      name.match?(/[^a-zA-Z]/) ? raise(ClassError) : true
      name.size < NAME_MIN_SIZE ? raise(ShortNameError) : true
      name.size > NAME_MAX_SIZE ? raise(LongNameError) : true
    end

    def validate_difficulty?(difficulty)
      !DIFFICULTY_LIST.include?(difficulty) ? raise(WrongCommandError, 'Choose correct difficulty') : true
    end

    def validate_guess?(guess)
      condition = guess.size < SECRET_CODE_SIZE || guess.size > SECRET_CODE_SIZE
      condition ? raise(WrongCommandError, WRONG_GUESS_SIZE_MESSAGE) : true
      guess.match?(GUESS_MATCHING) ? raise(WrongCommandError, WRONG_GUESS_MATCHING_MESSAGE) : true
    end
  end
end
