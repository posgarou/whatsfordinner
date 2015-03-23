angular
.module('whatsForDinnerApp')
.controller('SelectionHistoryCtrl', [ '$scope', '$http', ($scope, $http) ->
    # Has access to $scope.history because inside ng-repeat

    $scope.selectionPanel = if $scope.history.confirmed then 'beenConfirmed' else 'notBeenConfirmed'

    submitConfirmation = (affirming) ->
      # Send along with: recipeId and the eventDate (since this should be enough to identify the relationship)
      subPath = if affirming then 'confirmSelection' else 'refuteSelection'
      resourcePath = "/api/recipes/#{$scope.history.recipe.id}/#{subPath}"
      $http.put(resourcePath, { event_date: $scope.epochEventTime() })

    $scope.confirmYes = ->
      $scope.selectionPanel = 'justConfirmed'
      submitConfirmation(true)

    $scope.confirmNo = ->
      $scope.selectionPanel = 'justConfirmed'
      submitConfirmation(false)

    $scope.epochEventTime = ->
      (new Date($scope.history.eventDate))
      .getTime() / 1000
])
