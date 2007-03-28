<?php

// $config['includepath']="/Programme/xampp/htdocs/diathek/include/";

$db_prefix	= 'acqu_';
$db_host	= 'localhost';
$db_user	= 'root';
$db_pwd		= 'db1138';
$db_db		= 'diathek';

$ip_webcam1 = '192.168.178.35';
$ip_webcam2 = '192.168.178.36';

$cfg_videoResolution 	= '320x240';
$cfg_imageResolution 	= '320x240';
$cfg_axisUser 			= 'root';
$cfg_axisPassword 		= 'pass';
    
$cfg_basedir 			= '/Programme/xampp/htdocs/diathek/images';
$cfg_convert 			= '/Programme/ImageMagick/convert.exe';

$cfg_resolutions 		
		= array (
					"0"	=>	"120x90",
					"1"	=>	"640x480",
					"2"	=>	"800x600",
					"3"	=>	"1024x768",
					"4"	=>	"1280x1024"
				);
?>
