angular.module('whatsForDinnerApp').controller('HomeCtrl',
  ["$scope", '$location', '$routeSegment', 'Router', 'AuthenticationService'
  ($scope, $location, $routeSegment, Router, AuthenticationService) ->

    $scope.showLogin = Router.login
    $scope.showConcierge = Router.concierge

    $scope.logout = AuthenticationService.logout
])
