module Graph
  module RecipeInteractions
    # Represents a rating event.
    #
    # Ratings should only be allowed one per time selected.  (Maybe require selection to be confirmed?)
    class Rated
      include Graph::RecipeInteractions::Base

      type 'rated'

      # For ease in querying, ratings should be:
      #  -1: did not like
      #   0: take it or leave it
      #  +1: liked it
      property :rating, type: Integer
    end
  end
end
