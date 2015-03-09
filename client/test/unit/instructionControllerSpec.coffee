describe 'InstructionCtrl', ->
  beforeEach ->
    module('whatsForDinnerApp')

  beforeEach inject ($rootScope, $controller) ->
    @scope = $rootScope.$new()
    @ctrl = $controller 'InstructionCtrl', $scope: @scope

  it 'has instructions defined on the $scope', ->
    expect(@scope.instructions).toBeDefined()