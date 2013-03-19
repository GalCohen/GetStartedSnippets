<?


/*
$filename_or =  'image.jpg';

$filename = rand(1000, 9999).md5($filename_or).rand(1000, 9999);

echo $filename;
*/


$filename = 'file.txt';

if (file_exists($filename)) {
	echo 'File already exists';
} else{
	$handle  = fopen($filename, 'w');
	fwrite($handle, 'Nothing');
	fclose($handle);
}

?>