var net = require('net');

var JSONStream = require('json-stream');

var filepath = __dirname + '/logs.json';
var file = require('fs')
    .createWriteStream(filepath, {flags: 'a'});

var es = require('event-stream');

var stringifer = es.mapSync(function (data) {
    return JSON.stringify(data) + '\n';
});
stringifer.pipe(file);

var server = net.createServer();

server.on('connection', function(socket) {
    //socket.pipe(file, {end:false});
    var jsonStream = new JSONStream();
    socket
        .pipe(jsonStream)
        .pipe(stringifer, {end: false});
});


server.listen(4000);