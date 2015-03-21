angular
  .module('whatsForDinnerApp')
  # Parent controller for any page of the site that uses the center content box
  # Controls/displays theme.
  .controller('NotFoundCtrl',
    ['$scope',
     'AuthenticationService',
     'Router',
    ($scope,AuthenticationService, Router) ->
      $scope.phoneHome = Router.phoneHome
      $scope.showDashboard = Router.dashboard
      $scope.showConcierge = Router.concierge
      $scope.showLogin = Router.login
      $scope.logout = AuthenticationService.logout
  ])
