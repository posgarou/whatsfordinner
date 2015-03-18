angular
  .module('whatsForDinnerApp')
  .factory('InstructionsResource', ['$resource', ($resource) ->
    $resource(
      '/api/recipes/:recipeId/instructions',
      {recipeId: '@id'}
    )
  ])
