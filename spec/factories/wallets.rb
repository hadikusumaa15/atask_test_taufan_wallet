FactoryBot.define do
  factory :wallet do
    balance { 10_000 }
    walletable_type { "User" }
    walletable_id { create(:user).id }
  end
end
