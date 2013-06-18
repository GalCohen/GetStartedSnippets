var fs = require('fs');

var readStream = fs.createReadStream('/var/log/systen.log');

readStream.on('data', function ( data) {
    console.log('got some data:', data);

    readStream.pause();

    setTimeout(function () {
        readSteam.resume();
    }, 1000);
});

readStream.on('end', function () {
    console.log('ended');
});

readStream.setEncoding('utf-8');