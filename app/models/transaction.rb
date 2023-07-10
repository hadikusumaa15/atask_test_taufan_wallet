class Transaction < ApplicationRecord
  validates :amount, presence: true
  belongs_to :source_wallet, class_name: 'Wallet', optional: true
  belongs_to :target_wallet, class_name: 'Wallet', optional: true

  def transaction_type(user)
    self.source_wallet == user.wallet ? 'debit' : 'credit'
  end

  def validate_source_balance
    return false unless self.amount > 0
    return false unless self.source_wallet.balance > self.amount if self.source_wallet

    true
  end

  def self.wallet_all_transactions(wallet_id:)
    self.where(source_wallet: wallet_id).or(self.where(target_wallet: wallet_id))
  end
end
