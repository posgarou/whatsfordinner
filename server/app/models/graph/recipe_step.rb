module Graph
  class RecipeStep
    include Neo4j::ActiveNode

    property :text, type: String
    property :tip, type: String
    property :number, type: Integer
    property :optional, type: Boolean, default: false

    has_one :in, :recipe, origin: :steps, model_class: Graph::Recipe

    alias_method :optional?, :optional

    def self.name
      'RecipeStep'
    end
  end
end
