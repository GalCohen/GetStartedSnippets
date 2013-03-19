

function doFirst(){
	var x = document.getElementById('canvas');
	canvas = x.getContext('2d');

	canvas.font = "bold 36px Tahoma";
	canvas.textAlign = "start";
	
	canvas.save();
	canvas.fillText("lets begin", 10, 30);
	
	
	canvas.rotate(1);
	canvas.fillText("after rotation", 60, 10);
	
	canvas.restore();
	canvas.fillText("after restoring!", 10, 30);
	
}


window.addEventListener('load', doFirst, false);