require 'rails_helper'

RSpec.describe Team, type: :model do
  it 'saves valid attributes' do
    team = Team.new(name: 'my_team')
    expect(team).to be_valid
  end

  it 'has many users' do
    user = create(:user)
    team = create(:team, users: [user])

    expect(team.users).to eq [user]
  end
end
