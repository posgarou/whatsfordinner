module RecipeWorkers
  # Calls DefineRecipeAssociationsToIngredientGroups
  class SetupAssociation
    include Sidekiq::Worker

    def perform recipe_id
      recipe = Graph::Recipe.find_by(uuid: recipe_id)

      Associations::DefineRecipeAssociationsToIngredientGroups.call(
        recipe: recipe
      )
    end
  end
end
