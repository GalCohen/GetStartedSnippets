$(document).ready(function(){
    $('#button').click(function(){
        var toAdd = $('input[name=checkListItem]').val();
        $('.list').append('<div class="item">'+toAdd+'</div>');
    });
    
    //the .on() method adds a certain event to a selector
    //whenever a new element fitting the selector is added
    //this way, every time a new element with the class list is
    //added, it already has the click event that removes it
    //binded to it
    $(document).on('click', '.item', function(){
         $(this).remove();
    });
});
