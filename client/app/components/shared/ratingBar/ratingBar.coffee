angular.module('whatsForDinnerApp').directive 'ratingBar', ->
  {
    restrict: 'E',
    scope: {
      currentRating: '='
    },
    templateUrl: 'views/shared/ratingBarView.html'
  }