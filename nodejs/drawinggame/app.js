// Including libraries

var app = require('http').createServer(function (request, response) {
    request.addListener('end', function () {
        file.serve(request, response); // this will return the correct file
    });
}).listen(8080);

var io = require('socket.io').listen(app);
var static = require('node-static'); // for serving files

// This will make all the files in the current folder
// accessible from the web
var file = new(static.Server)('./assets');

// Delete this row if you want to see debug messages
//io.set('log level', 1);
/*
// Listen for incoming connections from clients
io.sockets.on('connection', function (socket) {

    // Start listening for mouse move events
    socket.on('mousemove', function (data) {

        // This line sends the event (broadcasts it)
        // to everyone except the originating client.
        socket.broadcast.emit('moving', data);
    });
});
*/