<?php

$conn_error = 'could not connect';

$mysql_host = 'localhost';
$mysql_user = 'root';
$mysql_pass = '';

$mysql_db = 'a_database';

if ( !mysql_connect($mysql_host, $mysql_user, $mysql_pass)  || !mysql_select_db($mysql_db) ) {
	die(mysql_error());	
}else{
	//echo 'connected';
}



?>