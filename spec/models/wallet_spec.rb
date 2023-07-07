require 'rails_helper'

RSpec.describe Wallet, type: :model do
  it 'saves valid attributes' do
    wallet = Wallet.new(balance: 10_000, walletable: create(:user))

    expect(wallet).to be_valid
  end

  it 'should have 0 or more balance' do
    user = create(:user)
    wallet_minus = Wallet.new(balance: -10_000, walletable: user)
    wallet_nil = Wallet.new(balance: nil, walletable: user)

    expect(wallet_minus).to_not be_valid
    expect(wallet_nil).to_not be_valid
  end
end
