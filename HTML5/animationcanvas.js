

function doFirst(){
	var x = document.getElementById('canvas');
	canvas = x.getContext('2d');

	window.addEventListener("mousemove", galsAnimation, false)	
}


function galsAnimation(e) {
	canvas.clearRect(0, 0, 600, 400);
	var xPos = e.clientX;
	var yPos = e.clientY;
	
	canvas.fillRect(xPos, yPos, 100, 100);
}

window.addEventListener('load', doFirst, false);