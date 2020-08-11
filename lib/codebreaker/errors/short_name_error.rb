# frozen_string_literal: true

module Codebreaker
  module Errors
    # short name error
    class ShortNameError < StandardError
      def initialize(message = 'Your name is too short')
        super(message)
      end
    end
  end
end
