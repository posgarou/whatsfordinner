angular
  .module('whatsForDinnerApp')
  .factory('UserHistoryResource',
    ['$http', '$q', 'UserHistoryInteraction',
    ($http, $q, UserHistoryInteraction) ->
      class UserHistoryResource
        constructor: (@user) ->
          # Wrap user in promise, since @user may or may not be resolved
          @q = $q.when(@user)
          @q.then (response) =>
            # Once we receive a response, grab the id
            @userId = response.id
            # API path
            resource_path = "/api/users/#{@userId}/recipes/history"
            # GET the resource
            $http.get(resource_path).success (data) =>
              # On response, set resource.histories = to data with each point wrapped
              # in UserHistoryInteraction
              @resource.histories = (new UserHistoryInteraction(datum) for datum in data)

          # Main interaction point with the class
          @resource = {
            histories: null
          }
  ])
