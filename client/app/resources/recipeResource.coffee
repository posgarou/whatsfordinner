angular
  .module('whatsForDinnerApp')
  .factory('RecipeResource', ['$resource', ($resource) ->
    $resource(
      '/api/recipes/:recipeId',
      {recipeId: '@id'}
    )
  ])
