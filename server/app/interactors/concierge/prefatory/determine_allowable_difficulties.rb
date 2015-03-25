module Concierge
  # Return (suitable for injection in a params hash) a list of allowable difficulties, i.e.
  # at or below the target difficulty.
  #
  # Return all difficulties if no context.difficulty is specified.
  module Prefatory
    class DetermineAllowableDifficulties
      include Interactor
      include InteractorParameters

      MODIFIES = %i(allowable_difficulties)

      def call
        difficulty = context.difficulty.try(:upcase)
        possibilities = Graph::Recipe.difficulties_at_or_below difficulty

        possibilities = Graph::Recipe::DIFFICULTIES if possibilities.empty?

        context.allowable_difficulties = possibilities
      end
    end
  end
end
