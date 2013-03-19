
<?

if (isset($_POST['text']) && isset($_POST['searchfor']) && isset($_POST['replacewith'])) {
	$text = $_POST['text'];
	$search = $_POST['searchfor'];
	$replace = $_POST['replacewith'];
	
	$search_length = strlen($search);

	if (!empty($text) && !empty($search) && !empty($replace)){
		$offset = 0;
		
		while($strpos = strpos($text, $search, $offset)){
			//substr_replace($text, $search, $replace);
			echo $strpos.'<br>';
			echo $offset = $strpos + $search_length.'<br>';
			
			$text = substr_replace($text, $replace, $strpos, $search_length);
		}
	
		echo $text;
		
	}else{
		echo 'please fill in all fields.';
	}
	
}

?>



<form action= "findandreplace.php" method = "POST">
	<textarea name = "text" rows = "6" cols = "30"> </textarea><br><br>
	Search for: <br>
	<input type = "text" name = "searchfor"><br><br>
	Replace with: <br>
	<input type = "text" name = "replacewith"> <br><br>
	<input type = "submit" name = "Find and Replace"> <br><br>
</form>
