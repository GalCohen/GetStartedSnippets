<?

function MyName() {
	echo 'Alex';
}


echo 'My Name is <br>' ;
MyName();


echo '<p></p>';

//------------------------------------------


function add($number1, $number2) {
	echo $number1 + $number2;
}


add(5, 7);


//------------------------------------------
echo '<p></p>';


function multiply($var1, $var2){
	$result = $var1 * $var2;

	return $result;
}


echo multiply(4, 5); 



?>