angular
.module('whatsForDinnerApp')
# Parent controller for any page of the site that uses the center content box
# Controls/displays theme.
.controller('MainCtrl', ['$scope', 'AuthenticationService', 'ipCookie', ($scope, AuthenticationService, ipCookie) ->
#    $scope.theme = 'dinner'
    $scope.headerInfo = {h1: 'Ready?'}
    $scope.stylingInfo = {
      theme: 'dinner',
      outerClass: ''
    }

    # For now this only resets the var, but it's here if we later decide to somehow animate the transition
    # from one theme to another.  (Or should this be done via CSS?  That's a lot of transitions.)
    $scope.reTheme = (newTheme)->
      if $scope.stylingInfo.theme != newTheme
        $scope.stylingInfo.theme = newTheme

    $scope.setHeader = (newHeaderText)->
      $scope.headerInfo.h1 = newHeaderText
])