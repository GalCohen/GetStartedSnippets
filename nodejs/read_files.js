var fs = require('fs');

var results = fs.readFile('/etc/passwd', 'utf-8', callback);

function callback(err, results) {
    if (err) {
        return handleError(err);
    }
    console.log('File Contents:', results);
}
