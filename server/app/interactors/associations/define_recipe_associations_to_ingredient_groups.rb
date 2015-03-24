module Associations
  # Determine the IngredientGroups a Recipe should
  # be classed as ASSOCIATED_WITH and return the
  # strength of each.
  #
  # Delete the current ASSOCIATED_WITH associations.
  #
  # Save the new associations.
  #
  # TODO Test
  class DefineRecipeAssociationsToIngredientGroups
    include Interactor
    include InteractorParameters

    MODIFIES = %i(associated_groups)

    def call
      recipe = context.recipe
      ensure_presence_of :recipe

      # Delete the old associations
      recipe.associated_groups_rels.map(&:destroy)

      # Let +p+ be each path that leads (via made_with or group) to
      # an IngredientGroup +group+.
      #
      # For each +group+, raise e to the number of paths
      # that lead to +group+. Multiply this value
      # by the sum of the natural log of the distance
      # of each +p+ that leads to +group+.
      #
      # There is no efficient way to code this with the 'straight' DSL, so it is hardcoded as follows.
      context.ingredient_group_strengths = recipe.query_as(:rec)
        .match('p=rec-[:made_with|group*1..]->(group:IngredientGroup)')
        .with('rec, collect(p) as paths, group')
        .with('rec, group, (e() ^ count(paths)) * reduce(strength=0.0, path IN paths | strength+(1.0/length(path)^2.71828)) AS strength')
        .create('(rec)-[r:ASSOCIATED_WITH { strength: strength }]->(group)')
        .return(:strength, :group)
        .to_a
    end
  end
end
