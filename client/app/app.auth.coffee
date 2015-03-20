angular
.module('whatsForDinnerApp')
.config(['$authProvider', ($authProvider) ->
  $authProvider.configure({
    parseExpiry: ((headers) ->
      # Parse UTC seconds since Epoch
      (new Date(headers['expiry'] * 1000)) || null
    ),
    storage: localStorage
  })
])
