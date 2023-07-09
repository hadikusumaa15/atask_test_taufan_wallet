FactoryBot.define do
  factory :user do
    username {'my_username'}
    password {'my_password'}
    access_token {'my_token'}
    access_token_expired_date {Time.now + 1.day}
    team { create(:team) }
  end
end
