module Concierge
  module FindPossibility
    class FromLikesAndMehs
      include Interactor
      include InteractorParameters

      MODIFIES = %i(possible_suggestion)

      def call
        ensure_presence_of :user, :allowable_meal, :allowable_difficulties

        positive_ids = context.positive || []
        meh_ids = context.meh || []
        negative_ids = context.negative || []

        to_match_from = [positive_ids, positive_ids, meh_ids].flatten.sample(8).uniq

        if to_match_from.empty?
          context.possible_suggestion = nil
          return
        end

        # TODO Interact more with the strength of the similarity
        # Start out at (orig) the nodes referenced in to_match_from.
        # From there, fan out (SIMILAR_TO) to a series of new Recipes.
        # Ensure
        #   1. that the difficulty is in the list of allowable difficulties
        #   2. that the meal_times prop is either blank (= any meal) or matches our allowed meal
        #   3. and that it is not in the list of disallowed ids
        # Then, take our new recipes and a random ordering factor.
        # Order by the random ordering factor and take a single result.
        # Finally, convert the returned value into simply the recipe.
        context.possible_suggestion = begin
          Neo4j::Session
            .query
            .match('(orig:Recipe)-[:SIMILAR_TO]->(new:Recipe)')
            .where('orig.uuid IN {to_match_from}')
            .where('new.difficulty IN {allowable_difficulties}')
            .where('new.meal_times IS NULL or new.meal_times =~ {allowable_meal}')
            .where('NOT new.uuid IN {vorboten_ids}')
            .params(
              to_match_from: to_match_from,
              allowable_difficulties: context.allowable_difficulties,
              allowable_meal: context.allowable_meal,
              vorboten_ids: negative_ids
            )
            .with('new, rand() as r')
            .limit(1)
            .order_by(:r)
            .pluck(:new, :r)
            .first.try(:first)
        end
      end
    end
  end
end
