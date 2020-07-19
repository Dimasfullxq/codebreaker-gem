# frozen_string_literal: true

module Codebreaker
  # statistic sorter entity
  class StatisticSorter
    def initialize(file_name)
      @file_name = file_name
    end

    def show_stats
      File.file?(@file_name) && !File.zero?(@file_name) ? create_table : 'There is no saved stats, yet!'
    end

    private

    def read_stats
      YAML.load_file(@file_name)
    end

    def group_by_difficulty
      read_stats.sort_by { |el| [el[:attempts_total], el[:hints_used]] }.group_by { |stat| stat[:difficulty] }
    end

    def group_by_hints
      group_by_difficulty.flat_map { |_, stat| stat.group_by { |field| field[:hints_used] } }
    end

    def sorted_stats
      group_by_hints.map { |hash| hash.map { |_, stat| stat.sort_by { |field| field[:attempts_used] } } }.flatten
    end

    def create_table
      sorted_stats.flat_map do |stat|
        ["Name: #{stat[:player].name}\nDifficulty: #{stat[:difficulty]}
Attempts total: #{stat[:attempts_total]}\nAttempts used: #{stat[:attempts_used]}\nHints total: #{stat[:hints_total]}
Hints used: #{stat[:hints_used]}"]
      end
    end
  end
end
