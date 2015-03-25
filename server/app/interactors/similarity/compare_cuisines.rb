module Similarity
  # Given an array of two recipes,
  #   (1) determine the shared cuisines for each, and
  #   (2) compare these values.
  #
  # It returns both the cuisines for each as well as a percentage
  # of shared cuisines.
  #
  #
  # REQUIRES: recipes
  #
  # MODIFIES: cuisines, cuisine_similarity_factor
  #
  # Compare the number of shared cuisines to the number of total cuisines for each recipe.
  class CompareCuisines
    include Interactor
    include InteractorParameters

    MODIFIES = %i(cuisines cuisine_similarity_factor)

    def call
      recipes = context.recipes
      ensure_presence_of :recipes
      context.fail!('Two recipes must be passed in') unless recipes.is_a?(Array) && recipes.length == 2

      # Determine all IngredientGroups to whom each recipe has a relationship with strength >=
      # the 50th percentile.
      context.cuisines = recipes.map do |recipe|
        [recipe, [*recipe.cuisines]]
      end.to_h

      context.cuisine_similarity_factor = significance_factor context.cuisines.values
    end

    protected

    # Given two lists of significant groups, determine the commonality / significance factor.
    def significance_factor cuisines
      size_of_intersection = (cuisines[0] & cuisines[1]).length
      total = (cuisines[0].length + cuisines[1].length - size_of_intersection)
      (size_of_intersection.to_f/total) / 2
    end
  end
end
