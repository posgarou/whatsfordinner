module Graph
  module RecipeInteractions
    # Superclass for User/Recipe interactions.
    #
    # TODO: Hid (User asked never to be shown again) and Starred (User marked the recipe for easier access later)
    #
    # It may be better/easier in the future to turn these into ActiveNodes.
    #
    # My thinking is that what we are dealing with (as the module name
    # implies) is the history of a User's interaction
    # (read relationship) to a given recipe.
    #
    # This allows us to easily write queries like 'find all the recipes that a user has starred' or 'exclude all the recipes the user has hidden'
    #
    # An example Cypher query (adapted from several stack overflow answers):
    #
    # "Find any recipe related to a user in any way, so long as the user hasn't hidden it within the past year"
    #
    # MATCH (user:User)-[rel*]->(recipe:Recipe)
    # WHERE NOT ((user)-[hid:hidden]->(recipe) AND hid.date > (timestamp() - (1000*60*60*24*365)))
    # RETURN user,recipe
    module Base
      extend ActiveSupport::Concern
      include Neo4j::ActiveRel

      def set_default_event_date
        self.event_date ||= Time.now
      end

      included do
        from_class Graph::User
        to_class Graph::Recipe
        # type must be specified in subclass

        property :event_date, type: DateTime

        before_save :set_default_event_date

        alias_method :user, :from_node
        alias_method :recipe, :to_node
      end
    end
  end
end
