var http = require("http"), 
   url = require("url"); 
 
http.createServer(function (request, response) { 
      // Parse the request for arguments and store them in _get variable. 
      // This function parses the url from request and returns object representation. 
      var _get = url.parse(request.url, true).query; 
      response.writeHead(200, { 
         'Content-Type': 'text/plain'
      }); 
      response.end('Here is your data: ' + _get.data); 
}).listen(8080);