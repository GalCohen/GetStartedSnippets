var static = require('node-static');
//
// Create a node-static server instance to serve the './public' folder
//

var file = new(static.Server)('./public');
require('http').createServer(function (request, response) {
        file.serve(request, response);
}).listen(8080);