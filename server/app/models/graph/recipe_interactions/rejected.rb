module Graph
  module RecipeInteractions
    # Represents a rejected event.
    #
    # A rejection occurs when another Recipe is chosen instead of this rel's Recipe.
    class Rejected
      include Graph::RecipeInteractions::Base
      include Grape::Entity::DSL

      type 'REJECTED'
    end
  end
end
