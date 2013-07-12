var app = angular.module("app", []).config( function ($routeProvider) {
    'use strict';
    $routeProvider.when('/login', {
        templateUrl: 'login.html',
        controller: 'loginController'
    });
    
    $routeProvider.when('/home', {
        templateUrl: 'home.html',
        controller: 'homeController'
    });
    
    $routeProvider.otherwise({redirectTo: '/login'});
    
});

app.controller('loginController', ['$scope', 'AuthenticationService', function($scope, AuthenticationService) {
	'use strict';	
    window.scope = $scope;
    $scope.credentials = { username : "", password: "" };
    $scope.login = function () {
        /*if ($scope.credentials.username !== "ralph") {
           //alert('username must be ralph'); 
            $location.path('/home');
        }
        */
        AuthenticationService.login($scope.credentials);
    };

}]);


app.controller('homeController', ['$scope','AuthenticationService' , function($scope, AuthenticationService) {
	'use strict';		
    $scope.title = "Home";
    $scope.message = "Mouse over these images to see a directive at work!";
    $scope.logout = function () {
        //$location.path('/login');
        AuthenticationService.logout();
    };
}]);

app.factory("AuthenticationService", ['$location', function ($location) {
    return {
        login: function(credentials){
            if (credentials.username === "ralph") {
                $location.path('/home');
            }
        },
        logout: function(){
            $location.path('/login');
        }
    };
}]);

app.directive('showMessageWhenHovered', function () {
    return {
        restrict: "A",  //A == attrivute, C = class name E= element M = html content
        link:  function (scope, element, attributes) {
           var originalMessage = scope.message;
           element.bind("mouseover", function () {
                scope.message = attributes.message;
                scope.$apply();
           });
           element.bind("mouseout", function () {
                scope.message = originalMessage;
                scope.$apply();
           });
        }
    };
})