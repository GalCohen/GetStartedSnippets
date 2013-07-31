var app = angular.module('drinkApp', []);

app.controller("AppCtrl", function  ($scope) {
    $scope.ctrlFlavor = "strawberry";
})

app.directive("drink", function  () {
    return {
        template: '<input type="text" ng-model="flavor">',
        scope: {
            flavor:"="
       }
    };
});