<?

$string = 'This is an example string.';

$string_word_count = str_word_count($string);

echo $string_word_count;

echo '<br>';







$string_word_count = str_word_count($string, 1); //produce an array with the key equals to the word

print_r( $string_word_count);

echo '<br>';







$string_word_count = str_word_count($string, 1, '.'); //produce an array with the key equals to the word

print_r( $string_word_count);

echo '<br>';






$string = 'this is an example string';
$string_shuffled = str_shuffle($string);

echo $string_shuffled;
echo '<br>';


$half = substr($string_shuffled, 0, strlen($string_shuffled) /2 );

echo $half;
echo '<br>';






$string = 'This is a sample string.';
$string_reversed = strrev($string);

echo $string;
echo '<br>';
echo $string_reversed;
echo '<br>';






$string_one = 'This is my essay. I\'m going to be talking about php. ';

$string_two = 'This is my essay. I will be talking about the subject of php. ';

similar_text($string_one, $string_two, $result);

echo 'The similarity between is, ' .$result;
echo '<br>';




$string = 'This is an example string!';
$string_length = strlen($string);

echo $string_length;
echo '<br>';






$string = '  This is an example string!   ';
$string_trimmed = trim($string);              //gets rid of white space. use rtrim for getting rid of white spaces to right and ltrim for white spaces to left

echo $string_trimmed;




echo '<br>';

$string = 'This is a <img src="image.jpg"> string.';
$string_slashes = addslashes($string);

echo $string_slashes;
echo '<br>';










?>