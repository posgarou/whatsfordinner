describe 'InstructionsCtrl', ->
  beforeEach ->
    module('whatsForDinnerApp')
    module(($provide) ->
      @mock = (recipeId) ->
        {}
      $provide.value('Instructions', @mock)
      # You HAVE to return null in the module ($provide) call in CS,
      # or you get an obsure fn/object error.
      null
    )

  beforeEach inject ($rootScope, $controller) ->
    @scope = $rootScope.$new()
    @ctrl = $controller 'InstructionsCtrl', $scope: @scope


  it 'has instructions defined on the $scope', ->
    expect(@scope.instructions).toBeDefined()
