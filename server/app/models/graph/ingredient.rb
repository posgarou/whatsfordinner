module Graph
  class Ingredient
    include Neo4j::ActiveNode
    include Grape::Entity::DSL

    property :name, index: :exact
    property :centrality, type: Integer

    has_many :in, :recipes, rel_class: Graph::MadeWith, model_class: Graph::Recipe

    has_many :out, :groups, type: :group, model_class: Graph::IngredientGroup

    has_many :out, :flavors, type: :tastes, model_class: Graph::FlavorProfile

    def self.name
      'Ingredient'
    end

    entity :id, :name
  end
end
