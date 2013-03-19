function doFirst() {
	mypic = document.getElementById('smile');
	mypic.addEventListener("dragstart", startDrag, false);
	mypic.addEventListener("dragend", endDrag, false);
	
	leftbox = document.getElementById('leftbox');
	
	
	leftbox.addEventListener("dragenter",  dragenter, false);
	
	leftbox.addEventListener("dragleave", dragleave , false);	
	
	leftbox.addEventListener("dragover", function(e) {
		e.preventDefault();	
	}, false);
	
	leftbox.addEventListener("drop", dropped, false);
	
	
	
}



function startDrag(e) {
	var code = '<img src="smiley.jpg" alt="smileypic" id="smile" />';
	
	e.dataTransfer.setData('Text', code);
	
	
}



function dropped(e) {
	e.preventDefault();
	leftbox.innerHTML = e.dataTransfer.getData('Text');
}



function endDrag(e) {
	pic = e.target;
	pic.style.visibility = 'hidden';
}



function dragenter(e) {
	e.preventDefault();
	leftbox.style.background = "SkyBlue";
	leftbox.style.border = "3px solid red";
}



function dragleave(e) {
	e.preventDefault();
	leftbox.style.background = "white";
	leftbox.style.border = "3px solid blue";
}

window.addEventListener('load', doFirst, false);