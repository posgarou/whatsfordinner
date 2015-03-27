angular
.module('whatsForDinnerApp')
.config(['$httpProvider', ($httpProvider) ->
  $httpProvider.interceptors.push(['$q', '$window', ($q, $window) ->
    {
      responseError: (rejection) ->
        if (rejection.status == 401)
          $window.location.href = $window.location.origin + '/#/unauthorized'
        $q.reject(rejection)
    }
  ])
])

