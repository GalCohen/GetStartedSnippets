function getStuff(){
    
	//only returns the first occurence
	//document.querySelector('#tuna').onclick=talk;
	
	var list = document.querySelectorAll("#tuna");
	
	//list[1].onclick=talk;
	for (var i = 0; i < list.length; i++){
		list[i].onclick=talk;	
	}
}

function talk(){
	alert('yoyoma!');
}

window.onload = getStuff;