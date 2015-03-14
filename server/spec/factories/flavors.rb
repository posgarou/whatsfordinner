FactoryGirl.define do
  factory :flavor, class: Graph::FlavorProfile do
    transient do
      associated_ingredients 0
    end

    name { generate :unique_name }

    after :create do |flavor, evaluator|
      evaluator.associated_ingredients.times do
        flavor.ingredients << FactoryGirl.create(:ingredient)
      end
    end

    trait :with_ingredients do
      associated_ingredients 2
    end
  end
end
