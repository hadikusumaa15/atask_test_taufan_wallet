class Transaction < ApplicationRecord
  validates :amount, presence: true
  belongs_to :source_wallet, class_name: 'Wallet', optional: true
  belongs_to :target_wallet, class_name: 'Wallet', optional: true
end
