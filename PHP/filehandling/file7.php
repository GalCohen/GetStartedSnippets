<?php

$filename = 'filetodelete.txt';

if ( unlink($filename) ){
	echo 'File <strong>' .$fileanme. '</strong> has been deleted.';
}else{
	echo 'file cannot be deleted.';
}


$filename = 'filetorename.txt';
$rand = rand(10000, 99999);

if ( rename($filename, $rand.'.txt') ){
	echo 'File ' .$fileanme. ' has been renamed to <strong>'.$rand.'.txt </strong>' ;
}else{
	echo 'file cannot be renamed.';
}

?>