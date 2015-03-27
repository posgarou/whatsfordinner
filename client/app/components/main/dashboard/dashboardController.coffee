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

      $scope.histories = new UserHistoryResource($scope.currentUser()).resource
      $scope.needsRating = new UserNeedsRatingResource($scope.currentUser()).resource

      $scope.setHeader 'Dashboard'
      $scope.headerInfo.mealName = ''
      $scope.stylingInfo.outerClass = 'dashboard-container'
      $scope.reTheme 'dashboard'

  ])
