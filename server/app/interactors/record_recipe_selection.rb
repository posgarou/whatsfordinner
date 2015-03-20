# Generates a Selected event between a user and a recipe
#
# USES: user, selectionId
#
# MODIFIES: selection
#
# ROLLBACK: Delete the Selected event.
class RecordRecipeSelection
  include Interactor

  def call
    graph_user = context.user.graph_user
    recipe = Graph::Recipe.find(context.selectionId)
    context.selection = Graph::RecipeInteractions::Selected.create(
      from_node: graph_user,
      to_node: recipe
    )
  end

  def rollback
    context.selection.destroy
  end
end
