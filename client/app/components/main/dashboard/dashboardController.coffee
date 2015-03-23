angular
  .module('whatsForDinnerApp')
  # Parent controller for any page of the site that uses the center content box
  # Controls/displays theme.
  .controller('DashboardCtrl',
    ['$scope',
     'AuthenticationService',
     'Router',
     '$q',
     'UserHistoryResource',
     'UserNeedsRatingResource'
    ($scope, AuthenticationService, Router, $q, UserHistoryResource, UserNeedsRatingResource) ->
      $scope.phoneHome = Router.phoneHome
      $scope.showDashboard = Router.dashboard
      $scope.showConcierge = Router.concierge
      $scope.showLogin = Router.login
      $scope.logout = AuthenticationService.logout

      $scope.histories = new UserHistoryResource(AuthenticationService.validateUser()).resource
      $scope.needsRating = new UserNeedsRatingResource(AuthenticationService.validateUser()).resource

      $scope.setHeader 'Dashboard'
      $scope.stylingInfo.outerClass = 'dashboard-container'
      $scope.reTheme 'dashboard'

  ])
