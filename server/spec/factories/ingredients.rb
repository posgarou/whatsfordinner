FactoryGirl.define do
  factory :ingredient, class: Graph::Ingredient do
    transient do
      associated_ingredient_groups 0
      associated_flavors 0
    end

    name { generate :unique_name }

    after :create do |ingredient, evaluator|
      evaluator.associated_ingredient_groups.times do
        ingredient.groups << FactoryGirl.create(:ingredient_group)
      end

      evaluator.associated_flavors.times do
        ingredient.flavors << FactoryGirl.create(:flavor)
      end
    end

    trait :with_ingredient_groups do
      associated_ingredient_groups 2
    end

    trait :with_flavors do
      associated_flavors 2
    end
  end
end
