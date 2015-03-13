describe 'Rating Bar', ->
  beforeEach ->
    module('whatsForDinnerApp')

  beforeEach inject ($rootScope, $compile) ->
    @scope = $rootScope.$new()
    @compile = $compile

    @compileDirective = ->
      element = @compile("<rating-bar></rating-bar>")(@scope)
      @scope.$digest()
      element

  describe 'by default', ->
    it 'shows the dislike, meh, and like icons', ->
      element = @compileDirective()
      expect(element.find('.icon-dislike-no').length).toBeGreaterThan(0)
      expect(element.find('.icon-meh-no').length).toBeGreaterThan(0)
      expect(element.find('.icon-like-no').length).toBeGreaterThan(0)