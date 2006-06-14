<?php
/*
   +----------------------------------------------------------------------+
   | DILPS - Distributed Image Library System                             |
   +----------------------------------------------------------------------+
   | Copyright (c) 2002-2004 Juergen Enge                                 |
   | juergen@info-age.net                                                 |
   | http://www.dilps.net                                                 |
   +----------------------------------------------------------------------+
   | This source file is subject to the GNU General Public License as     |
   | published by the Free Software Foundation; either version 2 of the   |
   | License, or (at your option) any later version.                      |
   |                                                                      |
   | Distributed Playout Infrastructure is distributed in the hope that   |
   | it will be useful,but WITHOUT ANY WARRANTY; without even the implied |
   | warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.     |
   | See the GNU General Public License for more details.                 |
   |                                                                      |
   | You should have received a copy of the GNU General Public License    |
   | along with this program; if not, write to the Free Software          |
   | Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA            |
   | 02111-1307, USA                                                      |
   +----------------------------------------------------------------------+
*/

/*
 * global configuration data
 * -------------------------------------------------------------
 * File:     			globals.inc.php
 * Purpose:  	global configuration data that is not 
 * 					handled in the DILPS-Installer
 * -------------------------------------------------------------
 */
    //error_reporting(E_ALL);
    error_reporting(0);
    
	// activate compatibility mode
	ini_set( 'zend.ze1_compatibility_mode', 'On' );
	
	// configuration for group exports - set when we have values from db
	
	if (isset($config['exportdir']) && isset($config['dilpsdir']))
	{
		$exportdir 			= substr($config['exportdir'],strlen($config['dilpsdir']),strlen($config['exportdir']));
		$exportdirlong 	= $config['exportdir'];		
		$dilpsdir 				= $config['dilpsdir'];
		
		// $exporturl 			= 'http://'.$_SERVER['SERVER_NAME'].'/'.$exportdir;
	}
	
	// configure editor and admin-group
	
	$config['admingroup'] = 'archivmaster';
	$config['editorgroup'] = 'archiveditor';	
	
	// available resolutions for
	$resolutions_available = array (
		"0"	=>	"120x90",
		"1"	=>	"640x480",
		"2"	=>	"800x600",
		"3"	=>	"1024x768",
		"4"	=>	"1280x1024",
		"5"	=>	"1600x1200"
	);
	
	$formats_available = array (
		"0"	=>	"image/jpeg",
		"1"	=>	"image/png",
		"2"	=>	"image/gif",
		"3"	=>	"image/tiff",
		"4"	=>	"image/x-photoshop",
		"5"	=>	"image/x-ms-bmp",
		"6"	=>	"image/bmp"
	);
	
	$formats_suffix = array (
		"image/jpeg"				=>	"jpg",
		"image/png"				=>	"png",
		"image/gif"					=>	"gif",
		"image/tiff"					=>	"tif",
		"image/x-photoshop"	=>	"psd",
		"image/x-ms-bmp"		=>	"bmp",
		"image/bmp"				=>	"bmp"
	);
	
	$ext_to_mime = array (
		"jpg"		=>	"image/jpeg",
		"jpeg"	=>	"image/jpeg",	
		"png"	=>	"image/png",
		"gif"		=>	"image/gif",
		"tif"		=>	"image/tiff",
		"tiff"		=>	"image/tiff",
		"psd"	=>	"image/x-photoshop",
		"bmp"	=> 	"image/bmp"
	);	
	
	function __autoload( $className )
	{
			global $config;
			include_once( $config['includepath']."$className.class.php" );
	}

?>