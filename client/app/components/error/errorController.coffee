angular
.module('whatsForDinnerApp')
.controller('ErrorCtrl', ['Router', 'Themer', '$scope', (Router, Themer, $scope) ->
  Themer.setBodyClass 'error'
  $scope.phoneHome = Router.phoneHome
])
