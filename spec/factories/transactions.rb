FactoryBot.define do
  factory :transaction do
    amount { 10_000 }
    source_wallet { nil }
    target_wallet { create(:wallet, walletable: create(:user)) }
  end
end
