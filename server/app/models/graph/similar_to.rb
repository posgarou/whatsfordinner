module Graph
  class SimilarTo
    include Neo4j::ActiveRel

    # Not bi-directional because it's conceivable that since we're limiting Similars to
    # 5 per Recipe, a Similar relationship could exist in one Recipe that doesn't exist
    # in the end node.
    from_class Graph::Recipe
    to_class Graph::Recipe
    type 'SIMILAR_TO'

    property :strength, type: Float, required: true
  end
end
