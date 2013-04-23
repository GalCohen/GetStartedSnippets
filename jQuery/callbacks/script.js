
function louisCallback() {
    alert('Mwahahah you will never learn callbacks!');
}

function myCallback() {
    var $click = $('#clickme');
    $click.width($click.width()*2);
}

$(document).ready(function() {
    $('#clickme').click(myCallback); 
});
