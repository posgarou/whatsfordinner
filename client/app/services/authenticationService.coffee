angular
.module('whatsForDinnerApp')
.service('AuthenticationService', [
  '$auth',
  '$q',
  '$rootScope',
  'Router'
  ($auth, $q, $rootScope, Router) ->
    new class Authenticator
      constructor: ->
        @user = {
          data: null
        }
        @deferred = null

      isLoggedIn: =>
        if @user?
          @user
        else
          @deferred

      invalidateUser: =>
        @user = {
          data: null
        }
        @deferred = null

      validateUser: =>
        if @user.data?
          @user
        else if @deferred?
          @deferred
        else
          @deferred = $auth.validateUser()

          @deferred.then (response)=>
            @user = response
          .catch (data, error) ->
            console.log 'Unable to validate user'
            unless Router.isAtLocation('home') or Router.isAtLocation('login')
              Router.phoneHome()
          @deferred

      logout: =>
        $auth.signOut()
        $auth.user.signedIn = false
        @user.data = null
        @deferred = null
        Router.phoneHome()

      authenticate: (provider) =>
        $auth.authenticate(provider).then (data) =>
          @user = data
          # Reset @deferred toa allow future validation queries to go through
          # if for any reason necessary
          @deferred = null
])
