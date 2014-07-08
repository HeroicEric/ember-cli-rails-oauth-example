FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "hello#{n}@world.com" }
    sequence(:uid) { |n| n.to_s }
    sequence(:username) { |n| "user#{n}name" }
    provider 'github'
  end
end
