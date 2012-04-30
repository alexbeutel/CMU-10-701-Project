<?php

$points = 2000;
$startFrame = 30;
$lastFrame = 80;
$step = 5;
$window = 3;

$dir = "../nico/movement1/pgm/";


function myexec($s) {
	echo $s."\n";
	exec($s);
}

$cnt = 0;
for($i = $startFrame; $i < $lastFrame; $i += $step) {

	$sf = $i;
	$ef = min($lastFrame, $sf + $step * $window -1);

	myexec("./kltrun ".$dir."image -fmt %d -sf ".$sf." -ef ".$ef." -np ".$points);
	myexec("rm -rf ".$dir."window".$cnt);
	myexec("mkdir ".$dir."window".$cnt);
	myexec("mv ".$dir."*.txt ".$dir."window".$cnt."/");  
	myexec("mv ".$dir."*.ppm ".$dir."window".$cnt."/");  

	$cnt++;
}


?>
