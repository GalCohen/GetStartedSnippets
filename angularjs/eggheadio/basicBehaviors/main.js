var app = angular.module('behaviorApp', []);

/*
app.directive("enter", function  () {
    return {
        restrict: "A",
        link: function  (scope, element) {
            element.bind("mouseenter", function  () {
                console.log("I'm inside of you");
            });
        }
    };
});
*/

// equivalent code to above
app.directive("enter", function  () {
    return function  (scope, element) {
            element.bind("mouseenter", function  () {
                console.log("I'm inside of you");
            });
    };
});


app.directive("leave", function  () {
    return function  (scope, element) {
            element.bind("mouseleave", function  () {
                console.log("I'm leaving on a jetplane!");
            });
    };
});

