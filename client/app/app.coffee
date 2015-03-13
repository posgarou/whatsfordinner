angular
  .module('whatsForDinnerApp', ['ngRoute', 'mm.foundation', 'templates'])
  .constant('PATHS', {
    "COMPONENT_VIEWS": 'views/components',
    "SHARED_VIEWS": 'views/components/shared',
    "API": "api"
  })