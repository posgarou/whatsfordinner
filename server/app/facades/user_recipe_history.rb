# Presents the history between a user and a given recipe.
#
# For methods included, see UserhistoricalRecipeInteractions
class UserRecipeHistory
  include UserHistoricalRecipeInteractions

  attr_accessor :recipe

  delegate :id, to: :recipe, prefix: 'recipe'

  def initialize(user, recipe)
    super(user)
    @recipe = recipe
  end

  def restrict_by_recipe query
    query.where(recipe: { neo_id: recipe.neo_id })
  end
  #
  # entity :recipe_id, :user_id do
  #
  # end
end
