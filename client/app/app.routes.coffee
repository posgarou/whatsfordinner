angular.module('whatsForDinnerApp').config(['PATHS', '$routeProvider', (PATHS, $routeProvider)->
    $routeProvider.when('/', {
      templateUrl: "#{PATHS.COMPONENT_VIEWS}/homeView.html",
      controller: 'HomeCtrl'
    })
    $routeProvider.when('/concierge', {
      templateUrl: "#{PATHS.COMPONENT_VIEWS}/recipeChooserView.html",
      controller: 'RecipeChooserCtrl'
    })
    $routeProvider.when('/instructions', {
      templateUrl: "#{PATHS.COMPONENT_VIEWS}/instructionView.html",
      controller: 'InstructionCtrl'
    })
    $routeProvider.otherwise({ redirectTo: '/' })
  ])