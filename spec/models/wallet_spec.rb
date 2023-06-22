require 'rails_helper'

RSpec.describe Wallet, type: :model do
  it 'saves valid attributes with user' do
    user = User.create(username: 'my_user', access_token: '999888')
    wallet = Wallet.new(walletable: user)
    expect(wallet).to be_valid
  end
end
