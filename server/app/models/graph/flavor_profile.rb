module Graph
  class FlavorProfile
    include Neo4j::ActiveNode

    property :name, index: :exact

    def self.name
      'Flavor'
    end

    has_many :in, :ingredients, origin: :flavors, model_class: Graph::Ingredient
  end
end
