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
     'ng-token-auth'
    ]
  )
  .constant('PATHS', {
    "COMPONENT_VIEWS": 'views/components',
    "SHARED_VIEWS": 'views/components/shared'
  })
  .constant('TEST_DATA', {
    'USER_ID': '54ae1997-a117-449b-85b9-5261e2185f42'
  })
