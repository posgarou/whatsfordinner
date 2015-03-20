FactoryGirl.define do
  factory :cuisine, class: Graph::Cuisine do
    transient do
      recipes nil
      number_of_recipes 0
    end

    name { generate :unique_name }

    after :create do |cuisine, evaluator|
      if evaluator.recipes
        cusine.recipes = evaluator.recipes
      else
        evaluator.number_of_recipes.times do
          cuisine.recipes << create(:recipe)
        end
      end

      cuisine.save
    end

  end
end
