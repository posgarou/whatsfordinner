angular.module('whatsForDinnerApp').controller('HomeCtrl',
  ["$scope", '$location', '$routeSegment', 'Router', 'AuthenticationService'
  ($scope, $location, $routeSegment, Router, AuthenticationService) ->

    $scope.phoneHome = Router.phoneHome
    $scope.showDashboard = Router.dashboard
    $scope.showLogin = Router.login
    $scope.showConcierge = Router.concierge
    $scope.logout = AuthenticationService.logout
])
