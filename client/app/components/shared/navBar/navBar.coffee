angular
.module('whatsForDinnerApp')
.directive('navBar', ['PATHS', (PATHS) ->
  {
    restrict: 'E',
    templateUrl: "#{PATHS.SHARED_VIEWS}/navBar/navBar.html"
  }
])
