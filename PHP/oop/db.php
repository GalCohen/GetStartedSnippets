<?

class DatabaseConnect{
	public function __construct($db_host, $db_username, $db_password){
		echo $db_host.'<br>'. $db_username.'<br>'. $db_password.'<br>';
		
		if (!$this->Connect($db_host, $db_username, $db_password)){
			echo 'Connection failed';
		}else if ($this->Connect($db_host, $db_username, $db_password)) {
			echo 'connected to: '.$db_host;
		}
	}
	
	
	public function Connect($db_host, $db_username, $db_password) {
		if (!mysql_connect($db_host, $db_username, $db_password)) {
			return false;
		}else{
			return true;
		}
	}
}


$connect = new DatabaseConnect('localhost', 'root', 'password');

?>