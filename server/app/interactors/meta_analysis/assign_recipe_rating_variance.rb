module MetaAnalysis
  class AssignRecipeRatingVariance
    include Interactor
    include InteractorParameters

    MODIFIES = %i(rating_variance)

    def call
      ensure_presence_of :recipe

      # Note: I really regret not having encoded all of my queries like this. I only just
      # learned you could use heredoc references in parameter lists, which makes it really
      # easy to read

      context.rating_variance = Neo4j::Session.query(<<-CYPHER, recipe_id: context.recipe.uuid).first.try(:rating_variance)
        // Find every case where a User has Rated this Recipe
        MATCH (:User)-[r:RATED]->(rec:Recipe { uuid: {recipe_id} })

        // Calculate the rating_variance of population r as = stdev**2
        WITH rec, stdevp(r.rating)^2 AS rating_variance

        // Set and return the rating_variance
        SET rec.rating_variance=rating_variance
        RETURN rating_variance
      CYPHER
    end
  end
end
