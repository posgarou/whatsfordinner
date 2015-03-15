FactoryGirl.define do
  factory :tag, class: Graph::Tag do
    transient do
      associated_recipes 0
    end

    name { generate :unique_name }

    after :create do |flavor, evaluator|
      evaluator.associated_recipes.times do
        flavor.recipes << FactoryGirl.create(:recipe)
      end
    end

    trait :with_recipes do
      associated_recipes 2
    end
  end
end
