angular
  .module('whatsForDinnerApp')
  .factory('Instructions', ['InstructionsResource', (InstructionsResource) ->
    class Instructions
      constructor: (@recipeId, @theme = 'dinner') ->
        @load()
      load: ->
        InstructionsResource.get({
          recipeId: @recipeId
        }, (data) =>
          # Copy data from server object into this
          for key of data['instructions']
            this[key] = data['instructions'][key]
          console.log this
        )
  ])
