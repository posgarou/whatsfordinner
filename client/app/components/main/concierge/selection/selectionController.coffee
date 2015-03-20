angular
.module('whatsForDinnerApp')
.controller(
  'SelectionCtrl',
  ['$scope',
   '$routeSegment',
   '$location',
   'SelectionService',
   'TEST_DATA',
    ($scope, $routeSegment, $location, SelectionService, TEST_DATA) ->

      # TODO Add ability to replace selection. This should send data to the server.

      $scope.selector = new SelectionService TEST_DATA.USER_ID
      $scope.selector.load()
      $scope.recipes = $scope.selector.suggestions


      $scope.setHeader('Cool. Time to choose.')
])