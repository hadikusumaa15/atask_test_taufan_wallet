require 'rails_helper'

RSpec.describe Team, type: :model do
  it 'saves valid attributes' do
    team = Team.new(name: 'my_team')
    expect(team).to be_valid
  end
end
