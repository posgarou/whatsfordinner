angular.module('whatsForDinnerApp').controller('InstructionsCtrl', ["$scope", '$routeParams', "Instructions" , ($scope, $routeParams, Instructions) ->

  # Default to this while we're loading the resource
  $scope.headerInfo.h1 = 'Just a sec'

  setScopeDataFromInstructions = ->
    $scope.reTheme $scope.instructions.theme
    $scope.headerInfo.mealName = $scope.stylingInfo.theme
    $scope.setHeader($scope.instructions.title)

  $scope.instructions = new Instructions($routeParams.recipeId)

  $scope.stylingInfo.outerClass = 'recipe'

  # We most likely need to wait for the Resource promise to be resolved
  if $scope.instructions.promise.resolved
    setScopeDataFromInstructions()
  else
    # TODO Start a loading screen here
    $scope.instructions.promise.then ->
      setScopeDataFromInstructions()
])
