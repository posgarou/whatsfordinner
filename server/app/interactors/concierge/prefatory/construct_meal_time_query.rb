module Concierge
  module Prefatory
    class ConstructMealTimeQuery
      include Interactor
      include InteractorParameters

      MODIFIES = %i(allowable_meal)

      def call
        meal_time = context.meal_time.upcase
        meal_time = nil unless Graph::Recipe::MEAL_TIMES.include?(meal_time)

        if meal_time.present?
          context.allowable_meal = ".*#{meal_time}.*"
        else
          context.allowable_meal = '.*'
        end
      end
    end
  end
end
