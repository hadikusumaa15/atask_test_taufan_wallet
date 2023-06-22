FactoryBot.define do
  factory :transaction do
    amount { 10.0 }
    association :source_wallet, factory: :wallet
    association :target_wallet, factory: :wallet
  end
end
