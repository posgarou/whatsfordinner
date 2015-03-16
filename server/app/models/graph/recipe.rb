module Graph
  class Recipe
    include Neo4j::ActiveNode

    property :title, index: :exact
    property :description

    has_many :out, :tags, type: :tagged_as, model_class: Graph::Tag

    # TODO Add has_many :out, :flavors and make the relationship in FlavorProfile polymorphic

    has_many :out, :ingredients, rel_class: Graph::MadeWith, model_class: Graph::Ingredient

    has_many :out, :steps, type: :has_step, model_class: Graph::RecipeStep

    # Render a list of ingredients with quantities suitable for printing
    # as a list of ingredients.
    def render_ingredients
      ingredients.each_rel.map &:render
    end

    # Returns the steps ordered by step number
    def steps_in_order
      # The #to_a is required for now due to a strange bug where,
      # when a query is called with #order, calling
      # #first and #last on the QueryProxy obj returns the same object.
      steps.order(number: :asc).to_a
    end
  end
end
