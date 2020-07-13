# frozen_string_literal: true

# codebreaker
module Codebreaker
  include Errors
  # game entity
  class Game
    SECRET_CODE_SIZE = 4
    SECRET_CODE_NUMBERS = (1..6).freeze
    DIFFICULTIES = { easy: { attempts: 15, hints: 2 },
                     medium: { attempts: 10, hints: 1 },
                     hell: { attempts: 5, hints: 1 } }.freeze

    attr_reader :player, :difficulty, :attempts, :hints, :secret_code

    include Uploader
    extend Validator

    def initialize(player, difficulty)
      @player = player
      @difficulty = difficulty.to_sym
      @attempts = DIFFICULTIES[@difficulty][:attempts]
      @hints = DIFFICULTIES[@difficulty][:hints]
      @secret_code = generate_secret_code
      @list_of_hints = @secret_code.digits.reverse
    end

    def self.valid?(difficulty)
      validate_difficulty?(difficulty)
    end

    def self.guess_valid?(guess)
      validate_guess?(guess)
    end

    def take_hint
      raise Codebreaker::HintsError if @hints.zero?

      random_index = rand(0...@list_of_hints.size)
      hint = @list_of_hints[random_index]
      @list_of_hints.delete_at(random_index)
      @hints -= 1
      hint
    end

    def check_the_guess(guess)
      @attempts -= 1
      @code_guess = zipped(guess)
      check = { positive: positive, negative: negative, none: 0 }
      check[:none] += none(check)
      check
    end

    def create_stats
      attempts_total = DIFFICULTIES[@difficulty][:attempts]
      attempts_used = attempts_total - @attempts
      hints_total = DIFFICULTIES[@difficulty][:hints]
      hints_used = hints_total - @hints
      { player: @player, difficulty: @difficulty, attempts_total: attempts_total,
        attempts_used: attempts_used, hints_total: hints_total, hints_used: hints_used }
    end

    private

    def zipped(guess)
      @secret_code.digits.zip(guess)
    end

    def positive
      @secret_code.digits.size - @code_guess.delete_if { |num| num[0] == num[1] }.size
    end

    def generate_secret_code
      (1..SECRET_CODE_SIZE).map { rand(SECRET_CODE_NUMBERS) }.join.to_i
    end

    def negative
      code_numbers = @code_guess.map { |num| num[0] }
      guess_numbers = @code_guess.map { |num| num[1] }
      guess_numbers.map { |guess| code_numbers.select { |code| code == guess } }.flatten.uniq.size
    end

    def none(check)
      SECRET_CODE_SIZE - (check[:positive] + check[:negative])
    end
  end
end
