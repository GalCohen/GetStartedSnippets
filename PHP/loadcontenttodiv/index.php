<html>
<header>

<script type ="text/javascript">

function load(thediv, thefile){
	//alert('works');
	//document.write('hello!');
	
	if (window.XMLHttpRequest){
		xmlhttp = new XMLHttpRequest();
	}else{
		xmlhttp = new ActiveXObject('Microsoft.XMLHTTP');
	}
	
	xmlhttp.onreadystatechange = function() {
		if(xmlhttp.readyState == 4 && xmlhttp.status == 200){
			document.getElementById(thediv).innerHTML = xmlhttp.responseText;
		}
	}
	
	xmlhttp.open('GET', thefile, true);
	xmlhttp.send();
}

</script>

</header>

<body>

<input type ="submit" onclick="load('adiv', 'include.inc.php');">

<div id="adiv"></div>

</body>
</html>

