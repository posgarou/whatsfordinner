FactoryGirl.define do
  factory :user do
    name 'Ryan'
    email 'foo@foo.com'
    provider 'Google'
    uid '191283'
    oauth_token '3234k134n1b34'
    oauth_expires_at 3.days.from_now

    trait :no_token do
      oauth_token nil
      oauth_expires_at nil
    end

    trait :expired_token do
      oauth_expires_at 1.minute.ago
    end
  end
end
