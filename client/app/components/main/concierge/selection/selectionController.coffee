angular
.module('whatsForDinnerApp')
.controller(
  'SelectionCtrl',
  ['$scope',
   '$routeSegment',
   '$location',
   'SelectionService',
    ($scope, $routeSegment, $location, SelectionService) ->

      # TODO Add ability to replace selection. This should send data to the server.

      $scope.selector = new SelectionService ($scope.currentUser().id or $scope.currentUser().uuid), $scope.conciergeData.mealTime, $scope.conciergeData.difficulty

      $scope.selector.load()
      $scope.recipes = $scope.selector.suggestions
      $scope.conciergeData.recipes = $scope.recipes


      $scope.setHeader('Cool. Time to choose.')
])
