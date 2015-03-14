FactoryGirl.define do
  factory :graph_user, class: Graph::User do
    transient do
      user { FactoryGirl.create(:user) }
    end

    user_id { user.id }
  end
end
