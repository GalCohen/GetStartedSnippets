var app = angular.module('superhero', []);

app.directive('superman', function  () {
    return {
        /* element directive
        restrict: "E",
        template: "<div>Here I am to save the day</div>"
        */

        /* attribute directive
        restrict: "A"
        link: function  () {
            alert("working!");
        }
        */

        /*  class directive
        restrict: "C",
        link: function  () {
            alert("working!");
        }
        */

        /* comment directive
        restrict: "M",
        link: function  () {
            alert("working!");
        }
        */

        restrict: "A",
        link: function(){
            alert("I'm working stronger");
        }
    };
});

app.directive('superman', function  () {
    return {
        restrict: "A",
        link: function(){
            alert("I'm working faster");
        }
    };
});