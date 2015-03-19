angular
.module('whatsForDinnerApp')
.service('AuthenticationService', [
  '$auth',
  ($auth) ->
    new class Authenticator
      constructor: ->
      isLoggedIn: ->
        $auth.validateUser()
      currentUser: ->
        @isLoggedIn().then( (data) =>
          console.log data
        ).catch( (data, e) ->
          console.log data, e
        )
        {}
])
