require 'rails_helper'

RSpec.describe User, type: :model do
  it 'saves valid attributes' do
    user = User.new(username: 'my_username', access_token: '999777')

    expect(user).to be_valid
  end

  it 'should have one wallet' do
    user = create(:user)
    wallet = create(:wallet, walletable: user)

    expect(user.wallet).to eq(wallet)
  end
end
