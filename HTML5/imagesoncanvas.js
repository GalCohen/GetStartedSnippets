

function doFirst(){
	var x = document.getElementById('canvas');
	canvas = x.getContext('2d');

	var pic = new Image();
	
	pic.src="screenshot2.png";
	pic.addEventListener("load", function(event) {
		canvas.drawImage(pic, 0, 0, x.width, x.height)
	}, false);
	
}


window.addEventListener('load', doFirst, false);