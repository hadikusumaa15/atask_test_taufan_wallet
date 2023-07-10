FactoryBot.define do
  factory :user do
    username { SecureRandom.alphanumeric(10) }
    password {'my_password'}
    access_token {'my_token'}
    access_token_expired_date {Time.now + 1.day}
    team { create(:team) }
  end
end
