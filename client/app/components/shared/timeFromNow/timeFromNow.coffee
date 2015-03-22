angular
.module('whatsForDinnerApp')
.directive('timeFromNow', ->
  link = (scope, el, attrs) ->
    scope.datetime = attrs.datetime
    scope.timeString = ->
      moment(attrs.datetime).fromNow()
  {
    restrict: 'E',
    scope: {
      datetime: '@'
    },
    template: '<time datetime="{{datetime}}">{{ timeString() }}</time>',
    link: link
  }
)
