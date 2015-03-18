angular
  .module('whatsForDinnerApp')
  .service('ConciergeService', ['$http', 'RecipeSummary', ($http, RecipeSummary) ->
    class ConciergeService
      constructor: (@userId)->
        @suggestions = []
      load: ->
        $http.get(
          "/api/users/#{@userId}/recipes/concierge",
          {recipeId: '@id'}
        ).success( (data) =>
          # clear the array
          @suggestions.length = 0
          console.log data
          new_suggestions = (new RecipeSummary(datum) for datum in data)
          # Make Angular referential data-binding happy
          Array::push.apply(@suggestions, new_suggestions)
        )
  ])
