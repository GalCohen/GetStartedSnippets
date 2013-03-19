<?php

$filename = 'namesforfile3php.txt';
$handle = fopen($filename, 'r');

$datain = fread($handle, filesize($filename));

$names_array = explode(',', $datain);

foreach($names_array as $name) {
	echo $name.'<br>';
}



?>