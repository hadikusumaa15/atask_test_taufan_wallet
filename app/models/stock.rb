class Stock < ApplicationRecord
  belongs_to :user
  has_one :wallet, as: :walletable

  def current_owned_amount
    quantity = Transaction.where(target_wallet: self.wallet).count - Transaction.where(source_wallet: self.wallet).count
    self.update(owned_amount: quantity)

    self.owned_amount
  end

  def current_last_price
    stock_item = LatestStockPrice.price(indices: self.indices, identifier: self.identifier).first
    self.update(last_price: stock_item['lastPrice'])

    self.last_price
  end

  def recalculate_balance
    ActiveRecord::Base.transaction do
      new_balance = current_owned_amount * current_last_price
      old_balance = self.wallet.current_balance

      Transaction.create([
        {
          source_wallet: self.wallet,
          target_wallet: nil,
          amount: old_balance,
          description: 'recalculate balance debit to exchange'
        },
     
        {
          source_wallet: nil,
          target_wallet: self.wallet,
          amount: new_balance,
          description: 'recalculate balance credit from exchange'
        }
      ])

      true
    end
  end
end
