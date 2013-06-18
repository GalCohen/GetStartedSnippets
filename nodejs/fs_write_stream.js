var fs = require('fs');

var writeStream = fs.createWriteStream('/tmp/write.txt');

var interval = setInterval(function () {
    writeStream.write((new Date()).toString() + '\n');
}, 100);


setTimeout(function () {
    clearInterval(interval);
    writeStream.end();
}, 5000);

writeStream.on('drain', function(){
    console.log('drained.');
});