angular.module('whatsForDinnerApp').config(['PATHS', '$routeSegmentProvider', (PATHS, $routeSegmentProvider)->
  $routeSegmentProvider
  .when('/', 'home')
  .when('/dashboard', 'dashboard')
  .when('/go', 'main')
  .when('/go/concierge', 'main.concierge')
  .when('/go/concierge/difficulty', 'main.concierge.difficulty')
  .when('/go/concierge/meal-time', 'main.concierge.mealTime')
  .when('/go/concierge/selection', 'main.concierge.selection')
  .when('/go/recipes', 'main.recipes')
  .when('/go/recipes/:recipeId', 'main.recipe')
  .when('/go/recipes/:recipeId/instructions', 'main.recipe.instructions')
  .segment('home', {
      templateUrl: "#{PATHS.COMPONENT_VIEWS}/home/home.html",
      controller: 'HomeCtrl'
    })
  .segment('dashboard', {
    templateUrl: "#{PATHS.COMPONENT_VIEWS}/dashboard/dashboard.html",
    controller: 'DashboardCtrl'
  })
  .segment('main', {
    templateUrl: "#{PATHS.COMPONENT_VIEWS}/main/main.html",
    controller: 'MainCtrl'
  })
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
])
