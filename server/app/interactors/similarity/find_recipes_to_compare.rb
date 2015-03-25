module Similarity
  # Given a +recipe+, return a list of n*2+a bit recipes against which it should be compared,
  # where n is the value of Graph::Recipe::MAXIMUM_SIMILARITIES.
  #
  # Let's say n is 5. In this case, would return up to 12 recipes. Of these:
  #   1. up to five are currently SIMILAR_TO the +recipe+
  #   2. up to five more are randomly selected other recipes SIMILAR_TO the first five (one each).
  #   3. all the remainder of hte 12 are randomly selected from recipes not in the above
  #
  # REQUIRES: recipe
  #
  # MODIFIES: possible_similarities
  class FindRecipesToCompare
    include Interactor
    include InteractorParameters

    MODIFIES = %i(possible_similarities)
    LIST_SIZE = Graph::Recipe::MAXIMUM_SIMILARITIES * 2 + 3

    attr_accessor :recipe

    def call
      ensure_presence_of :recipe
      self.recipe = context.recipe

      context.possible_similarities = [*recipe.similar_recipes]
      stretch_out_from_current
      fill_in_the_gaps

      # Tidy up the return data
      context.possible_similarities = context.possible_similarities.first || []
    end

    protected

    def stretch_out_from_current
      additional_possible = context.possible_similarities.map do |possible|
        possible
          .query_as(:recipe)
          .match('(recipe)-[:SIMILAR_TO]->(rec2:Recipe)')
          .where('rec2.uuid <> {original_uuid}')
          .params(original_uuid: recipe.id)
          .return('rec2, rand() as r')
          .order(:r)
          .first
          .map(&:rec2)
      end
      context.possible_similarities += additional_possible
      context.possible_similarities.uniq!
    end

    def fill_in_the_gaps
      # We don't want any of the current recipes returned
      current_ids = context.possible_similarities.map(&:uuid)
      # Trying to fill out the list to length (n*2+3)
      limit = LIST_SIZE - current_ids.length
      if limit.nonzero?
        # find random recipes to fill it out
        random_recipes = Neo4j::Session.query.match('(recipe:Recipe)').where('NOT recipe.uuid IN {vorboten_ids}').params(vorboten_ids: current_ids).return('recipe, rand() as r').order(:r).limit(limit).to_a.map(&:recipe)
        # and add the recipe itself to our list of possible similarities
        context.possible_similarities << random_recipes
      end
    end
  end
end
