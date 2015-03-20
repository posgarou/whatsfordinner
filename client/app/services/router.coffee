angular
.module('whatsForDinnerApp')
.service('Router', ['$location', '$routeSegment', ($location, $routeSegment) ->
  new class Router
    redirectTo: (segmentName, segmentParams={}, routeParams={}) =>
      path = $routeSegment.getSegmentUrl(segmentName, segmentParams)
      path += '?' + $.param(routeParams) unless _.isEmpty(routeParams)

      $location.path(path)

    # Convenience Methods
    phoneHome: =>
      @redirectTo 'home'

    login: =>
      @redirectTo 'login'

    concierge: =>
      @redirectTo 'main.concierge'
])
