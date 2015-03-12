angular.module('whatsForDinnerApp').config(['$routeProvider', ($routeProvider)->
    $routeProvider.when('/', {
      templateUrl: 'views/templates/components/homeView.html',
      controller: 'HomeCtrl'
    })
    $routeProvider.when('/concierge', {
      templateUrl: 'views/templates/components/recipeChooserView.html',
      controller: 'RecipeChooserCtrl'
    })
    $routeProvider.when('/instructions', {
      templateUrl: 'views/templates/components/instructionView.html',
      controller: 'InstructionCtrl'
    })
    $routeProvider.otherwise({ redirectTo: '/' })
  ])