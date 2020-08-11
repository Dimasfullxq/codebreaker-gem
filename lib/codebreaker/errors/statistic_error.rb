# frozen_string_literal: true

module Codebreaker
  module Errors
    # class error
    class StatisticError < StandardError
      def initialize(message = 'There is no saved stats, yet!')
        super(message)
      end
    end
  end
end
