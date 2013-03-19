function doFirst(){
	var x = document.getElementById('canvas');
	
	canvas = x.getContext('2d');
	
	//canvas.strokeRect(10, 10, 100, 200);
	
	canvas.fillRect(150, 150, 100, 200);
	
	//canvas.clearRect(20, 20, 50, 90);
}

window.addEventListener('load', doFirst, false);