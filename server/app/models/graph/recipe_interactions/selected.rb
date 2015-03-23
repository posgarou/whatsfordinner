module Graph
  module RecipeInteractions
    class Selected
      include Graph::RecipeInteractions::Base
      include Grape::Entity::DSL

      type 'SELECTED'

      # Users may well select a recipe and then never make it.
      # This data doesn't hurt, but it's mostly used to answer the question,
      # "Did the user confirm he/she made it?"
      property :date_confirmed, type: Date

      # Not a boolean because true, false, and nil all
      # mean different things here (potentially)
      property :was_made, type: String

      def confirmed?
        was_made.present?
      end

      entity :event_date, :type, :confirmed? do
        expose :date_confirmed, safe: true
        expose :was_made, safe: true
        expose :recipe, using: Graph::Recipe::Entity
      end
    end
  end
end
