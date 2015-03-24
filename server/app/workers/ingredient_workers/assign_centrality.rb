module IngredientWorkers
  # Calls MetaAnalysis::AssignIngredientCentrality
  class AssignCentrality
    include Sidekiq::Worker

    def perform ingredient_id
      ingredient = Graph::Recipe.find_by(uuid: ingredient_id)

      MetaAnalysis::AssignIngredientCentrality.call(
        ingredient: ingredient
      )
    end
  end
end
