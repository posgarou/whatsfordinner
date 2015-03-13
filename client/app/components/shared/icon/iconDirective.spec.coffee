describe 'IconDirective', ->
  beforeEach ->
    module('whatsForDinnerApp')

  beforeEach inject ($rootScope, $compile) ->
    @scope = $rootScope.$new()
    @compile = $compile

    @compileWith = (name)->
      element = @compile("<icon name='#{name}'></icon>")(@scope)
      @scope.$digest()
      element

  it 'displays the users icon', ->
    expect(@compileWith('users').html()).toEqual('<span class="icon-users"></span>')

  it 'displays the meh icon', ->
    expect(@compileWith('meh').html()).toEqual('<span class="icon-meh"></span>')