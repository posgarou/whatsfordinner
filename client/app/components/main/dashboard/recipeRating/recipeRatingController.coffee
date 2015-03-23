angular
.module('whatsForDinnerApp')
.controller('RecipeRatingCtrl', [ '$scope', '$http', ($scope, $http) ->
  # Has access to $scope.history because inside ng-repeat

  submitRating = (rating) ->
    # Send along with: recipeId and the eventDate (since this should be enough to identify the relationship)
    subPath = 'rate'
    resourcePath = "/api/recipes/#{$scope.recipe.id}/#{subPath}"
    $http.post(resourcePath, { rating: rating })

  $scope.setCurrentRating = (rating) ->
    $scope.recipe.currentRating = rating
    submitRating(rating)

  $scope.recipe.currentRating = null
])
