describe 'SelectionService', ->
  beforeEach ->
    module('whatsForDinnerApp')

  beforeEach inject ($injector) ->
    @httpBackend = $injector.get('$httpBackend')
    @rootScope = $injector.get('$rootScope')
    @selector = $injector.get('SelectionService')

    @httpBackend.expectGET('/api/users/40/recipes/concierge').respond(
      [
        {title: 'Recipe 1', description: 'Recipe 1 Desc', id: '1'},
        {title: 'Recipe 2', description: 'Recipe 2 Desc', id: '2'},
        {title: 'Recipe 3', description: 'Recipe 3 Desc', id: '3'}
      ]
    )

  afterEach ->
    @httpBackend.verifyNoOutstandingExpectation()
    @httpBackend.verifyNoOutstandingRequest()

  it 'calls the GET route for /api/users/40/recipes/concierge', ->
    selector = new @selector(40)
    selector.load()
    @httpBackend.flush()

  it 'loads in the JSON data', ->
    selector = new @selector(40)
    selector.load()
    @httpBackend.flush()

    expect(selector.suggestions.length).toEqual(3)

