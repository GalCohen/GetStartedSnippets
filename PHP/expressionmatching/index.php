<?

$string = 'This igs a string';


if (preg_match('/AA/', $string)){
	echo 'match found';
}else{
	echo 'match not found';
}



//============================================================
echo '<p></p>';
echo '<p></p>';
echo '<p></p>';
//===========================================================


function has_space($string) {
	if (preg_match('/ /', $string)){
		return true;
	}else{
		return false;
	}
}



$string = 'thishasstringhasnospaces';


if (has_space($string)) {
	echo 'Has at least one space.';
}else{
	echo ' has no spaces';
}



?>