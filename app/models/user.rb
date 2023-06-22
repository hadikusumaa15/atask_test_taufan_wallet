class User < ApplicationRecord
  has_one :wallet, as: :walletable
end
