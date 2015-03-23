angular
  .module('whatsForDinnerApp')
  .factory('UserHistoryInteraction', ['TitleCaseFilter', 'lowercaseFilter', (TitleCaseFilter, lowercaseFilter) ->
    class HistoricalInteraction
      constructor: (data) ->
        @eventDate = data['event_date']
        @eventType = TitleCaseFilter(data['type'])
        @was_made = data['was_made']
        @confirmed = @was_made?
        @confirmationDate = data['date_confirmed']
        @rating = data['rating']
        @recipe = data['recipe']
        @rowClass = lowercaseFilter(@eventType)
      isSelected: ->
        @eventType == 'Selected'
  ])
