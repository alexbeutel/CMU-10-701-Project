<?php

$points = 2000;
$step = 5;
$window = 3;


//$startFrame = 30;
//$lastFrame = 80;
//$dir = "../nico/movement1/pgm/";

//$startFrame = 100;
//$lastFrame = 170;
//$dir = "../nico/outdoor3/pgm/";

//$startFrame = 40;
//$lastFrame = 110;
//$dir = "../nico/movement2/pgm/";


//$startFrame = 20;
//$lastFrame = 70;
//$dir = "../nico/movement4/pgm/";


//$startFrame = 10;
//$lastFrame = 60;
//$dir = "../nico/movement5/pgm/";

//$startFrame = 110;
//$lastFrame = 155;
//$dir = "../nico/movement4/pgm/";

//$startFrame = 325;
////$lastFrame = 400;
//$lastFrame = 750;
//$dir = "../nico/upton/pgm/";

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
