angular
.module('whatsForDinnerApp')
.controller('LoginCtrl',
  ['$scope',
   'AuthenticationService',
   ($scope, AuthenticationService) ->
     $scope.logInForm = {}
])
