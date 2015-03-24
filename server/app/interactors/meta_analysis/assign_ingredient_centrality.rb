module MetaAnalysis
  # Given an ingredient, it determines and assigns its centrality.
  #
  # REQUIRES: ingredient
  #
  # MODIFIES: centrality
  class AssignIngredientCentrality
    include Interactor
    include InteractorParameters

    MODIFIES = %i(ingredient_centrality)
    def call
      ensure_presence_of :ingredient
      ingredient = context.ingredient

      context.centrality = ingredient
        .query_as(:ing)
        .match('ing<--(node)')
        .with('ing, count(node) AS centrality')
        .set('ing.centrality = centrality')
        .return('ing AS ingredient, centrality')
        .to_a.first[:centrality]
    end
  end
end
