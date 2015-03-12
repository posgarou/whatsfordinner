angular.module('whatsForDinnerApp').directive 'additionalInfo', ->
  {
    restrict: 'E',
    scope: {
      name: '@',
      type: '@'
    },
    templateUrl: 'views/templates/shared/additionalInfoView.html'
  }