# frozen_string_literal: true

module Codebreaker
  # statistic entity
  class StatisticService
    def initialize(file_name)
      @file_name = file_name
      @stats_sorter = StatisticSorter.new(file_name)
    end

    def save_results(game)
      @game = game
      stats = File.file?(@file_name) && !File.zero?(@file_name) ? YAML.load_file(@file_name) : []
      stats << create_stats
      file = File.open(@file_name, 'w')
      file.write(stats.to_yaml)
      file.close
    end

    def show_results
      condition = File.file?(@file_name) && !File.zero?(@file_name)
      condition ? @stats_sorter.create_table : raise(Codebreaker::StatisticError)
    end

    private

    def create_stats
      attempts_total = Game::DIFFICULTIES[@game.difficulty][:attempts]
      attempts_used = attempts_total - @game.attempts
      hints_total = Game::DIFFICULTIES[@game.difficulty][:hints]
      hints_used = hints_total - @game.hints
      { player: @game.player, difficulty: @game.difficulty, attempts_total: attempts_total,
        attempts_used: attempts_used, hints_total: hints_total, hints_used: hints_used }
    end
  end
end
