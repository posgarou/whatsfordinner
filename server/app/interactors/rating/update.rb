# Update a user's rating for a recipe.
#
# USES: user, recipe, rating
#
# MODIFIES: nothing
#
# SIDE EFFECT: deletes old rating, if there was one
#
class Rating::Update
  include Interactor

  MODIFIES = %i()

  def call
    user = context.user
    recipe = context.recipe
    rating = context.rating

    ensure_present user, recipe, rating
    ensure_valid rating

    # Delete the current rating, if there is one
    user.rated_recipes.first_rel_to(recipe).try(:destroy)

    Graph::RecipeInteractions::Rated.create(from_node: user, to_node: recipe, rating: rating)
  end

  private

  def ensure_present user, recipe, rating
    context.fail!(error: 'User is required') unless user
    context.fail!(error: 'Recipe is required') unless recipe
    context.fail!(error: 'Rating is required') unless rating
  end

  def ensure_valid rating
    context.fail!(error: 'Rating must be 0, 1, or -1') unless (-1..1).include?(rating)
  end
end
