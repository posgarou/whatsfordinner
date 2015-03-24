module Similarity
  # Given an array of two recipes,
  #   (1) determine the shared ingredients for each, and
  #   (2) compare these values.
  #
  # It returns both the ingredients for each as well as a percentage
  # of shared ingredients.
  #
  #
  # REQUIRES: recipes
  #
  # MODIFIES: ingredients, ingredient_similarity_factor
  #
  # Compare the number of shared ingredients to the number of total ingredients for each recipe.
  class CompareIngredients
    include Interactor
    include InteractorParameters

    MODIFIES = %i(ingredients ingredient_similarity_factor)

    def call
      recipes = context.recipes
      ensure_presence_of :recipes
      context.fail!('Two recipes must be passed in') unless recipes.is_a?(Array) && recipes.length == 2

      # Determine all IngredientGroups to whom each recipe has a relationship with strength >=
      # the 50th percentile.
      context.ingredients = recipes.map do |recipe|
        [recipe, [*recipe.ingredients]]
      end.to_h

      context.ingredient_similarity_factor = significance_factor context.ingredients.values
    end

    protected

    # Given two lists of significant groups, determine the commonality / significance factor.
    def significance_factor ingredients
      size_of_intersection = (ingredients[0] & ingredients[1]).length
      total = (ingredients[0].length + ingredients[1].length - size_of_intersection)
      size_of_intersection.to_f/total
    end
  end
end
