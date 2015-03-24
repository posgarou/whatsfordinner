module Similarity
  # Given an array of two recipes,
  #   (1) determine the shared tags for each, and
  #   (2) compare these values.
  #
  # It returns both the tags for each as well as a percentage
  # of shared tags.
  #
  #
  # REQUIRES: recipes
  #
  # MODIFIES: tags, tag_similarity_factor
  #
  # Compare the number of shared tags to the number of total tags for each recipe.
  class CompareTags
    include Interactor
    include InteractorParameters

    MODIFIES = %i(tags tag_similarity_factor)

    def call
      recipes = context.recipes
      ensure_presence_of :recipes
      context.fail!('Two recipes must be passed in') unless recipes.is_a?(Array) && recipes.length == 2

      # Determine all IngredientGroups to whom each recipe has a relationship with strength >=
      # the 50th percentile.
      context.tags = recipes.map do |recipe|
        [recipe, [*recipe.tags]]
      end.to_h

      context.tag_similarity_factor = significance_factor context.tags.values
    end

    protected

    # Given two lists of significant groups, determine the commonality / significance factor.
    def significance_factor tags
      size_of_intersection = (tags[0] & tags[1]).length
      total = (tags[0].length + tags[1].length - size_of_intersection)
      size_of_intersection.to_f/total
    end
  end
end
