FactoryGirl.define do

  # Shared traits for date field
  trait :one_month_ago do
    event_date { 1.month.ago }
  end

  trait :three_months_ago do
    event_date { 3.months.ago }
  end

  trait :six_months_ago do
    event_date { 6.months.ago }
  end

  trait :one_year_ago do
    event_date { 1.year.ago }
  end

  factory :recipe_selected, class: Graph::RecipeInteractions::Selected do
    event_date { Time.now }

    trait :with_nodes do
      from_node { create(:graph_user) }
      to_node { create(:recipe) }
    end

    trait :confirmed do
      date_confirmed { Date.today }
    end
  end

  factory :recipe_rated, class: Graph::RecipeInteractions::Rated do
    event_date { Time.now }

    trait :with_nodes do
      from_node { create(:graph_user) }
      to_node { create(:recipe) }
    end

    trait :dislike do
      rating -1
    end

    trait :meh do
      rating 0
    end

    trait :like do
      rating 1
    end
  end
end
