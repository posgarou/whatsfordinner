angular
  .module('whatsForDinnerApp')
  .factory('RecipeResource', ['$resource', ($resource) ->
    resource_base_path = '/api/recipes/:recipeId'
    $resource(
      resource_base_path,
      {recipeId: '@id'},
      {
        select: {
          method: 'PUT',
          url: resource_base_path + '/select'
        }
      }
    )
  ])
