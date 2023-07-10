FactoryBot.define do
  factory :team do
    name { SecureRandom.alphanumeric(10) }
    description { "the best team in the world" }
  end
end
  
  