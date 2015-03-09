describe 'RecipeChooserCtrl', ->
  beforeEach ->
    module('whatsForDinnerApp')

  beforeEach inject ($rootScope, $controller) ->
    @scope = $rootScope.$new()
    @ctrl = $controller 'RecipeChooserCtrl', $scope: @scope

  describe 'scope variables', ->
    it 'includes theme', ->
      expect(@scope.theme).toBeDefined()
    it 'includes recipes', ->
      expect(@scope.recipes).toBeDefined()

  describe 'headerText', ->
    beforeEach ->
      @combinedOptionsForTheme = (themeName) ->
        @scope.theme = themeName
        @scope.headerTexts.common.concat(@scope.headerTexts[themeName])
    it 'chooses a common or breakfast saying when the theme breakfast lunch', ->
      expect(@combinedOptionsForTheme('breakfast')).toContain(@scope.headerText())
    it 'chooses a common or lunch saying when the theme is lunch', ->
      expect(@combinedOptionsForTheme('lunch')).toContain(@scope.headerText())
    it 'chooses a common or snack saying when the theme is snack', ->
      expect(@combinedOptionsForTheme('snack')).toContain(@scope.headerText())
    it 'chooses a common or dinner saying when the theme is dinner', ->
      expect(@combinedOptionsForTheme('dinner')).toContain(@scope.headerText())