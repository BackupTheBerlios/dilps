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
 * image processor
 * --------------------------------------------------------------------
 * File:     			image_exchange.php
 * Purpose:  			exchange the currently stored image with another
 *						one that is uploaded via browser upload
 * Requires:			file, identify and convert (imagemagick)
 * ---------------------------------------------------------------------
 */

/*
ini_set('display_errors',1);
error_reporting(E_ALL);
*/

// import standard libraries and configuraiton values
include_once('includes.inc.php');

// import helper functions
include($config['includepath'].'tools.inc.php');

global $db, $db_prefix, $user;

global $resolutions_available;
global $formats_available;
global $formats_suffix;
global $imagemagick_identify;
global $imagemagick_convert;
global $file_binary;

// read sessiond id from get/post
if (isset($_REQUEST['PHPSESSID'])) {
	$sessionid = $_REQUEST['PHPSESSID'];
}
else
{
	$sessionid = '';
}

if (!empty($_REQUEST['query'])) {
	$query 			= $_REQUEST['query'];
}
else {
	die ('No query string given');
}

if (isset($query['id'])) {
	extractID( $query['id'], $collectionid, $imageid );
}
else {
	die ('No id given');
}

if (isset($query['process']))
{
	$process 	= $query['process'];
}
else {
	$process 	= 1;
}

// $db->debug = true;

$sql = "SELECT filename, {$db_prefix}img.img_baseid as baseid, base, host FROM {$db_prefix}img,{$db_prefix}img_base WHERE {$db_prefix}img.imageid=".intval($imageid)
    		." AND {$db_prefix}img.collectionid=".intval($collectionid)
    		." AND {$db_prefix}img.collectionid={$db_prefix}img_base.collectionid"
    		." AND {$db_prefix}img.img_baseid={$db_prefix}img_base.img_baseid";
    	
$row =	$db->GetRow( $sql );
$base = $row['base'];

if( $base != '' && $base{strlen($base)-1} != DIRECTORY_SEPARATOR )
{
	$base .= DIRECTORY_SEPARATOR;
}

$baseid	= $row['baseid'];
$host	= $row['host'];

$debug = false;

if ($debug)
{
	echo ("REQUEST: \n<br>\n");
	print_r($_REQUEST);
	echo ("\n<br><br>\n");
	echo ("FILES: \n<br>\n");
	print_r($_FILES);
	echo ("\n<br><br>\n");
	echo ("FILES['query']: \n<br>\n");
	$tmp = $_FILES['query'];
	print_r($tmp);
	echo ("\n<br><br>\n");
	echo ("Source-Dir: \n<br>\n");
	$file = $tmp['tmp_name']['sourcedirectory'];
	print_r($file);
	echo ("\n<br><br>\n");
}


