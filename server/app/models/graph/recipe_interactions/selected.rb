module Graph
  module RecipeInteractions
    class Selected
      include Graph::RecipeInteractions::Base

      type 'selected'

      # Users may well select a recipe and then never make it.
      # This data doesn't hurt, but it's mostly used to answer the question,
      # "Did the user confirm he/she made it?"
      property :date_confirmed, type: Date

      def confirmed?
        date_confirmed.present?
      end
    end
  end
end
