<?php

$mysql_host = 'localhost';
$mysql_user = 'rodddot';
$mysql_pass = '';
$mysql_db = 'a_database';

class DatabaseException extends Exception {
	public function showSpecific() {
		return 'Error thrown line '.$this->getLine().' in '.$this->getFile();
	}
}

class ServerException extends Exception {
	public function showSpecific(){
		return 'Error thrown line '.$this->getLine().' in '.$this->getFile();
	}
}



try {
	if (!mysql_connect($mysql_host ,$mysql_user, $mysql_pass )){
		throw new ServerException('Could not connect to server');
		
	}else if (!mysql_select_db($mysql_db)){
		throw new DatabaseException('Could not select database');
		
	}else{
		echo 'Connected';
	}

} catch (serverException $ex){
	echo 'Error: '.$ex->showSpecific();
} catch (DatabaseException $ex) {
	echo 'Error: '.$ex->showSpecific();
}

?>