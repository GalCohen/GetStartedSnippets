


var canvas = null;
var context = null;
var img = null;

var onImageLoad = function(){
	console.log("IMAGE!!!");
    context.drawImage(img, 192, 192);
};

var setup = function() {
	var body = document.getElementById("body");
	canvas = document.createElement("canvas");

	context = canvas.getContext('2d');

	canvas.setAttribute('width', 500);
	canvas.setAttribute('height', 700);

	body.appendChild(canvas);

	img = new Image();
	img.onload = onImageLoad;
	img.src = "/media/js/standalone/libs/gamedev_assets/ralphyrobot.png";
};


setup();
