describe 'InstructionsCtrl', ->
  beforeEach ->
    module('whatsForDinnerApp')

  beforeEach inject ($rootScope, $controller) ->
    @scope = $rootScope.$new()
    @ctrl = $controller 'InstructionsCtrl', $scope: @scope

  it 'has instructions defined on the $scope', ->
    expect(@scope.instructions).toBeDefined()
