var o = {'x':6};

var x = 9;

function alertX() {
    alert(this.x);
}

//use proxy so that calling alertX() will alert the value
// of o.x (currently 6), not x in the global scope (currently 9)
var $proxiedAlertX = $.proxy( alertX, o);