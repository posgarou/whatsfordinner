angular.module('whatsForDinnerApp').controller('RecipeChooserCtrl', ['$scope', 'RecipePreview', ($scope, RecipePreview) ->
  $scope.headerTexts = {
    'common': [
      'Hungry? Good.',
      'Let\'s fix hungry',
      'Time for Food'
    ],
    'breakfast': [
      'Champion, Right Here'
    ],
    'lunch': [
      'Lunchtime'
    ],
    'snack': [
      'Still the Grumbling Stomach'
    ],
    'dinner': [
      'Dinnertime'
    ]
  }
  $scope.recipes = [
    new RecipePreview,
    new RecipePreview,
    new RecipePreview
  ]
  $scope.theme = 'dinner'

  $scope.headerText = ->
    _.sample $scope.headerTexts.common.concat($scope.headerTexts[$scope.theme])
])