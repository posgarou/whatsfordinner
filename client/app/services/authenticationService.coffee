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
        @user = null
        @deferred = null

      isLoggedIn: =>
        if @user?
          @user
        else
          @deferred

      listenForInitialValidation: =>
        if @user?
          @user
        else if @deferred?
          @deferred
        else
          @deferred = $auth.validateUser()

          @deferred.then (data) =>
            @user = data
          .catch (data, error) ->
            console.log 'Login error.'
          @deferred


      logout: =>
        $auth.signOut()
        Router.phoneHome()

      currentUser: =>
        $auth.user

      authenticate: (provider) =>
        $auth.authenticate(provider).then (data) =>
          @user = data
])
