<?php

class BankAccount {
	public $balanceOfAccount = 3500;
	
	public function DisplayBalance(){
		return $this->balance;
	}
}


$joe = new BankAccount;
echo $joe->DisplayBalance();



?>