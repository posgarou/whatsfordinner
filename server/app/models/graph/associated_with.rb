module Graph
  # Represents a Recipe's association to (and strength of the association to)
  # an IngredientGroup.
  #
  # Strength of 0 is weak, and it has no upper bound (but anything over 0.5 is
  # rather strong).
  #
  # For computation of Strength, see Associations::RecipeToIngredientGroups.
  #
  # Note that it is _theoretically_ possible that rounding could produce a
  # strength of 0, but in certain circumstances (e.g. vegetarians or allergies)
  # a strength of 0 could still be significant as showing an existent relationship.
  class AssociatedWith
    include Neo4j::ActiveRel

    from_class Graph::Recipe
    to_class Graph::IngredientGroup
    type 'ASSOCIATED_WITH'

    property :strength, type: Float
  end
end
