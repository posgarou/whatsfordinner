angular.module('whatsForDinnerApp').factory 'RecipePreview', ['$http', ($http) ->
  class RecipePreview
    constructor: ->
      @loadData()
    loadData: ->
      @title = 'Recipe!'
      @description = 'Description!'
]