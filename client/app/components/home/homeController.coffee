angular.module('whatsForDinnerApp').controller('HomeCtrl',
  ["$scope", '$location', '$routeSegment', '$auth', 'Router',
  ($scope, $location, $routeSegment, $auth, Router) ->

    $scope.showLogin = Router.login
    $scope.showConcierge = Router.concierge
])
