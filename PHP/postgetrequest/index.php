<?
	
/* 
1. does it exis? or "has it been submitted?"
2. is it empty? or "Does value == NULL?"
3. Display back to user
*/

if (isset($_GET['day']) && isset($_GET['date']) && isset($_GET['year']) ){
	$day =  htmlentities( $_GET['day']); // does not allow users to enter html code on the page that can be processed
	$date = htmlentities(  $_GET['date']); // htmlentities is basic security on form submission
	$year = htmlentities(  $_GET['year']);
	
	if (!empty($day) && !empty($date) && !empty($year)){
		echo 'It is '. $day. ', ' .$date. ', '.$year;
	}else{
		echo 'Fill in all fields.';
	}
}
	
?>



<form action = "index.php" method= "GET"> <br>
	Day:  <input type = "text" name = "day" <br><br>
	Date:  <input type = "text" name = "date" <br><br>
	Year: <input type = "text" name = "year" <br><br>
	<input type = "submit" value = "Submit">
</form>
