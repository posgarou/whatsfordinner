angular
  .module('whatsForDinnerApp')
  .service('SelectionService', ['$http', 'RecipeSummary', ($http, RecipeSummary) ->
    class SelectionService
      constructor: (@userId, @mealTime, @difficulty)->
        @suggestions = []
      load: ->
        $http.get(
          "/api/users/#{@userId}/recipes/concierge",
          {
            params: {
              meal_time: @mealTime
              difficulty: @difficulty
            }
          }
        ).success( (data) =>
          # clear the array
          @suggestions.length = 0
          new_suggestions = (new RecipeSummary(datum) for datum in data)
          # Make Angular referential data-binding happy
          Array::push.apply(@suggestions, new_suggestions)
        )
  ])
