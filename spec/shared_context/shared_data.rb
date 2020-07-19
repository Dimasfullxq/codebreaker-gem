# frozen_string_literal: true

RSpec.shared_context 'when creates stats', shared_context: :metadata do
  before do
    file = File.open('res.yml', 'w')
    data = [{ player: player, difficulty: :easy, attempts_total: 15,
              attempts_used: 10, hints_total: 2, hints_used: 1 }]
    file.write(data.to_yaml)
    file.close
  end

  after { File.delete('res.yml') }
end
