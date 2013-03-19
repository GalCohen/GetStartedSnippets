<?

//echo 'helloooo';
//echo $_POST['text'];
 
mysql_connect('localhost', 'root', '');
mysql_select_db('a_database');

if (isset($_POST['text'])){

	$text = $_POST['text'];
	
	if (!empty($text)){
		$query = "INSERT INTO `data` VALUES ('', '".mysql_real_escape_string($text)."')";
		if ($query_run = mysql_query($query)){
			echo 'Data inserted';
		}else{
			echo 'failed.';
		}	
	}else{
		echo 'Please type something.';
	}

}
 
?>