angular.module('whatsForDinnerApp').controller('InstructionCtrl', ["$scope", "Instructions" , ($scope, Instructions) ->
  $scope.instructions = new Instructions
])