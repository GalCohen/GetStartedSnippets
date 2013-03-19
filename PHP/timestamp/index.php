<?

//echo 'current time is '. time();

$time = time();

$actual_time = date('D M Y @ H:i:s', $time);

echo 'current date/time is '. $actual_time;



echo '<p></p>';



//  MODIFIED TIME STAMPS


$time_now = $actual_time = date('D M Y @ H:i:s', $time);
$time_modified = date('D M Y @ H:i:s',  strtotime('+1 week') );

echo 'The time now is '.$time_now.'<br> The time modified is ' .$time_modified;
echo '<p></p>';
echo $actual_time;

?>