module Concierge
  module FindPossibility
    class FromRandom
      include Interactor
      include InteractorParameters

      MODIFIES = %i(possible_suggestion)

      def call
        ensure_presence_of :user, :allowable_meal, :allowable_difficulties

        negative_ids = context.negative || []

        # Get a selection of random nodes.
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
            .match('(new:Recipe)')
            .where('new.difficulty IN {allowable_difficulties}')
            .where('new.meal_times IS NULL or new.meal_times =~ {allowable_meal}')
            .where('NOT new.uuid IN {vorboten_ids}')
            .params(
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
