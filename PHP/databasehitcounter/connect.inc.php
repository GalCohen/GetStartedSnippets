<?php

$conn_error = 'could not connect';

$mysql_host = 'localhost';
$mysql_user = 'root';
$mysql_pass = '';

if ( !mysql_connect($mysql_host, $mysql_user, $mysql_pass)  || !mysql_select_db('a_database') ) {
	die($conn_error);	
}else{
	//echo 'connected';
}



?>