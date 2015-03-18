angular.module('whatsForDinnerApp').controller('InstructionsCtrl', ["$scope", '$routeParams', "Instructions" , ($scope, $routeParams, Instructions) ->
  $scope.instructions = new Instructions($routeParams.recipeId)
])
