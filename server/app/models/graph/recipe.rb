module Graph
  class Recipe
    include Neo4j::ActiveNode
    include Grape::Entity::DSL

    property :title, index: :exact
    property :description
    property :serves, type: Integer

    # Stored in seconds for consumption by chronic_duration
    property :prep_time, type: Integer
    property :cooking_time, type: Integer

    has_many :out, :tags, type: :tagged_as, model_class: Graph::Tag

    # TODO Add has_many :out, :flavors and make the relationship in FlavorProfile polymorphic

    has_many :out, :ingredients, rel_class: Graph::MadeWith, model_class: Graph::Ingredient

    has_many :out, :steps, type: :has_step, model_class: Graph::RecipeStep

    # User/Recipe relationships
    has_many :in, :users_selecting, rel_class: Graph::RecipeInteractions::Selected, model_class: Graph::User

    # Render a list of ingredients with quantities suitable for printing
    # as a list of ingredients.
    def render_ingredients
      ingredients.each_rel.map &:render
    end

    # Returns the steps ordered by step number
    def steps_in_order
      steps.order(number: :asc)
    end

    entity :title, :description, :id
  end
end
