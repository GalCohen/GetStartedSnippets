var myApp = angular.module('myApp', []);

myApp.factory('Avengers', function  () {
    var Avengers = {};
    Avengers.cast = [
        {
            name: "Robert Downey Jr.",
            character: "Tony Stark / Iron Man"
        },
        {
            name: "Chris Evans",
            character: "Steve Rogers / Captain America"
        },
        {
            name: "Mark Ruffalo",
            character: "Bruce Banner / The Hulk"
        },
        {
            name: "Chris Hemsworth",
            character: "Thor"
        },
        {
            name: "Cobie Smulders",
            character: "Agent Maria Hill"
        },
        {
            name: "Stellan Skarsgard",
            character: "Selvig"
        },
        {
            name: "Samuel L. Jackson",
            character: "Nick Fury"
        },
        {
            name: "Gwyneth Paltrow",
            character: "Pepper Potts"
        },
        {
            name: "Paul Bettany",
            character: "Jarvis (voice)"
        },
        {
            name: "Alexis Denisof",
            character: "The Other"
        },
        {
            name: "Tina Benko",
            character: "NASA Scientist"
        }
   ];
    return Avengers;
});


function AvengersCtrl ($scope, Avengers) {
    $scope.avengers = Avengers;
}
