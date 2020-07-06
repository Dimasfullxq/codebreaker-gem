# frozen_string_literal: true

module Codebreaker
  # player entity
  class Player
    attr_reader :name

    extend Validator

    def initialize(name)
      @name = name
    end

    def self.valid?(name)
      validate_name?(name)
    end
  end
end
