# frozen_string_literal: true

module Codebreaker
  # player entity
  class Player
    attr_reader :name

    include Validator

    def initialize(name)
      @name = name
    end

    def validate_name
      validate_name?(@name)
    end
  end
end
