angular
.module('whatsForDinnerApp')
.controller('ConciergeCtrl',
  ['$scope',
   '$routeParams',
   '$routeSegment',
    '$location',
    'MealTimeGuesserService',
    'RecipeResource',
   ($scope, $routeParams, $routeSegment, $location, MealTimeGuesserService, RecipeResource) ->

     # TODO set it to pull in $routeParams on refresh

     # Sets up (or resets) the concierge data
     setup = ->
       $scope.setHeader('Let\'s pick some food.')
       $scope.conciergeData = {
         mealTime: '',
         difficulty: '',
         recipes: []
       }


     $scope.showMealTimePicker = ->
       $location.path(
         $routeSegment.getSegmentUrl('main.concierge.mealTime')
       )

     $scope.showDifficultyPicker = ->
       $location.path(
         $routeSegment.getSegmentUrl('main.concierge.difficulty')
       )

     $scope.showSelectionPicker = ->
       $location.path(
         $routeSegment.getSegmentUrl('main.concierge.selection')
       )

     $scope.startConcierge = ->
       setup()
       $scope.showMealTimePicker()


     $scope.guessMealTime = MealTimeGuesserService.guess

     $scope.selectMealTime = (mealTime)->
       # Update data
       $scope.conciergeData.mealTime = mealTime
       $scope.headerInfo.mealName = $scope.conciergeData.mealTime
       # Apply new theme
       $scope.reTheme mealTime
       # Move on to the difficulty picker
       $scope.showDifficultyPicker()

     $scope.selectDifficulty = (difficulty)->
       # Update data
       $scope.conciergeData.difficulty = difficulty
       # Move on to the selection picker
       $scope.showSelectionPicker()

     $scope.selectRecipe = (recipeId)->
       # Get rejected recipes
       rejected = _.reject($scope.conciergeData.recipes, (el)->
         el.recipeId == recipeId
       )

       rejectedIds = _.map(rejected, (recipe) ->
         recipe.recipeId
       )

       selected = new RecipeResource({id: recipeId})

       selected.$select({
         "rejectedIds[]": rejectedIds
       })

       # Send put notice to server
       # Regardless of response, load path
       $location.path(
         $routeSegment.getSegmentUrl('main.recipe.instructions', { recipeId: recipeId })
       )

     $scope.skipToTheGoodStuff = ->
       # Apply defaults
       $scope.conciergeData.mealTime = $scope.guessMealTime()
       $scope.conciergeData.difficulty = 'easy'
       # Skip to the selector
       $scope.showSelectionPicker()



     # INITIALIZE
     setup()
     $scope.stylingInfo.outerClass = 'recipe-chooser'
     $scope.reTheme 'dinner'
])
