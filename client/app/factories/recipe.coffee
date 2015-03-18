angular
  .module('whatsForDinnerApp')
  .factory('Recipe', ['$resource', ($resource) ->
    $resource(
      '/api/recipes/:recipeId',
      {recipeId: '@id'}
    )
  ])
