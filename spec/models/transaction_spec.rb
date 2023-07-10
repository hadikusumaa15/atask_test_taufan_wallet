require 'rails_helper'

RSpec.describe Transaction, type: :model do
  let(:user_a) {create(:user)}
  let(:user_b) {create(:user)}

  it 'saves valid attributes' do
    source_wallet = nil
    target_wallet = create(:wallet, walletable: user_a)
    transaction = Transaction.new(amount: 10.0, source_wallet: source_wallet, target_wallet: target_wallet)
    expect(transaction).to be_valid
  end

  it 'should validate source balance' do
    source_wallet = create(:wallet, walletable: user_a, balance: 0)
    target_wallet = create(:wallet, walletable: user_b, balance: 0)
    transaction = Transaction.new(amount: 10.0, source_wallet: source_wallet, target_wallet: target_wallet)

    expect(transaction).to_not be_valid
    expect(transaction.errors.full_messages).to eq ["Amount insufficient balance"]
  end

  it 'should allow sufficient source balance' do
    transaction_amount = 1000
    source_wallet = create(:wallet, walletable: user_a, balance: 0)
    target_wallet = create(:wallet, walletable: user_b, balance: 0)
    create(:transaction, amount: transaction_amount, source_wallet: nil, target_wallet: source_wallet)
    transaction = Transaction.new(amount: transaction_amount, source_wallet: source_wallet, target_wallet: target_wallet)

    expect(transaction).to be_valid

    transaction.save

    expect(source_wallet.current_balance).to eq 0
    expect(target_wallet.current_balance).to eq 1000
  end
end
