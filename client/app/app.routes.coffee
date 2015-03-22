# Use angular-route-segment to set up routes with nested controllers.
#
# Authenticates all access to /dashboard and /go paths.
angular.module('whatsForDinnerApp').config(['PATHS', '$routeSegmentProvider', (PATHS, $routeSegmentProvider)->
  $routeSegmentProvider
  .when('/', 'home')
  .when('/error', 'error')
  .when('/go', 'main')
  .when('/go/concierge', 'main.concierge')
  .when('/go/concierge/difficulty', 'main.concierge.difficulty')
  .when('/go/concierge/meal-time', 'main.concierge.mealTime')
  .when('/go/concierge/selection', 'main.concierge.selection')
  .when('/go/dashboard', 'main.dashboard')
  .when('/go/recipes', 'main.recipes')
  .when('/go/recipes/:recipeId', 'main.recipe')
  .when('/go/recipes/:recipeId/instructions', 'main.recipe.instructions')
  .when('/login', 'login')
  .when('/unauthorized', 'unauthorized')
  .when('/not-found', 'notFound')
  .segment('home', {
      templateUrl: "#{PATHS.COMPONENT_VIEWS}/home/home.html",
      controller: 'HomeCtrl'
    })
  .segment('error', {
    templateUrl: "#{PATHS.COMPONENT_VIEWS}/error/error.html",
    controller: 'ErrorCtrl'
  })
  .root()
  .segment('main', {
    templateUrl: "#{PATHS.COMPONENT_VIEWS}/main/main.html",
    controller: 'MainCtrl',
    resolve: {
      user: ['AuthenticationService', (AuthenticationService) ->
        AuthenticationService.validateUser()
      ]
    }
    resolveFailed: {
      templateUrl: "#{PATHS.COMPONENT_VIEWS}/unauthorized/unauthorized.html",
      controller: 'UnauthorizedCtrl'
    }
  })
  .within()
  .segment('dashboard', {
    templateUrl: "#{PATHS.COMPONENT_VIEWS}/main/dashboard/dashboard.html",
    controller: 'DashboardCtrl'
  })
  .up()
  .within()
  .segment('concierge', {
    templateUrl: "#{PATHS.COMPONENT_VIEWS}/main/concierge/concierge.html",
    controller: 'ConciergeCtrl'
  })
  .within()
  .segment('welcome', {
    default: true,
    templateUrl: "#{PATHS.COMPONENT_VIEWS}/main/concierge/welcome/welcome.html"
  })
  .segment('difficulty', {
    templateUrl: "#{PATHS.COMPONENT_VIEWS}/main/concierge/difficulty/difficulty.html",
    controller: 'DifficultyCtrl'
  })
  .segment('mealTime', {
    templateUrl: "#{PATHS.COMPONENT_VIEWS}/main/concierge/mealTime/mealTime.html",
    controller: 'MealTimeCtrl'
  })
  .segment('selection', {
    templateUrl: "#{PATHS.COMPONENT_VIEWS}/main/concierge/selection/selection.html",
    controller: 'SelectionCtrl'
  })
  .up()
  .segment('recipe', {
    templateUrl: "#{PATHS.COMPONENT_VIEWS}/main/recipe/recipe.html",
    controller: 'RecipeCtrl'
  })
  .within()
  .segment('overview', {
    default: true,
    templateUrl: "#{PATHS.COMPONENT_VIEWS}/main/recipe/recipe.html"
  })
  .segment('instructions', {
    default: true,
    templateUrl: "#{PATHS.COMPONENT_VIEWS}/main/recipe/instructions/instructions.html",
    controller: 'InstructionsCtrl'
  })
  .up()
  .segment('recipes', {
    templateUrl: "#{PATHS.COMPONENT_VIEWS}/main/recipes/recipes.html",
    controller: 'RecipesCtrl'
  })
  .root()
  .segment('login', {
    templateUrl: "#{PATHS.COMPONENT_VIEWS}/login/login.html",
    controller: 'LoginCtrl'
  })
  .root()
  .segment('unauthorized', {
    templateUrl: "#{PATHS.COMPONENT_VIEWS}/unauthorized/unauthorized.html",
    controller: 'UnauthorizedCtrl'
  })
  .root()
  .segment('notFound', {
      templateUrl: "#{PATHS.COMPONENT_VIEWS}/not-found/not-found.html",
      controller: 'NotFoundCtrl'
    })
])
