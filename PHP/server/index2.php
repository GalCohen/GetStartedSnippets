<?

$ip_address = $_SERVER['REMOTE_ADDR'];

echo $ip_address;

$ip_blocked = array('127.0.0.1', '100.100.100.100');


foreach($ip_blocked as $ip){
	
	echo $ip.'<br>';
	
	if ($ip == $ip_address){
		die('Your IP address, '.$ip. ' has been blocked!');
	}

}

?>


<h1> welcome </h1>