<?php

 echo $name = $_FILES['file']['name'];
 echo '<br>';
 echo $type = $_FILES['file']['type'];
 echo '<br>';
 echo $extension = strtolower( substr($name, strpos($name, '.') + 1) ); 
 echo '<br>';
 
 echo $size = $_FILES['file']['size'];
 $max_size = 2097152;

 $tmp_name = $_FILES['file']['tmp_name'];

 echo '<br>';

 if (isset($name)){
 	if (!empty($name) ){
 		$location = 'uploads/';
 		
 		if (($extension == 'jpg' || $extension == 'jpeg') && $type == 'image/jpeg' && $size<=$max_size)  {
 			if ( move_uploaded_file($tmp_name, $location.$name)) {
 		
 				echo 'file uploaded!';
 			}else {
 				'There was an error';
 			}
 		}else{
 			echo 'error?';
 		}
 		
 	}else{
 		echo 'Please choose a file';
 	}
 }	

?>

<form action = "upload.php" method = "POST" enctype = "multipart/form-data">
	<input type = "file" name = "file"> <br> <br>
	<input type = "submit" value = "Submit" >
</form>