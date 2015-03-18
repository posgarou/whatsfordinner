angular.module('whatsForDinnerApp').config(['PATHS', '$routeProvider', (PATHS, $routeProvider)->
    $routeProvider.when('/', {
      templateUrl: "#{PATHS.COMPONENT_VIEWS}/home/home.html",
      controller: 'HomeCtrl'
    })
    $routeProvider.when('/concierge', {
      templateUrl: "#{PATHS.COMPONENT_VIEWS}/concierge/concierge.html",
      controller: 'ConciergeCtrl'
    })
    $routeProvider.when('/instructions/:recipeId', {
      templateUrl: "#{PATHS.COMPONENT_VIEWS}/instructions/instructions.html",
      controller: 'InstructionsCtrl'
    })
    $routeProvider.otherwise({ redirectTo: '/' })
  ])
