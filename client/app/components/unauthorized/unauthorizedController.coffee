angular
.module('whatsForDinnerApp')
.controller('UnauthorizedCtrl', ['$scope', 'Router', 'Themer', ($scope, Router, Themer) ->
  $scope.showLogin = Router.login
  $scope.phoneHome = Router.phoneHome

  $scope.stylingInfo = {

  }

  Themer.setBodyClass 'unauthorized'
])
