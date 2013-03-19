<?

//echo md5('pass123');

require 'connect.inc.php';
require 'core.inc.php';



//echo $current_file;
//echo $_SESSION['user_id'];

if (loggedin()){
	$firstname = getuserfield('firstname');
	$surname = getuserfield('surname');
	echo 'youre logged in, '.$firstname.' '.$surname.' <a href="logout.php"> Log out </a>';
	
}else{
	include 'loginform.inc.php';
}



?>