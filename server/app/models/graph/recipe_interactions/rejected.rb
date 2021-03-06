module Graph
  module RecipeInteractions
    # Represents a rejected event.
    #
    # A rejection occurs when another Recipe is chosen instead of this rel's Recipe.
    class Rejected
      include Graph::RecipeInteractions::Base
      include Grape::Entity::DSL

      type 'REJECTED'

      entity :event_date, :type do
        expose :recipe, using: Graph::Recipe::Entity
      end
    end
  end
end
