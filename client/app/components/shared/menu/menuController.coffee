angular
.module('whatsForDinnerApp')
.controller('MenuCtrl', ['Router', 'AuthenticationService', '$scope', (Router, AuthenticationService, $scope) ->
  $scope.phoneHome = Router.phoneHome
  $scope.showDashboard = Router.dashboard
  $scope.showConcierge = Router.concierge
  $scope.showLogin = Router.login
  $scope.logout = AuthenticationService.logout
])
