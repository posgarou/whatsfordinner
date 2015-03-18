describe 'InstructionsResource', ->
  beforeEach ->
    module('whatsForDinnerApp')

  beforeEach inject ($injector) ->
    @httpBackend = $injector.get('$httpBackend')
    @rootScope = $injector.get('$rootScope')
    @instructions = $injector.get('InstructionsResource')

  afterEach ->
    @httpBackend.verifyNoOutstandingExpectation()
    @httpBackend.verifyNoOutstandingRequest()

  it 'calls the GET route for recipe/:id/instructions', ->
    @httpBackend.expectGET('/api/recipes/40/instructions').respond(200, 'success')
    @instructions.get({ recipeId: 40 })
    @httpBackend.flush()

