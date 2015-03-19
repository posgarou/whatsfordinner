angular
.module('whatsForDinnerApp')
.controller(
  'MealTimeCtrl',
  ['$scope',
   'MealTimeGuesserService',
  ($scope, MealTimeGuesserService) ->

    class MealButton
      constructor: (@name, @buttonTextGuessed, @buttonTextDoubtful)->
        @className = "btn-#{name}"

    POSSIBLE_MEALS = {
      breakfast: new MealButton('breakfast', 'Breakfast, right?', 'Look to Breakfast'),
      lunch: new MealButton('lunch', 'Lunch, right?', 'Think about Lunch'),
      dinner: new MealButton('dinner', 'Dinner, right?', 'Plan Dinner'),
      snack: new MealButton('snack', 'Want to fill up the corners?', 'Grab a Snack')
    }

    makeAGuess = ->
      $scope.guess = POSSIBLE_MEALS[$scope.guessMealTime()]
      $scope.doubtful = _.without(POSSIBLE_MEALS, $scope.guess)

    # INITIALIZE
    makeAGuess()
    $scope.reTheme $scope.guess.name
    $scope.setHeader('Which meal?')
])
