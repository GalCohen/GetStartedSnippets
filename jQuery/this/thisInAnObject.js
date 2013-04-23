/*
when this is outside of any function, it refers to the global object 
(the window). this also refers to the global object when it is used in a 
function that is not part of an object.

But when a function that is part of an object is called, within that 
function, the this will refer to the object to which the function belongs.
*/

var myObject = {
    
    'name':'objecty',
    'score':23,
    'sayName': function() {
       alert(this.name);
    },
    'doubleScore': function() {
        //double the score
        this.score *= 2;
    }

}
