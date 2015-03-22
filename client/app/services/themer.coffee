angular
.module('whatsForDinnerApp')
.service('Themer', ['$rootScope', ($rootScope) ->
  new class Themer
    constructor: (@bodyClass='') ->
      $rootScope.bodyClass = @bodyClass

    setBodyClass: (newClass) ->
      @bodyClass = newClass
      $rootScope.bodyClass = newClass
])
