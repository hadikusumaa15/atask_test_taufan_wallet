class User < ApplicationRecord
  has_one :wallet, as: :walletable
  validates :username, presence: true, length: { minimum: 6 }, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }
end
