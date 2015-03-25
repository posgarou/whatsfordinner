angular
.module('whatsForDinnerApp')
.controller('LoginCtrl',
  ['$scope',
   'AuthenticationService',
   '$modal',
    '$location',
    '$routeSegment',
    'Router',
    'Themer',
   ($scope, AuthenticationService, $modal, $location, $routeSegment, Router, Themer) ->
     $scope.authenticate = (provider) ->
       AuthenticationService.authenticate(provider)

     $scope.phoneHome = Router.phoneHome

     $scope.stylingInfo = {}

     $scope.$on('auth:login-success', (ev, user) ->
       $modal.open({
         title: "Success"
         template: "<div id='alert-auth-login-success'>Welcome back " + user.email + '</div>'
       })

       $scope.phoneHome()
     )

     $scope.$on('auth:login-error', (ev, data) ->
       $modal({
         title: "Error"
         template: "<div id='alert-login-error'>Authentication failure: " +
           data.errors[0] + '</div>'
       })
     )

     Themer.setBodyClass 'login'
])
