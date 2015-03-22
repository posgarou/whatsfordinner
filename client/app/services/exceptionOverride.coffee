angular
.module('whatsForDinnerApp')
.factory('$exceptionHandler', ['$log', '$window', ($log, $window) ->
  (exception, cause) ->
    exception.message += " (caused by #{cause})"
    $log.error exception.message

    console.log $window.location
    $window.location.href = $window.location.origin + '/#/error'
#    $window.location.reload()
#    $window.location.reload()
])
