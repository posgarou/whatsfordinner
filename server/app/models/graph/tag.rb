module Graph
  class Tag
    include Neo4j::ActiveNode
    include Grape::Entity::DSL

    property :name, index: :exact

    has_many :in, :recipes, origin: :tags, model_class: Graph::Recipe

    def self.name
      'Tag'
    end

    entity :id, :name
  end
end
