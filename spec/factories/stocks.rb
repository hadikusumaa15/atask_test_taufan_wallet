FactoryBot.define do
  factory :stock do
    indices {"Elon Musk"}
    identifier { "Tesla" }
    category { "Technology" }
    description { "Electric car company." }
  end
end
