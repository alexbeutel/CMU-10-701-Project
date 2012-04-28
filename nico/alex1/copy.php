<?php

for($i = 1; $i < 100; $i++) {
	exec("cp image".($i*200).".jpg occasional/nico".$i.".jpg");
}


?>
