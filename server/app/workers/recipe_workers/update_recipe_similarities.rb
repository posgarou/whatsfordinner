module RecipeWorkers
  # Calls UpdateRecipeSimilarities for a Recipe
  class UpdateRecipeSimilarities
    include Sidekiq::Worker

    sidekiq_options :queue => :default

    def perform recipe_id
      recipe = Graph::Recipe.find_by(uuid: recipe_id)

      Similarity::UpdateRecipeSimilarities.(recipe: recipe)
    end
  end
end
