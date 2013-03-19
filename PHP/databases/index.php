<?php
require 'connect.inc.php';
?>

<form action = "index.php" method = "GET" >
	<select name = "uh">
		<option value = "u"> Unhealthy </option>
		<option value = "h"> Healthy </option>		
	</select> <br><br>
	<input type = "submit" value = "Submit">
</form>


<?

if (isset($_GET['uh']) && !empty($_GET['uh'])){

	$uh = strtolower($_GET['uh']);

	if ($uh == 'u' || $uh = 'h'){
	
		
	
		//$query = "SELECT `food`, `calories` FROM `food` ORDER BY `id` DESC";
		$query = "SELECT `food`, `calories` FROM `food` WHERE `Heathly_Unhealthy`='$uh' ORDER BY `id` DESC";
		
		//$query_run = mysql_query($query);
		
		if ($query_run = mysql_query($query)) {
			echo 'Query success <br>';
			
			if (mysql_num_rows($query_run) == NULL){
				echo 'no results found.';
			}else{
			
				while ($query_row = mysql_fetch_assoc($query_run)){
				//mysql_fetch_assoc($query_run);
						$food = $query_row['food'];
						$calories = $query_row['calories'];
						echo $food.': '.$calories.'<br>' ;
				}
			}
		}else{
			echo 'Query failed';
		}
	}else{
		echo 'must be u or h';
	}
}

?>