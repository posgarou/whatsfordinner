module Graph
  class User
    include Neo4j::ActiveNode

    # String since it's a Mongoid ID
    property :user_id, type: String

    # Specify a persistent id
    id_property :uuid, auto: :uuid

    has_many :out, :selected_recipes, rel_class: Graph::RecipeInteractions::Selected, model_class: Graph::Recipe
    has_many :out, :rated_recipes, rel_class: Graph::RecipeInteractions::Rated, model_class: Graph::Recipe
    has_many :out, :rejected_recipes, rel_class: Graph::RecipeInteractions::Rejected, model_class: Graph::Recipe

    def standard_user
      ::User.find(user_id)
    end
  end
end
