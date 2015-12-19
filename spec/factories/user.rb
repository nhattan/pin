FactoryGirl.define do
  factory :user do
    sequence(:email){ |i| "user#{i}@gmail.com" }
    password  "123123123"
  end
end
