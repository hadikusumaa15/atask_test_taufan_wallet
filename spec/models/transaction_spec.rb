require 'rails_helper'

RSpec.describe Transaction, type: :model do
  it 'saves valid attributes' do
    user = User.create(username: 'my_user', access_token: '999888')
    source_wallet = Wallet.create(walletable: user)
    target_wallet = Wallet.create(walletable: user)
    transaction = Transaction.new(amount: 10.0, source_wallet: source_wallet, target_wallet: target_wallet)
    expect(transaction).to be_valid
  end
end
