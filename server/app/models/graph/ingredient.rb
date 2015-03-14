module Graph
  class Ingredient
    include Neo4j::ActiveNode

    property :name, index: :exact

    has_many :in, :recipes, origin: :recipes, model_class: Graph::Recipe

    has_many :out, :groups, type: :group, model_class: Graph::IngredientGroup

    has_many :out, :flavors, type: :tastes, model_class: Graph::FlavorProfile
  end
end
