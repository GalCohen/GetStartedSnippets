var EventEmitter = require('events').EventEmitter;
var domain = require('domain');

var server = require('http').createServer();
var a;

server.on('request', function(req, res){
    var d = domain.create();

    d.on('error', function (err) {
        res.writeHead(500);
        res.end(err.message);
    });

    d.run(function () {
        var ee = new EventEmitter();
        ee.emit('example', 1, 2, 3);
        ee.emit('error', new Error('something terrible'));
        res.end('Thank you for using our service');
    });
});
server.listen(8080);