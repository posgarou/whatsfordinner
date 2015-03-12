angular.module('whatsForDinnerApp').directive 'additionalInfo', ['PATHS', (PATHS)->
  {
    restrict: 'E',
    scope: {
      name: '@',
      type: '@'
    },
    templateUrl: "#{PATHS.SHARED_PARTIALS}/additionalInfoView.html"
  }
]