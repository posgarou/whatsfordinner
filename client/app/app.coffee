angular
  .module('whatsForDinnerApp', ['ngRoute', 'mm.foundation', 'templates'])
  .constant('PATHS', {
    "SHARED_PARTIALS": 'views/templates/shared',
    "COMPONENT_VIEWS": 'views/templates/components',
    "API": "api"
  })