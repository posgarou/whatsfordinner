angular.module('whatsForDinnerApp').directive 'additionalInfo', ['PATHS', (PATHS)->
  {
    restrict: 'E',
    scope: {
      name: '@',
      type: '@'
    },
    templateUrl: "#{PATHS.SHARED_VIEWS}/additionalInfo/additionalInfo.html"
  }
]