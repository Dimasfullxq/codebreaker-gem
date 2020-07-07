# frozen_string_literal: true

module Codebreaker
  module Errors
    # hints error
    class HintsError < StandardError
      def initialize(message = 'You have no hints left')
        super(message)
      end
    end
  end
end
