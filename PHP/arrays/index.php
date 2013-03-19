<?

$food = array('Pasta', 'pizza', 'salad', 'vegetable');

echo $food[1];

print_r($food);







//associate arrays - associating values to different indeces
echo '<br>';

$food = array('Pasta'=>300, 'pizza'=>1000, 'salad'=>150, 'vegetable'=>50);

print_r($food);
echo '<br>';
echo $food['Pasta'];






// multi-dimentional arrays
echo '<br>';

/*
healthy
salad
vegetable
pasta

unhealth
pizza
ice cream
*/

$food = array('Healthy'=>
			array('salad', 'vegetables', 'pasta'), 
		'Unhealthy'=>
			array('pizza', 'ice cream'));

print_r($food);
echo '<br>';
echo $food['Healthy'][2];
echo '<br>';
echo $food['Unhealthy'][1];
echo '<br>';

echo '<p></p>';
echo '<p></p>';

// FOR EACH STATEMENTS


$food = array('Healthy'=>
			array('salad', 'vegetables', 'pasta'), 
		'Unhealthy'=>
			array('pizza', 'ice cream'));


//used to run through associative arrays

foreach($food as $element => $inner_array) {
	echo '<strong>'.$element. '<br></strong>';

	foreach($inner_array as $item){
		echo $item. '<br>';
	}
}













?>