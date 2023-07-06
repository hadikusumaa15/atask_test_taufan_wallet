class User < ApplicationRecord
  has_one :wallet, as: :walletable
  validates :password, presence: true, length: { minimum: 6 }
end
