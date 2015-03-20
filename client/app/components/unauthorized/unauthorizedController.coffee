angular
.module('whatsForDinnerApp')
.controller('UnauthorizedCtrl', ['$scope', 'Router', ($scope, Router) ->
  $scope.showLogin = Router.login
  $scope.phoneHome = Router.phoneHome
])
