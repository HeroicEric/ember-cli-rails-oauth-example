FactoryGirl.define do
  factory :access_token do
    association :user

    trait :active do
      expires_at { Time.zone.now + 1.week }
    end

    trait :inactive do
      expires_at { Time.zone.now - 1.week }
    end
  end
end
