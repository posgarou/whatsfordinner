angular
  .module('whatsForDinnerApp')
  .factory('RecipeSummary', ->
    class RecipeSummary
      constructor: (data) ->
        @recipeId = data['id']
        @title = data['title']
        @description = data['description']
  )
