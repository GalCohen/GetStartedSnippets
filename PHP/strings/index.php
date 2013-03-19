


<form action = "index.php" method = "GET">
	Name: <input type = "text" name = "user_name"> <br><br>
	<input type  ="submit" value = "Submit">
</form>





<?



// STRING LENGTH  
$string = 'alex';

$string_length = strlen($string);

//echo $string_length;

for ($x = 0; $x < $string_length; $x++ ) {
	
	echo $x .'<br>';
	
}

echo '<p></p>';




// UPPER LOWER CASE CONVERSION

$string = 'I could be any case';

$string_lower = strtolower($string);
$string_upper = strtoupper($string);

echo $string_lower;
echo '<br>';
echo $string_upper;
echo '<p></p>';
echo '<p></p>';



//READING FROM FORM AND USING THE INFO

if (isset($_GET['user_name'])  && !empty($_GET['user_name'])){
	$user_name = $_GET['user_name'];
	
	$lowercase = strtolower($user_name);
	
	if ($lowercase == 'roy'){
		echo 'you are the best, '.$user_name;
	}else{
		echo 'no';	
	}
	
}

echo '<p></p>';
echo '<p></p>';
echo '<p></p>';
echo '<p></p>';




// STRING POSITIONS

$find = 'is';

$find_length = strlen($find);

$offset = 0;

$string = 'This is a string, and it is an example.';

while ($string_position = strpos($string, $find, $offset)){
	echo $find.' found at '. $string_position.'<br>';
	$offset = $string_position + $find_length;
}






echo '<p></p>';
echo '<p></p>';
echo '<p></p>';
echo '<p></p>';

// REPLACING STRINGS


$string = 'This part don\'t search. This part do search.';

$string_new = substr_replace($string, 'hello', 29, 4);

echo $string_new;

echo '<p></p>';


$find = array('is', 'string', 'example');
$replace = array('IS', 'STRING', '');

$string = 'this is a string. and is an example.';

$new_string = str_replace($find, $replace, $string);

echo $new_string;


echo '<p></p>';
echo '<p></p>';
echo '<p></p>';
echo '<p></p>';



?>