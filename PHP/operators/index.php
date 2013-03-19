<?

$number1 = 10;
$number2 = 5;

echo $result = $number1 + 2;

echo '<p></p>';

echo $number1 += 2; 

echo '<p></p>';

echo $number1 /= 2; 

echo '<p></p>';
//---------------------------------------

$text = 'hello';

$text .= ' world!';

echo $text;

//---------------------------------

echo '<p></p>';

$number1 = 10;
$number2 = 9;

if ($number1 <=  $number2) {   // ==  >=  <=  <>  !=  >  < 
	echo 'yes';
} else{
	echo 'no';
}


//-----------------------------------------
echo '<p></p>';

$sum = 10 + 20;  // +  -  *  /  %  ++  -- 

echo $sum;


echo '<p></p>';
//----------------------------------------------

$number = 8000000;

$upper = 1000;
$lower = 500;

if ($number >= $lower && $number <= $upper ) {      // || &&  AND OR 
	echo 'Ok.';
}else{
	echo 'Number must be between '.$lower.' and '.$upper.', inclusive.';
}




?>