# frozen_string_literal: true

module Codebreaker
  # codechecker entity
  class CodeChecker
    def initialize(secret_code, input_code)
      @secret_code = secret_code
      @input_code = input_code
      @code_guess = zipped
    end

    def result
      @check = { exect_hit: exect_hit, wrong_position_hit: wrong_position_hit, empty_hit: 0 }
      @check[:empty_hit] += empty_hit
      @check
    end

    private

    def zipped
      @secret_code.digits.zip(@input_code.to_i.digits)
    end

    def exect_hit
      @secret_code.digits.size - @code_guess.delete_if { |num_pair| num_pair[0] == num_pair[1] }.size
    end

    def wrong_position_hit
      code_numbers = @code_guess.map { |num_pair| num_pair[0] }
      guess_numbers = @code_guess.map { |num_pair| num_pair[1] }
      guess_numbers.map { |guess| code_numbers.select { |code| code == guess } }.flatten.uniq.size
    end

    def empty_hit
      Validator::SECRET_CODE_SIZE - (@check[:exect_hit] + @check[:wrong_position_hit])
    end
  end
end
