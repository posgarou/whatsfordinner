module Graph
  class Recipe
    include Neo4j::ActiveNode

    property :title, index: :exact
    property :description

    has_many :out, :tags, type: :tagged_as, model_class: Graph::Tag

    # TODO Add has_many :out, :flavors and make the relationship in FlavorProfile polymorphic

    has_many :out, :ingredients, type: :made_with, model_class: Graph::Ingredient
  end
end
