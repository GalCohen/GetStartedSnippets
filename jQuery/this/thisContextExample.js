var question1 = function() {
    this.x = 5;
     (function() {
        var x = 3;
        this.x = x;
    })();
    alert(this.x);
};
var answer1 = 3;


var question2 = function() {
    this.x = 9;
    var o = {
        'x':5,
        'alertX':function() { alert(this.x); }
    };
    var alertX = o.alertX;
    alertX();
}
var answer2 = 9;

