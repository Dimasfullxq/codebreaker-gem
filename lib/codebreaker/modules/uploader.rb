# frozen_string_literal: true

module Codebreaker
  # uploader module
  module Uploader
    def save_results(file_name, data)
      stats = File.file?(file_name) && !File.zero?(file_name) ? YAML.load_file(file_name) : []
      stats << data
      file = File.open(file_name, 'w')
      file.write(stats.to_yaml)
      file.close
    end
  end
end
