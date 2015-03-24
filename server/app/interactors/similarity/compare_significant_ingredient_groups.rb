module Similarity
  # Given an array of two recipes,
  #   (1) determine the significant ingredient groups for each, and
  #   (2) compare these values.
  #
  # It returns both the significant groups for each as well as a percentage
  # of common significant IngredientGroups.
  #
  # A significant IngredientGroup is any group to whom the strength of the
  # ASSOCIATED_WITH relationship is in the 50th percentile or above for the
  # entire graph.
  #
  # REQUIRES: recipes
  #
  # MODIFIES: significant_groups, group_similarity_factor
  #
  class CompareSignificantIngredientGroups
    include Interactor
    include InteractorParameters

    MODIFIES = %i(significant_groups group_similarity_factor)

    def call
      recipes = context.recipes
      ensure_presence_of :recipes
      context.fail!('Two recipes must be passed in') unless recipes.is_a?(Array) && recipes.length == 2

      # Determine all IngredientGroups to whom each recipe has a relationship with strength >=
      # the 50th percentile.
      context.significant_groups = recipes.map do |recipe|
        [recipe,
        Neo4j::Session.query(
          "MATCH (n:Recipe)-[r:ASSOCIATED_WITH]->(group:IngredientGroup) WITH percentileDisc(r.strength, 0.5) AS mid MATCH (n:Recipe { uuid: {uuid} })-[r1:ASSOCIATED_WITH]->(group:IngredientGroup) WHERE r1.strength >= mid RETURN group.name AS group_name",
          uuid: recipe.id
        )
        .to_a.map(&:group_name)]
      end.to_h

      context.group_similarity_factor = significance_factor context.significant_groups.values
    end

    protected

    # Given two lists of significant groups, determine the commonality / significance factor.
    def significance_factor significant_groups
      size_of_intersection = (significant_groups[0] & significant_groups[1]).length
      total = (significant_groups[0].length + significant_groups[1].length - size_of_intersection)
      size_of_intersection.to_f/total
    end
  end
end
