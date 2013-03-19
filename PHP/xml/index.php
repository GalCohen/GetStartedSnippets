<?php

$xml = simplexml_load_file('example.xml');

//echo $xml->producer[1]->name.$xml->producer[1]->age;

echo '<br>';

foreach ($xml->producer as $producer) {
	echo $producer->name. ' ('.$producer->age.')<br> ';
	
	foreach ($producer->show as $show) {
		echo $show->showname.' on '.$show->showdate.'<br>';
	}
}

?> 