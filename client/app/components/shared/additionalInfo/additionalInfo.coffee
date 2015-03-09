angular.module('whatsForDinnerApp').directive 'additionalInfo', ->
  {
    restrict: 'E',
    scope: {
      name: '@',
      type: '@'
    },
    templateUrl: 'app/shared/additionalInfo/additionalInfoView.html'
  }