// Module dependencies.
var express = require('express');
var VerEx = require('verbal-expressions');

var app = express.createServer();

// Configuration
app.configure( function() {
});

var counters = [];

// Routes
/*

app.param('company', /^\d+$/);

app.get('/event/:company', function(req, res) {
    res.send(req.params.company);
});
*/

//app.param('id', /^\d+$/);

//app.get('/user/:id', function(req, res){
//  res.send('user ' + req.params.id);
//});



app.get('/1', function(req, res) {

});


app.get('/2', function(req, res) {

});

app.get('/3', function(req, res) {

});

app.get('/4', function(req, res) {

});

app.listen(3000);