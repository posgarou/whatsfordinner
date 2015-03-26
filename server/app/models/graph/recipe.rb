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

    DIFFICULTIES = %w(EASY MEDIUM HARD)

    property :difficulty, type: String

    property :similarities_updated_at, type: DateTime

    MEAL_TIMES = %w(BREAKFAST LUNCH DINNER SNACK)
    property :meal_times, default: MEAL_TIMES.to_json
    serialize :meal_times

    # population. 1 is extreme variance, 0 is unanimous agreement
    property :rating_variance

    has_many :out, :tags, type: :tagged_as, model_class: Graph::Tag

    # TODO Add has_many :out, :flavors and make the relationship in FlavorProfile polymorphic

    has_many :out, :ingredients, rel_class: Graph::MadeWith, model_class: Graph::Ingredient

    has_many :out, :associated_groups, rel_class: AssociatedWith, model_class: Graph::IngredientGroup

    has_many :out, :steps, type: :has_step, model_class: Graph::RecipeStep

    # User/Recipe relationships
    has_many :in, :users_selecting, rel_class: Graph::RecipeInteractions::Selected, model_class: Graph::User

    has_many :out, :cuisines, type: :CLASSIFIED_AS, model_class: Graph::Cuisine

    # Not bi-directional.  See Graph::SimilarTo for rationale.
    MAXIMUM_SIMILARITIES = 7
    has_many :out,
      :similar_recipes,
      rel_class: Graph::SimilarTo,
      model_class: Graph::Recipe,
      after: :update_similarities_updated_at

    validates :difficulty, inclusion: { in: DIFFICULTIES }, allow_nil: true

    before_validation do
      if self.changed?
        self.difficulty = self.difficulty.upcase if self.difficulty
      end
    end

    def self.name
      'Recipe'
    end

    def self.difficulties_at_or_below difficulty
      difficulty = difficulty.upcase

      DIFFICULTIES.slice_after(difficulty).first
    end

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
