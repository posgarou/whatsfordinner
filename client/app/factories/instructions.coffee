angular
  .module('whatsForDinnerApp')
  .factory('Instructions', ['$resource', ($resource) ->
    $resource(
      '/api/recipes/:recipeId/instructions',
      {recipeId: '@id'}
    )
  ])
