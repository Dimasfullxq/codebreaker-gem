# frozen_string_literal: true

module Codebreaker
  # player entity
  class Player
    attr_reader :name

    def initialize(name)
      @name = name
    end
  end
end
