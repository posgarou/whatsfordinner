angular.module('whatsForDinnerApp').config(['$routeProvider', ($routeProvider)->
    $routeProvider.when('/', {
      templateUrl: 'views/components/homeView.html',
      controller: 'HomeCtrl'
    })
    $routeProvider.when('/concierge', {
      templateUrl: 'views/components/recipeChooserView.html',
      controller: 'RecipeChooserCtrl'
    })
    $routeProvider.when('/instructions', {
      templateUrl: 'views/components/instructionView.html',
      controller: 'InstructionCtrl'
    })
    $routeProvider.otherwise({ redirectTo: '/' })
  ])