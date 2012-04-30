<?php

$points = 2000;
$startFrame = 30;
$lastFrame = 80;
$step = 5;
$window = 3;

$dir = "../nico/movement1/pgm/";


function alexEcho($s) {
	echo $s."\n";
}

$cnt = 0;
for($i = $startFrame; $i < $lastFrame; $i += $step) {

	$sf = $i;
	$ef = min($lastFrame, $sf + $step * $window);

	exec("./kltrun ".$dir."image -fmt %d -sf ".$sf." -ef ".$ef." -np ".$points);
	exec("rm -rf ".$dir."window".$cnt);
	exec("mkdir ".$dir."window".$cnt);
	exec("mv ".$dir."*.txt ".$dir."window".$cnt."/");  
	exec("mv ".$dir."*.ppm ".$dir."window".$cnt."/");  

	$cnt++;
}


?>
