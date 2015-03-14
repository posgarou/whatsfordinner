FactoryGirl.define do
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
