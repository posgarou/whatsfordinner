angular.module('whatsForDinnerApp').factory 'Instructions', ["$http", ($http) ->
  class Instructions
    constructor: ->
      @loadData()
    loadData: ->
      @title = 'Huevos Rancheros'
      @description = 'Here is a description of the recipe. It should describe the recipe, why you want to make it, etc. It should\'t be too long, but it should at least introduce concepts, etc.'
      # includes serves.originalAmount to show scaling
      @serves = {
        currentAmount: 2,
      }
      @cuisines = [
        { name: 'Tex-Mex' }
      ]
      @tags = [
        { name: 'pan-fried' },
        { name: 'vegetarian' }
      ]
      @mealtimes = [
        { name: 'breakfast' },
        { name: 'snack' }
      ]
      @theme = 'dinner'
      # easy, medium, and hard
      @difficulty = 'easy'
      # like, meh, or dislike (meh is default)
      @rating = 'meh'
      @ingredients = [
        '2 eggs',
        '2 corn tortillas',
        'salt',
        'pepper',
        '1 tsp olive oil'
      ]
      @timeframe = {
        displayText: '15 min',
        breakdownText: '5 min prep and 10 min cooking'
      }
      @serveWith = [
        {
          name: 'salsa',
          type: 'recipe'
        },
        {
          name: 'guacamole',
          type: 'recipe'
        },
        {
          name: 'sour cream',
          type: 'ingredient'
        }
      ]
      @steps = [
        { text: 'Heat the oil in a large skillet over medium heat.' },
        { text: 'Place the tortillas inside the skillet.' },
        {
          text: 'Crack an egg over each tortilla. Salt and pepper each egg. Cook until the egg whites have solidified.',
          tip: 'If your oven surface isn\'t even, you may want to remove the pan to a level trivet while cracking the eggs. If you do this, balance the frying pan until the egg whites have started to solidify. Don\'t worry if the eggs start sliding off, though—the part that slides off gets crispy and delicious!'
        },
        {
          text: 'Use a flat spatula to flip each tortilla and egg so that the egg comes into direct contact with the pan. Cook to desired doneness.',
          optional: true,
          tip: 'This allows the egg to get some caramelization, and it also allows the egg to get cooked without the tortilla getting too crispy. But you can also serve the eggs and tortillas sunny-side-up.'
        },
        { text: 'Remove to individual plates and serve.' }
      ]
]