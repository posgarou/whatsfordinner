angular
.module('whatsForDinnerApp')
.directive('scroller',
  ["smoothScroll",
  (smoothScroll)->
    {
      restrict: 'E',
      template: '<div class="scroller-container"><a class="btn-scroller" ng-click="scrollAway()"><icon name="arrow-down"></icon></a></div>'
      scope: {
        elementId: '='
      },

      link: (scope, el, attrs) ->
        options = {
          duration: 900,
          easing: 'easeOutCubic'
        }

        scope.scrollAway = ->
          targetId = '#' + attrs.elementId
          targetEl = $(targetId)[0]

          if targetEl?
            smoothScroll(targetEl, options)
          else
            console.log "No element with #{targetId} exists."

    }
])
