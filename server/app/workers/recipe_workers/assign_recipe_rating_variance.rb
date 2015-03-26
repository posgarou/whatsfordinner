module RecipeWorkers
  # Calls MetaAnalysis::AssignRecipeRatingVariance for a Recipe
  class AssignRecipeRatingVariance
    include Sidekiq::Worker

    sidekiq_options :queue => :default

    def perform recipe_id
      recipe = Graph::Recipe.find_by(uuid: recipe_id)

      MetaAnalysis::AssignRecipeRatingVariance.(recipe: recipe)
    end
  end
end
