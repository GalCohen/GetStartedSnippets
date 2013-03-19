<?

if (isset($_POST['contact_name']) && isset($_POST['contact_email']) && isset($_POST['contact_text'])){
 	$contact_name = $_POST['contact_name'];
	$contact_email = $_POST['contact_email'];
	$contact_text = $_POST['contact_text'];
	
	if (!empty($contact_name) && !empty($contact_email) && !empty($contact_text)) {
		$to = 'galcohen26@gmail.com';
		$subject = 'Contact form submitted';
		$body = $contact_name. "\n" .$contact_text;
		$header = 'From: '.$contact_email;
		
		if (strlen($contact_name) > 25 || strlen($contact_email) > 50 || strlen($contact_text) > 1000) {
			echo 'Sorry, maxlength for some field has been exceeded';
		} else{
			if (mail($to, $subject, $body, $headers)) {
				echo 'Thanks for contacting us. We\'ll be in touch soon.';
			}else{
				echo 'Sorry, an error occurred. Please try again later.';
			}
		}
	}else{
		echo 'All fields are required';
	}
}

?>

<form action = "index.php" method = "POST">
	Name: <br> <input type = "text" name = "contact_name" maxlength = "25"> <br <br>
	Email Address: <br> <input type = "text" name = "contact_email" maxlength = "50"><br><br>
	Message: <br>
	<textarea name = "contact_text" rows = "6" cols "30" maxlength = "1000"> </textarea> <br>
	<input type = "submit" value= "Send">
</form>

