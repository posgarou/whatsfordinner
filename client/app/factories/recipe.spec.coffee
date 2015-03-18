describe 'Recipe', ->
  beforeEach ->
    module('whatsForDinnerApp')

  beforeEach inject ($injector) ->
    @httpBackend = $injector.get('$httpBackend')
    @rootScope = $injector.get('$rootScope')
    @recipe = $injector.get('Recipe')

  afterEach ->
    @httpBackend.verifyNoOutstandingExpectation()
    @httpBackend.verifyNoOutstandingRequest()

  it 'calls the GET route for recipe/:id', ->
    @httpBackend.expectGET('/api/recipes/45').respond(200, 'success')
    @recipe.get({ recipeId: 45 })
    @httpBackend.flush()

