FactoryBot.define do
  factory :user do
    username {'my_username'}
    password {'my_password'}
    access_token {'my_token'}
  end
end
