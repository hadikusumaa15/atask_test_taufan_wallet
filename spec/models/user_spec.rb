require 'rails_helper'

RSpec.describe User, type: :model do
  it 'saves valid attributes' do
    user = User.new(username: 'my_username', access_token: '999777', password: 'my_password')

    expect(user).to be_valid
  end

  it 'should have one wallet' do
    user = create(:user)
    wallet = create(:wallet, walletable: user)

    expect(user.wallet).to eq(wallet)
  end

  it 'should not accept password less than 6 characters' do
    user = User.new(username: 'my_username', access_token: '999777', password: 'pass')

    expect(user.valid?).to be false
    expect(user.errors.messages[:password]).to include "is too short (minimum is 6 characters)"
  end

  it 'should not accept passwordless user' do
    user = User.new(username: 'my_username', access_token: '999777')

    expect(user.valid?).to be false
    expect(user.errors.messages[:password]).to include "can't be blank"
    expect(user.errors.messages[:password]).to include "is too short (minimum is 6 characters)"
  end
end
