# frozen_string_literal: true

module Errors
  # long name error
  class LongNameError < StandardError
    def initialize(message = 'Your name is too long')
      super(message)
    end
  end
end
