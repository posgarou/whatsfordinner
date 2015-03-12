angular.module('whatsForDinnerApp').directive 'ratingBar', ->
  {
    restrict: 'E',
    scope: {
      currentRating: '='
    },
    templateUrl: 'views/templates/shared/ratingBarView.html'
  }