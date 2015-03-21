# Record a Rejected event between a User and a Recipe
#
# USES: user, rejectionIds
#
# MODIFIES: rejectedRecipes
#
# ROLLBACK: Delete the Rejected events
class RecordRecipeRejections
  include Interactor

  def call
    begin
      graph_user = context.user.graph_user
      context.rejectedRecipes = context.rejectionIds.map do |recipeId|
        recipe = Graph::Recipe.find(recipeId)
        Graph::RecipeInteractions::Rejected.create(
          from_node: graph_user,
          to_node: recipe
        )
      end
    rescue Exception => e
        context.fail!(error: e.message)
    end
  end

  def rollback
    context.rejectedRecipes.map(&:destroy)
  end
end
