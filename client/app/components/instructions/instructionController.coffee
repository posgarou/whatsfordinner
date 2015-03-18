angular.module('whatsForDinnerApp').controller('InstructionsCtrl', ["$scope", "Instructions" , ($scope, Instructions) ->
  console.log Instructions
  $scope.instructions = Instructions.get('d971cf7c-80a6-4263-ab5a-49edc358f4ab')
#  $scope.instructions = Instructions.get('d971cf7c-80a6-4263-ab5a-49edc358f4ab')
])
