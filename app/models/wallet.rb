class Wallet < ApplicationRecord
  has_many :transactions
  belongs_to :walletable, polymorphic: true
end
