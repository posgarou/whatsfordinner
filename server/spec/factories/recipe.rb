FactoryGirl.define do
  factory :recipe, class: Graph::Recipe do
    transient do
      associated_ingredients 0
      associated_tags 0
    end
    title { generate :unique_name }
    description { 'Here is a description of the recipe and why you should eat it. It is good!' }

    after :create do |recipe, evaluator|
      evaluator.associated_ingredients.times do
        ingredient = FactoryGirl.create(:ingredient)

        create(:made_with, :one, from_node: recipe, to_node: ingredient)
      end

      evaluator.associated_tags.times do
        recipe.tags << FactoryGirl.create(:tag)
      end
    end

    trait :with_tags do
      associated_tags 3
    end

    trait :with_ingredients do
      associated_ingredients 6
    end
  end
end
