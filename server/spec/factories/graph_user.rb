FactoryGirl.define do
  factory :graph_user, class: Graph::User do
    after :create do |user, evaluator|
      user.user_id ||= evaluator.try(:user) || create(:user, uuid: user.uuid).id
      user.save
    end

    # You need to define interaction_set to use this factory
    trait :with_interactions do
      transient do
        interaction_set []
        recipes { [create(:recipe)] }
      end

      after :create do |user, evaluator|
        evaluator.recipes.each do |recipe|

          evaluator.interaction_set.each do |interaction|
            create(interaction[0], from_node: user, to_node: recipe, event_date: interaction[1])
          end
        end
      end
    end

    trait :selected_and_rated do
      transient do
        interaction_set {
          [
            [:recipe_rated, Time.now],
            [:recipe_rated, 1.day.ago],
            [:recipe_selected, 1.hour.ago],
            [:recipe_selected, 1.month.ago],
            [:recipe_selected, 2.days.ago],
            [:recipe_selected, 1.year.ago]
          ]
        }
      end
    end
  end
end
