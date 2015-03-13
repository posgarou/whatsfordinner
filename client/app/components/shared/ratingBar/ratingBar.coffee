angular.module('whatsForDinnerApp').directive 'ratingBar', ["PATHS", (PATHS)->
  {
    restrict: 'E',
    scope: {
      currentRating: '='
    },
    templateUrl: "#{PATHS.SHARED_VIEWS}/ratingBar/ratingBar.html"
  }
]