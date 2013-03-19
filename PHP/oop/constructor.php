<?php

class Example {
	public function __construct($something) {
		$this->SaySomething($something);
	}
	
	public function SaySomething($something) {
		echo $something;
	}
	
	
	
}


$example = new Example('some text here');
?>