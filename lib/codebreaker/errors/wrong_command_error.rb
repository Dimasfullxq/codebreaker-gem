# frozen_string_literal: true

module Codebreaker
  module Errors
    # wrong input error
    class WrongCommandError < StandardError
      def initialize(message = 'You have passed unexpected command. Please choose one from listed commands.')
        super(message)
      end
    end
  end
end
