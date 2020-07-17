# frozen_string_literal: true

# codebreaker
module Codebreaker
  include Errors
  # game entity
  class Game
    DIFFICULTIES = { easy: { attempts: 15, hints: 2 },
                     medium: { attempts: 10, hints: 1 },
                     hell: { attempts: 5, hints: 1 } }.freeze

    attr_reader :player, :difficulty, :attempts, :hints, :secret_code

    extend Validator

    def initialize(player, difficulty)
      @player = player
      @difficulty = difficulty.to_sym
      @attempts = DIFFICULTIES[@difficulty][:attempts]
      @hints = DIFFICULTIES[@difficulty][:hints]
      @secret_code = generate_secret_code
      @list_of_hints = @secret_code.digits.reverse
    end

    def self.validate(difficulty)
      validate_difficulty(difficulty)
    end

    def self.validate_input(guess)
      validate_guess(guess)
    end

    def take_hint
      raise Codebreaker::HintsError if hints.zero?

      random_index = rand(0...@list_of_hints.size)
      hint = @list_of_hints[random_index]
      @list_of_hints.delete_at(random_index)
      @hints -= 1
      hint
    end

    def check_the_guess(guess)
      @attempts -= 1
      CodeChecker.new(secret_code, guess).result
    end

    private

    def generate_secret_code
      (1..Validator::SECRET_CODE_SIZE).map { rand(Validator::SECRET_CODE_NUMBERS) }.join.to_i
    end
  end
end
