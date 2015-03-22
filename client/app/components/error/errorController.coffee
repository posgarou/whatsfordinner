angular
.module('whatsForDinnerApp')
.controller('ErrorCtrl', ['Router', 'Themer', (Router, Themer) ->
  Themer.setBodyClass 'error'
  $scope.phoneHome = Router.phoneHome
])
