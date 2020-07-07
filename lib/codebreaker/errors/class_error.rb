# frozen_string_literal: true

module Codebreaker
  module Errors
    # class error
    class ClassError < StandardError
      def initialize(message = 'You can put only letters')
        super(message)
      end
    end
  end
end
