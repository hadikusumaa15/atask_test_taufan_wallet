FactoryBot.define do
  factory :wallet do
    balance { 0 }
    walletable_type { "User" }
    walletable_id { create(:user).id }
  end
end
