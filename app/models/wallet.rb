class Wallet < ApplicationRecord
  has_many :transactions
  belongs_to :walletable, polymorphic: true

  validates :balance, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
