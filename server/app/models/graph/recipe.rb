module Graph
  class Recipe
    include Neo4j::ActiveNode
    include Grape::Entity::DSL

    property :title, index: :exact
    property :description

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

    # Due to an odd interaction between neo4j and Grape::Entity, without this
    # the entity errors out, since it tries to access properties
    # on the query object rather than on the Graph::Tag obj
    def tags_for_rendering
      tags.to_a
    end

    # Returns the steps ordered by step number
    def steps_in_order
      # The #to_a is required for now due to a strange bug where,
      # when a query is called with #order, calling
      # #first and #last on the QueryProxy obj returns the same object.
      steps.order(number: :asc).to_a
    end

    entity :title, :description do
      # Specifies that these attributes should only be
      # displayed if the instance is not in a collection
      # or if options[:type] is explicitly set to :full
      alone_or_solo = -> (_instance, options) do
        !options[:collection] || options[:type] == :full
      end

      expose :tags_for_rendering, if: alone_or_solo, using: Graph::Tag::Entity, as: :tags
      expose :ingredients_rels, as: :ingredients, using: Graph::MadeWith::Entity
      expose :steps_in_order, if: alone_or_solo, as: :steps
    end
  end
end
