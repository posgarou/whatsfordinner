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
  end

  sequence :unique_name do |n|
    "name#{n}"
  end

  factory :ingredient, class: Graph::Ingredient do
    transient do
      associated_ingredient_groups 0
    end

    name { generate :unique_name }

    after :create do |ingredient, evaluator|
      evaluator.associated_ingredient_groups.times do
        ingredient.groups << FactoryGirl.create(:ingredient_group)
      end
    end

    trait :with_ingredient_groups do
      associated_ingredient_groups 2
    end
  end

  factory :ingredient_group, class: Graph::IngredientGroup do
    transient do
      associated_ingredients 0
      associated_ingredient_groups 0
    end

    name { generate :unique_name }

    after :create do |ingredient_group, evaluator|
      evaluator.associated_ingredients.times do
        ingredient_group.ingredients << FactoryGirl.create(:ingredient)
      end

      evaluator.associated_ingredient_groups.times do
        ingredient_group.groups << FactoryGirl.create(:ingredient_group)
      end
    end

    trait :with_ingredient_groups do
      associated_ingredient_groups 2
    end

    trait :with_ingredients do
      associated_ingredients 2
    end
  end
end
