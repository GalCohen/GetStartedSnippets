// Module dependencies.
var express = require('express'),
    redis = require('redis'),
    app = express();

// Configuration
app.configure( function() {
});

//var numbersArray = [];

// Routes
app.get('/poll', function(req, res) {
    var number = req.query.from,
        message = req.query.message;
    //numbersArray[number] = message;
    //var responseText = number + " ... " + message;
    //res.send(responseText);
    console.log(req.query);
});

app.get('/event', function(req, res) {
    //var response = JSON.stringify(numbersArray);
    //res.send(response);
    console.log(response);
});


app.listen(3000);