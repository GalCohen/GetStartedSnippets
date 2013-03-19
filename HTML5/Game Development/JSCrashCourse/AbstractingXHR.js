
function xhrGet(reqUri, callback, type) {
    // YOUR CODE HERE
    var xhr = new XMLHttpRequest();
    xhr.open("GET", reqUri, true);
    xhr.responseType = type;
    xhr.onload = callback;
}

parseJSON = function (xhr) {
    parsedJSON = JSON.parse(xhr.responseText);

    x = parsedJSON['frames']['chaingun_impact.png']['spriteSourceSize']['x'];
    console.log(x);
    return x;
};

playSound = function (xhr) {
    try {
        var context = new webkitAudioContext();

        var mainNode = context.createGainNode(0);
        mainNode.connect(context.destination);

        var clip = context.createBufferSource();

        context.decodeAudioData(xhr.response, function (buffer) {
            clip.buffer = buffer;
            clip.gain.value = 1.0;
            clip.connect(mainNode);
            clip.loop = true;
            clip.noteOn(0);
        }, function (data) {});
    }
    catch(e) {
        console.warn('Web Audio API is not supported in this browser');
    }
};

// Test code for you to run
var test = function() {
    xhrGet('/media/js/standalone/libs/gamedev_assets/weapon.json', parseJSON, null);
    xhrGet('/media/js/standalone/libs/gamedev_assets/bg_menu.ogg', playSound, 'arraybuffer');
};

//test();
