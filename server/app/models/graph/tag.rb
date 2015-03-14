module Graph
  class Tag
    include Neo4j::ActiveNode

    property :name, index: :exact

    has_many :in, :recipes, origin: :tagged_as, model_class: Graph::Recipe
  end
end
