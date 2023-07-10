class Transaction < ApplicationRecord
  validates :amount, presence: true
  belongs_to :source_wallet, class_name: 'Wallet', optional: true
  belongs_to :target_wallet, class_name: 'Wallet', optional: true
  validates :source_wallet, with: :validate_source_balance

  def transaction_type(user)
    self.source_wallet == user.wallet ? 'debit' : 'credit'
  end

  def validate_source_balance
    self.errors.add(:amount, 'source amount must be available') unless self.amount > 0
    self.errors.add(:amount, 'insufficient balance') unless self.source_wallet&.current_balance >= self.amount if self.source_wallet
  end

  def self.wallet_all_transactions(wallet:)
    self.where(source_wallet: wallet).or(self.where(target_wallet: wallet))
  end

  def self.wallet_debit(wallet:)
    self.where(source_wallet: wallet).pluck(:amount).compact.sum
  end

  def self.wallet_credit(wallet:)
    self.where(target_wallet: wallet).pluck(:amount).compact.sum
  end
end
