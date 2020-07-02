# frozen_string_literal: true

RSpec.describe Codebreaker::Player do
  let(:player) { described_class.new('Liza') }

  it 'has name field' do
    expect(player.instance_variables).to include(:@name)
  end

  it 'name is Liza' do
    expect(player.name).to eq('Liza')
  end
end
