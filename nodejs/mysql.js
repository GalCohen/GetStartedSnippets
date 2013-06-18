var http = require('http'), 
   mysql = require("mysql"); 

var connection = mysql.createConnection({ 
   user: "root", 
   password: "", 
   database: "db_name"
}); 
 
http.createServer(function (request, response) { 
      // Query the database. 
      connection.query('SELECT * FROM your_table;', function (error, rows, fields) { 
         response.writeHead(200, { 
            'Content-Type': 'x-application/json' 
         }); 
         // Send data as JSON string. 
         // Rows variable holds the result of the query. 
         response.end(JSON.stringify(rows)); 
      }); 
}).listen(8080);