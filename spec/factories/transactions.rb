FactoryBot.define do
  factory :transaction do
    amount { 100.00 }
    source_wallet { create(:wallet, walletable: create(:user)) }
    target_wallet { create(:wallet, walletable: create(:user)) }
  end
end
