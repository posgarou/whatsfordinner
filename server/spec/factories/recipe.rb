FactoryGirl.define do
  factory :recipe, class: Graph::Recipe do
    transient do
      associated_ingredients 0
      associated_tags 0
      associated_steps 0
      associated_cuisines 0
    end
    title { generate :unique_name }
    description { 'Here is a description of the recipe and why you should eat it. It is good!' }
    serves 8

    prep_time 600
    cooking_time 6000

    after :create do |recipe, evaluator|
      evaluator.associated_ingredients.times do
        ingredient = FactoryGirl.create(:ingredient)

        create(:made_with, :one, from_node: recipe, to_node: ingredient)
      end

      evaluator.associated_tags.times do
        recipe.tags << FactoryGirl.create(:tag)
      end

      evaluator.associated_steps.times do |n|
        # Generate an ordered list
        recipe.steps << FactoryGirl.create(:recipe_step, number: (n+1))
      end

      evaluator.associated_cuisines.times do
        recipe.cuisines << FactoryGirl.create(:cuisine)
      end
    end

    trait :with_tags do
      associated_tags 3
    end

    trait :with_ingredients do
      associated_ingredients 6
    end

    trait :with_steps do
      associated_steps 6
    end

    trait :with_cuisines do
      associated_cuisines 2
    end
  end
end
