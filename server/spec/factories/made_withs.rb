FactoryGirl.define do
  factory :made_with, class: Graph::MadeWith do
    from_node { create(:recipe) }
    to_node { FactoryGirl.create(:ingredient, name: 'sugar') }

    trait :one do
      quantity 1
    end

    trait :two do
      quantity 2
    end

    trait :with_units do
      unit_quantity 10
      unit_type 'ounces'
    end

    trait :optional do
      required false
    end
  end
end
