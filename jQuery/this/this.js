$(document).ready(function() {
    $('div').click(function() {
        //"this" here refers to the $('div'), so you dont have 
        //to use the selector to find it again
        $(this).fadeOut('slow');
    });
});