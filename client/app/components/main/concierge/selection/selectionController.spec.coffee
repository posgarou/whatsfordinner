describe 'SelectionCtrl', ->

  beforeEach ->
    module('whatsForDinnerApp')
    module( ($provide) ->
      class TestService
        constructor: (@user_id) ->
          @suggestions = []
        load: ->
          @suggestions = ['recipe1', 'recipe2', 'recipe3']

      $provide.value('SelectionService', TestService)
      null
    )

  beforeEach inject ($rootScope, $controller, $routeParams) ->
    @routeParams = $routeParams
    @routeParams.recipeId = 134

    # MAINCTRL
    @mainScope = $rootScope.$new()
    @mainCtrl = $controller 'MainCtrl', $scope: @mainScope

    @mainScope.headerInfo = {
      h1: ''
    }
    @mainScope.stylingInfo = {
      theme: 'dinner'
    }
    @mainScope.reTheme = ->

    @selectionScope = @mainScope.$new()
    @selectionScope = $controller 'ConciergeCtrl', $scope: @selectionScope

    # conciergeCTRL
    @scope = @selectionScope.$new()
    @ctrl = $controller 'ConciergeCtrl', $scope: @scope

  describe 'initially', ->
    it 'includes theme', ->
      console.log @scope.instructions
      expect(@scope.stylingInfo.theme).toBeDefined()
    it 'includes recipes', ->
      expect(@scope.recipes).toBeDefined()

#  describe 'headerText', ->
#    beforeEach ->
#      @combinedOptionsForTheme = (themeName) ->
#        @scope.stylingInfo.theme = themeName
#        @scope.headerTexts.common.concat(@scope.headerTexts[themeName])
#    it 'chooses a common or breakfast saying when the theme breakfast lunch', ->
#      expect(@combinedOptionsForTheme('breakfast')).toContain(@scope.headerInfo.h1)
#    it 'chooses a common or lunch saying when the theme is lunch', ->
#      expect(@combinedOptionsForTheme('lunch')).toContain(@scope.headerInfo.h1)
#    it 'chooses a common or snack saying when the theme is snack', ->
#      expect(@combinedOptionsForTheme('snack')).toContain(@scope.headerInfo.h1)
#    it 'chooses a common or dinner saying when the theme is dinner', ->
#      expect(@combinedOptionsForTheme('dinner')).toContain(@scope.headerInfo.h1)
