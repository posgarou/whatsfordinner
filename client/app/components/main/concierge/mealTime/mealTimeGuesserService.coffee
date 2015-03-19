# Based on the hour of the day, determine what meal the person is
# likely looking for.

angular
.module('whatsForDinnerApp')
.service('MealTimeGuesserService', [ ->
  guesser = {}
  guesser.guess = ->
    @currentHour = new Date().getHours()

    @guess = switch
      when @currentHour < 4 then 'snack'
      when 4 <= @currentHour < 11 then 'breakfast'
      when 11 <= @currentHour < 15 then 'lunch'
      when 15 <= @currentHour < 22 then 'dinner'
      else 'snack'
  guesser
])