if ($process == 2) {

	// The output when processing images is done in plain-html

	echo ('<html>');
	echo ('<head>');
	echo ('<meta name="robots" content="index,follow">');
	echo ('<meta http-equiv="pragma" content="no-cache">');
	echo ('<meta http-equiv="expires" content="0">');
	echo ('<meta http-equiv="cache-control" content="no-cache">');
	echo ('<meta name="keywords" content="Bilddatenbanksystem, Bilddatenbank, Diathek, digitalisiert">');
	echo ('<meta http-equiv="Content-Type" content="text/html; charset=utf-8">');
	echo ('<meta http-equiv="Content-Script-Type" content="text/javascript">');
	echo ('<meta http-equiv="Content-Style-Type" content="text/css">');
	echo ('<meta name="author" content="Sebastian Doeweling"> ');
	echo ('<meta name="date" content="2003-01-23">');
	echo ('<link rel="shortcut icon" href="favicon.ico">');
	echo ('<title>. : DILPS : .</title>');
	echo ('<link rel="stylesheet" type="text/css" href="css.php">');
	echo ('</head>');
	echo ('<body class="main">');
	echo ("<table class='header' width='100%'>\n");
	echo ("<tr>\n<td class='result_list'>\n");
	echo ("<b>Adding Images - Started</b>\n<br>\n");

	// this is for single uploaded files

	if (!($userfilename = $_FILES['query']['name']['sourcedirectory'])) {
		$errorstring = "Error uploading file! \n";
		$errorstring .= "File: ".$userfilename." \n";

		echo ($errorstring);
		exit;
	}

	$filename = $_FILES['query']['tmp_name']['sourcedirectory'];

	$mimetype = '';

	$userfileext = '';

	$dotpos = strrpos($userfilename,'.');

	if ((strlen($userfilename) - $dotpos) > 3 && (strlen($userfilename) - $dotpos) < 6)
	{
		$userfileext = strtolower(substr($userfilename,$dotpos+1));
	}

	$ret = read_mime($filename, $mimetype, $userfileext);

	if (!$ret)
	{
		$errorstring = "Error reading image mimetype! \n<br>\n";
		$errorstring .= "File:".$userfilename."\n<br>\n";
		echo ($errorstring);
	}
	else
	{
		echo ("Mimetype: ".$mimetype."\n<br>\n");

		if (in_array($mimetype,$formats_available)){

			// extract image information

			// we already have the mimetype
			$img_data = array();
			$img_data['mime'] = $mimetype;

			// try to read the rest

			$ret = read_image($filename,$img_data);

			if (!$ret)
			{
				$errorstring = "Error reading image information! \n<br>\n";
				$errorstring .= "File:".$userfilename."\n<br>\n";
				echo ($errorstring);
			}
			else
			{
		 		echo ("Type:\t\t".$img_data["type"]."\n<br>\n");
		 		echo ("Width:\t\t".$img_data["width"]."\n<br>\n");
		 		echo ("Height:\t\t".$img_data["height"]."\n<br>\n");

				// get output directory
				$baseid 		= 	$query['baseid'];
				$sql 			= 	"SELECT base FROM ".$db_prefix."img_base WHERE img_baseid="
									.$db->qstr($baseid);
				$output_dir 	= 	$db->GetOne($sql);

				if (empty($output_dir))
				{
					$errorstring = "Error reading output directory! \n<br>\n";
					$errorstring .= "BaseID: ".$baseid."\n<br>\n";
					$errorstring .= "Directory: ".$output_dir."\n<br>\n";
					die ($errorstring);
				}								

				// use a temporary directory, where we can store the converted files until we have
				// completed the task for all resolutions. 
				// we will move files from there into the correct directory later
				
				$tmpdir		= $config['imageTmp'];

				if (!is_dir($tmpdir))
				{
					$errorstring = "Could not find temporary directory! \n<br>\n";
					$errorstring .= "Path: ".$tmpdir."\n<br>\n";
					die ($errorstring);
				}
				
				// check if we already have a cache directory structure, otherwise create

				$ret = check_dir($tmpdir.DIRECTORY_SEPARATOR.'cache'.DIRECTORY_SEPARATOR,true,true,0755);

				if (!$ret)
				{
					$errorstring = "Temporary directory cache does not exist or is not writable! \n<br>\n";
					die ($errorstring);
				}
				
				// generate image in all necessary resolutions
				// you can skip resolutions by changing the array at this point
						
				$resolutions = $resolutions_available;
				
				foreach ($resolutions as $res)
				{
					$ret = check_dir($tmpdir.DIRECTORY_SEPARATOR.'cache'.DIRECTORY_SEPARATOR.$res,true,true,0755);
					if (!$ret)
					{
						$errorstring = "Error creating temporary directory cache for resolution: {$res}! \n<br>\n";
						die ($errorstring);
					}
				}
				
				
				// assign temporary id - randomized from 0 to 2**20
				
				srand((double)microtime()*1000000);
				$tmpid 		= rand(0,1048576);							
				
				
				// carry out conversion steps
				
				echo ("\n<br>\n<em>Generating image versions for all resolutions:</em>\n<br><br>\n");
				
				if ($config['imagick_mode'] == 'fast')
				{
					$ret = convert_image_batch($filename,$tmpdir.'cache',$tmpid,$resolutions);

					if ($ret)
					{
						echo ("Generating images (batch mode)\t\t\t: success\n<br>\n");
						$convert_success = true;
					}
					else
					{
						echo ("Generating images (batch mode)\t\t\t: failed\n<br>\n");
						echo ("Aborting...\n<br>\n");
						$convert_success = false;
					}	
				}
				else 
				{
					
					// convert image to JPG at 1600x1200 as a base for the following conversion
					
					$baseimage_filename = $tmpdir.'cache'.DIRECTORY_SEPARATOR.$tmpid.'.jpg';
					
					$res = '1600x1200';
					
					$ret = convert_image($filename,$baseimage_filename,$res, false);
					
					if ($ret)
					{
						echo ("Generating base image\t\t\t: success\n<br>\n");
						$convert_success = true;
					}
					else
					{
						echo ("Generating base image\t\t\t: failed\n<br>\n");
						echo ("Aborting...\n<br>\n");
						$convert_success = false;
					}
					
					// the following lines will generate a JPG-version of your original image
					// uncomment them, if you need it (requires additional computation time)
					
					/*
					if ($convert_success)
					{
						$output_filename = $tmpdir.'cache'.DIRECTORY_SEPARATOR.$tmpid.'.jpg';
					
						$res = $img_data['width'].'x'.$img_data['height'];
					
						$ret = convert_image($filename,$output_filename,$res, false);
					
						if ($ret)
						{
							echo ("Writing (".$res.")\t\t\t: success\n<br>\n");
							$convert_success = true;
						}
						else
						{
							echo ("Writing (".$res.")\t\t\t: failed\n<br>\n");
							echo ("Aborting...\n<br>\n");
							$convert_success = false;
						}
					}
					*/								
				
					if ($convert_success)
					{					
						
						foreach ($resolutions as $res)
						{

							$ret = check_dir($tmpdir.'cache'.DIRECTORY_SEPARATOR.$res,true,true, 0755);

							// check if cache subdirectories exist
							if (!$ret)
							{
								$errorstring = "Error creating directory for resolution ".$res."\n<br>\n";
								$errorstring .= "or directory exists and is not writable\n<br>\n";
								die ($errorstring);
							}

							if ($res == '120x90')
							{
								$is_thumbnail = true;
							}
							else
							{
								$is_thumbnail = false;
							}

							$output_filename = $tmpdir.'cache'.DIRECTORY_SEPARATOR.$res.DIRECTORY_SEPARATOR.$tmpid.'.jpg';

							$ret = convert_image($baseimage_filename,$output_filename,$res, $is_thumbnail);

							if ($ret)
							{
								echo ("Writing (".$res.")\t\t\t: success\n<br>\n");
								$convert_success = true;
							}
							else
							{
								echo ("Writing (".$res.")\t\t\t: failed\n<br>\n");
								echo ("Aborting...\n<br>\n");
								$convert_success = false;
						 		break;
							}
						}
					}
				}
					
				if ($convert_success)
				{
					
					// we have all necessary files now, so we get a correct id and move the files
					//
					// in unlikely cases this section will cause trouble, i.e. when someone gets
					// a new id while we are copying and before we insert into the database
					
					echo ("\n<br>\n<em>Copying generated image versions to their correct locations:</em> \n<br><br>\n");
					
					// check if we already have a cache directory structure, otherwise create

					$ret = check_dir($output_dir.DIRECTORY_SEPARATOR.'cache'.DIRECTORY_SEPARATOR,true,true,0755);

					if (!$ret)
					{
						$errorstring = "Output directory cache does not exist or is not writable! \n<br>\n";
						die ($errorstring);
					}
					
					// use old id here

					$newid 		= $imageid;
					
					// iterate through all available resolutions and check whether the target directory exists
					// if yes, move the corresponding file, otherwise abort.
					
					foreach ($resolutions as $res)
					{	
						$ret = check_dir($output_dir.DIRECTORY_SEPARATOR.'cache'.DIRECTORY_SEPARATOR.$res,true,true, 0755);

						// check if cache subdirectories exist
						if (!$ret)
						{
							$errorstring = "Error creating directory for resolution ".$res."\n<br>\n";
							$errorstring .= "or directory exists and is not writable\n<br>\n";
							die ($errorstring);
						}
						
						$tmp_filename = $tmpdir.'cache'.DIRECTORY_SEPARATOR.$res.DIRECTORY_SEPARATOR.$tmpid.'.jpg';
							
						$output_filename = $output_dir.DIRECTORY_SEPARATOR.'cache'.DIRECTORY_SEPARATOR.$res.DIRECTORY_SEPARATOR.$collectionid.'-'.$newid.'.jpg';

						$ret = @copy($tmp_filename,$output_filename);
						
						if ($ret)
						{
							echo ("Writing (".$res.")\t\t\t: success\n<br>\n");
							$convert_success = true;
						}
						else
						{
							echo ("Writing (".$res.")\t\t\t: failed\n<br>\n");
							echo ("Aborting...\n<br>\n");
							$convert_success = false;
					 		break;
						}
						
						// if unlink fails, we just loose some disk space
						@unlink($tmp_filename);	
					}
					
					// if you decided to enable JPG-Versions in original resolution,
					// uncomment the following lines to copy them to the target
					// directory
					
					/*
					// copy the JPEG version with original resolution
					if ($convert_success)
					{
						$tmp_filename = $tmpdir.'cache'.DIRECTORY_SEPARATOR.$tmpid.'.jpg';
																
						$output_filename = $output_dir.DIRECTORY_SEPARATOR.'cache'.DIRECTORY_SEPARATOR.$collectionid.'-'.$newid.'.jpg';

						$ret = @copy($tmp_filename,$output_filename);
						
						$res = $img_data['width'].'x'.$img_data['height'];

						if ($ret)
						{
							echo ("Writing (".$res.")\t\t\t: success\n<br>\n");
							$convert_success = true;
						}
						else
						{
							echo ("Writing (".$res.")\t\t\t: failed\n<br>\n");
							echo ("Aborting...\n<br>\n");
							$convert_success = false;
						}
						
						// if unlink fails, we just loose some disk space
						@unlink($tmp_filename);	
					}			
					*/
					
					if ($config['imagick_mode'] != 'fast')
					{
					
						// try to delete temprorary base image
						// if unlink fails, we just loose some disk space
						@unlink($baseimage_filename);	
					}

					if ($convert_success)
					{
						
						// all generated versions copied, so we try to move the uploaded original
						
						$newfilename = $collectionid.'-'.$newid.'.'.$formats_suffix[$img_data["mime"]];

						$source = $filename;
						$dest = $output_dir.DIRECTORY_SEPARATOR.$newfilename;

						// this will give a warning (which we suppress), but work in the end
						$ret = @move_uploaded_file($source,$dest);							

						if (!$ret)
						{
							echo ("Moving uploaded original image\t: failed\n<br>\n");
							echo ("Aborting...\n<br>\n");
						}
						else
						{
							echo ("Moving uploaded original image\t: success\n<br>\n");

							// set permissions
							$ret = @chmod($output_dir.DIRECTORY_SEPARATOR.$newfilename,0755);

							if (!$ret)
							{
								echo ("Modyfing permissions\t: failed\n<br>\n");
							}
							else
							{
								echo ("Modyfing permissions\t: success\n<br>\n");
							}

							// update filename and image data in database

							// get current time
							$sql =	"SELECT NOW()";
							$time = $db->GetOne($sql);

							$ret = update_img($collectionid,$newid,$baseid,$userfilename,$img_data,$time);

							if (!$ret)
							{
								echo ("Updating database (image)\t\t\t: failed\n<br>\n");
								echo ("Aborting...\n<br>\n");
							}
							else
							{
								echo ("Updating database (image)\t\t\t: success\n<br>\n");

							}

							// end of actions - output a newline
							echo ("\n<br>\n");

						}
					}
				}									
			}
	 	}
	}

	echo ("\n<br>\n<em>Exchanging image - done</em>\n");
	echo ("<br>\n<br>\n");
	echo ('<a href="javascript:opener.document.forms[0].submit();window.close();" class="navigationlink">Close window</a>');

	echo ("</td>\n</tr>\n</table>");
	echo ('</body>');
	echo ('</html>');

} 
else {
	
    $smarty->assign('collectionid',$collectionid);
    $smarty->assign('imageid',$imageid);
    $smarty->assign('baseid',$baseid);
    $smarty->assign('host',$host);
    $smarty->assign('base',$base);

	$smarty->assign('sessionid',$sessionid);
	$smarty->display( $config['skin'].DIRECTORY_SEPARATOR.'image_exchange.tpl' );

}

//phpinfo();
?>
