angular
  .module('whatsForDinnerApp')
  # Parent controller for any page of the site that uses the center content box
  # Controls/displays theme.
  .controller('DashboardCtrl',
    ['$scope',
     'AuthenticationService',
     'Router',
      '$auth',
      'UserHistoryResource',
    ($scope, AuthenticationService, Router, $auth, UserHistoryResource) ->
      $scope.phoneHome = Router.phoneHome
      $scope.showDashboard = Router.dashboard
      $scope.showConcierge = Router.concierge
      $scope.showLogin = Router.login
      $scope.logout = AuthenticationService.logout

      $scope.test = new UserHistoryResource(AuthenticationService.validateUser()).resource
  ])
