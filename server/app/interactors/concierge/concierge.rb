module Concierge
  class Concierge
  include Interactor
  include InteractorParameters

    def call
      ensure_presence_of :user
      user, meal_time, difficulty = [:user, :meal_time, :difficulty].map { |v| context.public_send(v) }

      res = Prefatory::GatherLikesAndDislikes.(user: user)
      error!(error: res.error) unless res.success?

      allowable_meal = Prefatory::ConstructMealTimeQuery.(meal_time: meal_time).allowable_meal
      allowable_difficulties = Prefatory::DetermineAllowableDifficulties.(difficulty: difficulty).allowable_difficulties

      initial_possibilities = (2.times.map do
        FindPossibility::FromLikesAndMehs.call(
          user: user,
          positive: res.positive,
          meh: res.meh,
          negative: res.negative,
          allowable_meal: allowable_meal,
          allowable_difficulties: allowable_difficulties
        ).possible_suggestion
      end).compact

      to_return = initial_possibilities

      # TODO Attempt to find possibilities based off selected but not rated

      until to_return.length == 3
        new_result = FindPossibility::FromRandom.call(
          user: user,
          negative: res.negative,
          allowable_meal: allowable_meal,
          allowable_difficulties: allowable_difficulties
        ).possible_suggestion
        to_return.push new_result
        to_return = to_return.compact.uniq
      end

      context.suggestions = to_return
    end
  end
end
