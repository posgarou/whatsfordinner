module Graph
  class Cuisine
    include Neo4j::ActiveNode

    property :name, index: :exact

    has_many :in, :recipes, model_class: Graph::Recipe
  end
end
