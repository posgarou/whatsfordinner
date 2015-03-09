angular.module('whatsForDinnerApp').directive 'ratingBar', ->
  {
    restrict: 'E',
    scope: {
      currentRating: '='
    },
    templateUrl: 'app/shared/ratingBar/ratingBarView.html'
  }