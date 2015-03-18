angular.module('whatsForDinnerApp').controller('ConciergeCtrl', ['$scope', 'ConciergeService', 'TEST_DATA', ($scope, ConciergeService, TEST_DATA) ->
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
  $scope.concierge = new ConciergeService TEST_DATA.USER_ID
  $scope.concierge.load()
  $scope.recipes = $scope.concierge.suggestions
  $scope.theme = 'dinner'

  $scope.headerText = ->
    _.sample $scope.headerTexts.common.concat($scope.headerTexts[$scope.theme])
])
