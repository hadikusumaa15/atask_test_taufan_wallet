class Wallet < ApplicationRecord
  has_many :transactions
  belongs_to :walletable, polymorphic: true

  validates :balance, presence: true, numericality: { greater_than_or_equal_to: 0 }

  def current_balance
    balance = Transaction.wallet_credit(wallet: self) - Transaction.wallet_debit(wallet: self)
    self.update(balance: balance)

    self.balance
  end

  def self.generate_new_stock_wallet(user:, indices:, identifier:)
    stock = Stock.create(
      user: user,
      indices: indices,
      identifier: identifier,
      owned_amount: 0
    )

    wallet = self.create(
      balance: 0,
      walletable: stock,
      description: "Wallet Stock Owned by #{user.username}"
    )
  end

  def wallet_owner
    case self.walletable_type
    when 'User'
      return self.walletable.username
    when 'Team'
      return self.walletable.name
    when 'Stock'
      return self.walletable.identifier
    else
      return 'External'
    end
  end
end
