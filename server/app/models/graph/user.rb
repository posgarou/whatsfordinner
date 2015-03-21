module Graph
  class User
    include Neo4j::ActiveNode

    # String since it's a Mongoid ID
    property :user_id, type: String

    # Specify a persistent id
    id_property :uuid, auto: :uuid

    # A user can select the same recipe multiple times
    has_many :out,
      :selected_recipes,
      rel_class: Graph::RecipeInteractions::Selected,
      model_class: Graph::Recipe

    # A user can reject a recipe multiple times
    has_many :out,
      :rejected_recipes,
      rel_class: Graph::RecipeInteractions::Rejected,
      model_class: Graph::Recipe

    # A recipe can only be rated once per user
    has_many :out,
      :rated_recipes,
      rel_class: Graph::RecipeInteractions::Rated,
      model_class: Graph::Recipe,
      unique: true

    def standard_user
      ::User.find(user_id)
    end

    def recipe_interactions

    end
  end
end
