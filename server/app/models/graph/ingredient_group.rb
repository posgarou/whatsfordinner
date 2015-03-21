module Graph
  class IngredientGroup
    include Neo4j::ActiveNode

    property :name

    has_many :in, :ingredients, origin: :groups, model_class: Graph::Ingredient

    # Define reciprocal relationships.  E.g. beef.groups would include meat, and meat.subgroups would include beef
    has_many :out, :groups, type: :group, model_class: Graph::IngredientGroup
    has_many :in, :subgroups, type: :group, model_class: Graph::IngredientGroup

    def self.name
      'IngredientGroup'
    end
  end
end
