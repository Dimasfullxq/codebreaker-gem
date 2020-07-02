# frozen_string_literal: true

# codebreaker
module Codebreaker
  include Errors
  # game entity
  class Game
    SECRET_CODE_SIZE = 4
    SECRET_CODE_NUMBERS = (1..6).freeze
    DIFFICALTIES = { easy: { attempts: 15, hints: 2 },
                     medium: { attempts: 10, hints: 1 },
                     hell: { attempts: 5, hints: 1 } }.freeze
    GAME_RESULTS_FILE = 'results.yml'
    POSITIVE = '+'
    NEGATIVE = '-'
    NONE = ' '

    attr_reader :player, :difficalty, :attempts, :hints, :secret_code

    include Uploader

    def initialize(player, difficalty)
      @player = player
      @difficalty = difficalty
      @attempts = DIFFICALTIES[difficalty][:attempts]
      @hints = DIFFICALTIES[difficalty][:hints]
      @secret_code = generate_secret_code
      @list_of_hints = @secret_code.digits.reverse
    end

    def take_hint
      raise Codebreaker::HintsError if @hints.zero?

      random_index = rand(0...@list_of_hints.size)
      hint = @list_of_hints[random_index]
      @list_of_hints.delete_at(random_index)
      @hints -= 1
      hint
    end

    def check_the_guess(code, guess)
      @attempts -= 1
      code_guess = code.zip(guess)
      check = POSITIVE * (code.size - code_guess.delete_if { |num| num[0] == num[1] }.size) +
              NEGATIVE * negative(code_guess)
      check += none_get(check) if check.size < SECRET_CODE_SIZE
      check
    end

    def create_stats
      attempts_total = DIFFICALTIES[@difficalty][:attempts]
      attempts_used = attempts_total - @attempts
      hints_total = DIFFICALTIES[@difficalty][:hints]
      hints_used = hints_total - @hints
      { player: @player, difficalty: @difficalty, attempts_total: DIFFICALTIES[@difficalty][:attempts],
        attempts_used: attempts_used, hints_total: hints_total, hints_used: hints_used }
    end

    private

    def generate_secret_code
      code = ''
      SECRET_CODE_SIZE.times { code += rand(SECRET_CODE_NUMBERS).to_s }
      code.to_i
    end

    def negative(code_guess)
      code_numbers = code_guess.map { |num| num[0] }
      guess_numbers = code_guess.map { |num| num[1] }
      guess_numbers.map { |guess| code_numbers.select { |code| code == guess } }.flatten.uniq.size
    end

    def none_get(check)
      NONE * (SECRET_CODE_SIZE - check.size)
    end
  end
end
