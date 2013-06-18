
var net = require('net');
var JSONStream = require('json-stream');
var es = require('event-stream');
var filepath = __dirname + '/logs.json';
var file = require('fs')
    .createWriteStream(filepath, {flags: 'a'});


function identity(d) {
    return d;
}
var source = es.mapSync(identity);

var stringifier = es.mapSync(function (data) {
    return JSON.stringify(data) + '\n';
});
stringifier.pipe(file);

source
    .pipe(stringifier)
    .pipe(file);

var server = net.createServer();

server.on('connection', function(socket) {
    //socket.pipe(file, {end:false});
    var jsonStream = new JSONStream();
    socket
        .pipe(jsonStream)
        .pipe(stringifier, {end: false});
});


server.listen(4000);