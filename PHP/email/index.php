<?php

 $to = 'galcohen26@gmail.com';
 $subject = 'This is an email';
 $headers = 'From: someone@test.com';
 $body = 'This is a test email\n\ hope you got it';
 
 if (mail($to, $subject, $body, $header)) {
 	echo 'Email has been sent to '.$to;
 } else {
 	echo 'There was an error sending the email';
 }

?>