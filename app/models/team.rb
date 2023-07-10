class Team < ApplicationRecord
  has_one :wallet, as: :walletable
  has_many :users
  validates :name, presence: true, uniqueness: true
end
