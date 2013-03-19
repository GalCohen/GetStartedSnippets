<?php

$handle = fopen('names.txt', 'w');

fwrite($handle, 'hello');
fwrite($handle, 'billy');

fclose($handle);

echo 'Written';


?>