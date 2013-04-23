$('document').ready(function(){

//$exampleJQuery is jQuery object containing every element
// in the HTML page
var $exampleJQuery = $('*')

function addToKeyList(key) {
    $('#keylist').append('<li>'+key+'</li>');
}

//iterate over $exampleJQuery
//calling addToKeyList for every key it contains
for (i in $exampleJQuery){
    addToKeyList(i);
}


//run this code and check out the list.
//a lot of cool things, there,
//that you will be learning about in the next couple of weeks
});
