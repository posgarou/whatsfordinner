angular
.module('whatsForDinnerApp')
.controller(
  'DifficultyCtrl',
  ['$scope',
  ($scope) ->
    class DifficultyButton
      constructor: (@name, @selected=false)->
        @className = "btn-#{name}"
        @className += 'btn-selected' if @selected

    POSSIBLE_DIFFICULTIES = [
      new DifficultyButton('easy'),
      new DifficultyButton('medium'),
      new DifficultyButton('hard'),
    ]

    $scope.buttons = POSSIBLE_DIFFICULTIES
    $scope.setHeader('How difficult?')
])
