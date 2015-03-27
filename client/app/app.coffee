angular
  .module(
    'whatsForDinnerApp',
    ['ngRoute',
     'smoothScroll',
     'route-segment',
     'view-segment',
     'ngResource',
     'mm.foundation',
     'templates',
     'ipCookie',
     'ng-token-auth'
    ]
  )
  .constant('PATHS', {
    "COMPONENT_VIEWS": 'views/components',
    "SHARED_VIEWS": 'views/components/shared'
  })
