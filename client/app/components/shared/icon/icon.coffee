angular.module('whatsForDinnerApp').directive 'icon', ->
  {
    restrict: 'E',
    scope: {
      name: '@'
    },
    template: '<span class="icon-{{name}}"></span>'
  }