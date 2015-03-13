angular.module('whatsForDinnerApp').config(['PATHS', '$routeProvider', (PATHS, $routeProvider)->
    $routeProvider.when('/', {
      templateUrl: "#{PATHS.COMPONENT_VIEWS}/home/home.html",
      controller: 'HomeCtrl'
    })
    $routeProvider.when('/concierge', {
      templateUrl: "#{PATHS.COMPONENT_VIEWS}/recipeChooser/recipeChooser.html",
      controller: 'RecipeChooserCtrl'
    })
    $routeProvider.when('/instructions', {
      templateUrl: "#{PATHS.COMPONENT_VIEWS}/instructions/instruction.html",
      controller: 'InstructionCtrl'
    })
    $routeProvider.otherwise({ redirectTo: '/' })
  ])