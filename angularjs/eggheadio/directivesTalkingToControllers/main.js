var app = angular.module('twitterApp', []);

app.controller('AppCtrl', ['$scope', function ($scope) {
   $scope.loadMoreTweets = function  () {
       alert("loading tweets");
   };

   $scope.deleteTweets = function  () {
       alert("deleting tweets");
   };
}]);

// equivalent code to above
app.directive("enter", function  () {
    return function  (scope, element, attrs) {
            element.bind("mouseenter", function  () {
                scope.$apply(attrs.enter);
            });
    };
});
