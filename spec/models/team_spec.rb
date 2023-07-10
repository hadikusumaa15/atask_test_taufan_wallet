require 'rails_helper'

RSpec.describe Team, type: :model do
  it 'saves valid attributes' do
    team = Team.new(name: 'my_team')

    expect(team).to be_valid
  end

  it 'has many users' do
    user = create(:user)
    team = create(:team, name: 'my_new_team', users: [user])

    expect(team.users).to eq [user]
  end

  it 'should have unique name' do
    team = create(:team)

    expect(Team.new(name: team.name)).to_not be_valid
  end
end
