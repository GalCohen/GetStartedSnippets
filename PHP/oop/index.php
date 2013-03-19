<?

class BankAccount {
	 public $balance = 0;
	//public - can be accessed anywhere inside the code
	//protected - can be accessed anywhere inside the class
	//private - can't be accessed outside of the class 
	
	public function DisplayBalance(){
		return 'Balance:'.$this->balance;
	}
	
	
	public function Withdraw($amount){
		if (($this->balance) < $amount) {
			echo 'not enough money';
		}else{
			$this->balance-= $amount;
		}
	}
	
	
	public function Deposit($amount){
		$this->balance = $this->balance + $amount;
	}
	
}

class SavingsAccount extends BankAccount {
		public $type = '18-25';
}
	



$bob = new BankAccount();
$bob->balance = 5;
echo $bob->DisplayBalance();




echo '<br>';
$bob->Withdraw(3);
echo $bob->DisplayBalance();




echo '<br>';
$bob->Deposit(100);
$bob->Withdraw(50);
echo $bob->DisplayBalance();
echo '<br>';




$joe = new BankAccount;
$joe->Deposit(55);
$joe->Withdraw(15);
echo 'Joe\'s balance:'.$joe->DisplayBalance().'<br>';
echo 'Bob\'s balance:'.$bob->DisplayBalance().'<br>';



/* ----------------------- */
echo '<br>';
$bob_savings = new SavingsAccount();
$bob_savings->Deposit(2222);
$bob_savings->Withdraw(222);
echo 'Bob\'s savings account '.$bob_savings->DisplayBalance();

echo '<br>';
echo $bob_savings->type;


?>