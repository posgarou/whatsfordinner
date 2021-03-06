# NOTE TO FUTURE SELF:
#
# neo4j DOES NOT WORK with unsaved instances in tests.  You must call `#create`.
# That is why all of the callbacks below for Graph objects use after_create hooks.

FactoryGirl.define do
  factory :user do
    name 'Ryan'
    email 'foo@foo.com'
    provider 'google_oauth2'
    image_url 'https://lh3.googleusercontent.com/url/photo.jpg'
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

    trait :google do
      # defaults above
    end

    trait :facebook do
      provider 'facebook'
      image_url 'http://graph.facebook.com/1234567/picture?type=square'
    end

    factory :admin_user do
      after :build do |user, _evaluator|
        user.admin!
      end
    end
  end

  factory :null_user, class: User::NullUser do
  end
end
