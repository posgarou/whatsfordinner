module Graph
  class Ingredient
    include Neo4j::ActiveNode

    property :name, index: :exact

    has_many :out, :groups, type: :group, model_class: Graph::IngredientGroup
  end
end