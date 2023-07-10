class Wallet < ApplicationRecord
  has_many :transactions
  belongs_to :walletable, polymorphic: true

  validates :balance, presence: true, numericality: { greater_than_or_equal_to: 0 }

  def current_balance
    balance = Transaction.wallet_credit(wallet: self) - Transaction.wallet_debit(wallet: self)
    self.update(balance: balance)

    self.balance
  end

  def wallet_owner
    case self.walletable_type
    when 'User'
      return self.walletable.username
    when 'Team'
      return self.walletable.name
    when 'Stock'
      return self.walletable.name
    else
      return 'External'
    end
  end
end
