<?php

if (isset($_POST['name'])) {
	echo $name = $_POST['name'];
	
	
	if (!empty($name)){
		
		$handle = fopen('names.txt', 'a');
		fwrite($handle, $name."\n");
		fclose($handle);
		
		$count = 0;
		$readin = file('names.txt');
		$readin_count = count($readin);
		
		echo 'current names in file: ';
		
		foreach($readin as $fname){
			echo trim($fname);
			$count++;
			if ($count != $readin_count){
				echo ', ';
			}
			
		}
		
	}else {
			echo 'please type a name.';
	}
		
	
}	

?>


<form action = "file2.php" method= "POST"> <br>
	Name:  <input type = "name" name = "name" <br><br>
		<input type = "submit" value = "Submit">
</form>