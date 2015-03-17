# Presents the history between a user and a given recipe.
#
# For methods included, see UserhistoricalRecipeInteractions
class UserRecipeHistory
  include UserHistoricalRecipeInteractions
  include Grape::Entity::DSL

  attr_accessor :recipe

  delegate :id, to: :recipe, prefix: 'recipe'

  def self.interactions_for(user:, recipe:, page:nil, per_page:nil)
    new(user, recipe)
      .paginate_with(
        page: page,
        per_page: per_page
      )
      .recent_interactions
  end

  def initialize(user, recipe)
    super(user)
    @recipe = recipe
  end

  def restrict_by_recipe query
    query.where(recipe: { neo_id: recipe.neo_id })
  end

  entity :user_id, :recipe_id do
    expose :entries do |history, options|
      if options[:relation_types]
        present history.recent_interactions(relation_types)
      else
        present history.recent_interactions
      end
    end
  end
end
