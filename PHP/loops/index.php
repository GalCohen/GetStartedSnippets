<?php

$counter = 1;

while ($counter != 10) {
	echo 'Hello '.$counter.'  <br>'; 

	$counter++;
}



do {
	echo 'Hello'.$counter.' ';

	$counter++;
}while ($counter != 15);

echo '<br>';




$var = 0;

for ($var = 0; $var <= 10; $var++){
	echo $var. '<br>';
}

?>