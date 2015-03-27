angular
  .module('whatsForDinnerApp')
  # Parent controller for any page of the site that uses the center content box
  # Controls/displays theme.
  .controller('NotFoundCtrl',
    ['$scope',
     'AuthenticationService',
     'Router',
     'Themer',
    ($scope,AuthenticationService, Router, Themer) ->
      $scope.phoneHome = Router.phoneHome

      $scope.stylingInfo = {}

      Themer.setBodyClass 'not-found'
  ])
