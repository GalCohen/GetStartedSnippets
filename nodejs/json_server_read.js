var net = require('net');
var JSONStream = require('json-stream');
var pup = require('pup');
var es = require('event-stream');


module.exports = function (source) {
    var server = net.createServer();

    server.on('connection', function (socket) {
        var jsonStream = new JSONStream();


        var stringifier = es.mapSync(function (data) {
            return JSON.stringify(data) + '\n';
        });


        function end() {
            pup.unpipe(source, stringifier);
            pup.unpipe(source, socket);
            started = false;
        }


        var actions = {
            start:function(command){
                if(started) return;
                pup.pipe(source, stringifier);
                pup.pipe(source, socket);
                source
                    .pipe(stringifer)
                    .pipe(socket);
                
                started = true;
            },
            stop: end
        };
        jsonStream.on('data', function (command) {
           var action = command.action;
           if (action && actions[action]) {
               actions[action](command);
           }
        })
    });

    server.listen(4001);
};
