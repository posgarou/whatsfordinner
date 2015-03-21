module Graph
  class Cuisine
    include Neo4j::ActiveNode
    include Grape::Entity::DSL

    property :name, index: :exact

    has_many :in, :recipes, model_class: Graph::Recipe

    entity :id, :name
  end
end
