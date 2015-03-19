angular
.module('whatsForDinnerApp')
.controller('RecipesCtrl', ['$scope', ($scope) ->
    console.log('recipes controller')
    console.log $scope
    $scope.headerInfo.h1 = 'foo'
])
