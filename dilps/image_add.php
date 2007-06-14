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
 * File:     			image_add.php
 * Purpose:  	process and store images that are either
 *						uploaded via FTP or browser-file-transfer,
 *						add the corresponding database entries
 * Requires:		file, identify and convert (imagemagick)
 * ---------------------------------------------------------------------
 */

	/*
	ini_set('display_errors',1);
	error_reporting(E_ALL);
	*/
	
// read sessiond id from get/post
if (isset($_REQUEST['PHPSESSID']))
{
	$sessionid = $_REQUEST['PHPSESSID'];
}
else
{
	$sessionid = '';
}

// import standard libraries and configuraiton values
include_once('includes.inc.php');

// import helper functions
global $config;
include($config['includepath'].'tools.inc.php');

global $db, $db_prefix, $user;

global $resolutions_available;
global $formats_available;
global $formats_suffix;
global $imagemagick_identify;
global $imagemagick_convert;
global $file_binary;

// create personal upload directory for user (if it does not already exist)

$dilps_upload_dir = $config['uploaddir'];
if ($dilps_upload_dir{strlen($dilps_upload_dir)-1} != DIRECTORY_SEPARATOR ) {
	 $dilps_upload_dir .= DIRECTORY_SEPARATOR;
}

if (!isset($user['login']))
{
  $user_upload_dir = 'common';
}
else 
{
  $user_upload_dir = str_replace('/','_',$user['login']);
  $user_upload_dir = str_replace("\\",'_',$user_upload_dir);
}

$dest_dir = $dilps_upload_dir.$user_upload_dir;

$ret = check_dir($dest_dir,true,true,0755);

if (!$ret)
{
	$errorstring = "Error creating personal upload directory for user:".$user['login']."! \n<br>\n";
	die ($errorstring);
}

// check whether this script is called from the java upload applet

if (isset($_REQUEST['javaupload']))
{
	$javaupload = intval($_REQUEST['javaupload']);
}
else
{
	$javaupload = 0;
}

if ($javaupload > 0)
{
  // Uploaddir MUST have a trailing slash.
  $uploaddir = $dest_dir.DIRECTORY_SEPARATOR;
  
  // Whether or not to allow the upload of specific files
  $allow_or_deny = true;
  // If the above is true, then this states whether the array of files is a list of
  // extensions to ALLOW, or DENY
  $allow_or_deny_method = "deny"; // "allow" or "deny"
  $file_extension_list = array("php","asp","pl");
  
  if ($allow_or_deny){
  	if (($allow_or_deny_method == "allow" && !in_array(strtolower(array_pop(explode('.', $_FILES['userfile']['name']))), $file_extension_list))
  		|| ($allow_or_deny_method == "deny" && in_array(strtolower(array_pop(explode('.', $_FILES['userfile']['name']))), $file_extension_list))){		
  		// Atempt to upload a file with a specific extension when NOT allowed.
  		// 403 error
  		header("HTTP/1.1 403 Forbidden");
  		echo "POSTLET REPLY\r\n";
  		echo "POSTLET:NO\r\n";
  		echo "POSTLET:FILE TYPE NOT ALLOWED\r\n";
  		echo "POSTLET:ABORT THIS\r\n"; // Postlet should NOT send this file again.
  		echo "END POSTLET REPLY\r\n";
  		exit;
  	}
  }
  
  // try moving uploaded files
  
  if (move_uploaded_file($_FILES['userfile']['tmp_name'], $uploaddir .$_FILES['userfile']['name']))
  {
  	echo "POSTLET REPLY\r\n";
    echo "POSTLET:YES\r\n";
  	echo "END POSTLET REPLY\r\n";
  	exit;
  } 
  else
  {
  	// If the file can not be uploaded (most likely due to size), then output the
  	// correct error code
  	// If $_FILES is EMPTY, or $_FILES['userfile']['error']==1 then TOO LARGE
  	if (count($_FILES)==0 || $_FILES['userfile']['error']==1){
  		// All replies MUST start with "POSTLET REPLY", if they don't, then Postlet will
  		// not read the reply and will assume the file uploaded successfully.
  		header("HTTP/1.1 413 Request Entity Too Large");
  		echo "POSTLET REPLY\r\n";
  		echo "POSTLET:NO\r\n";
  		echo "POSTLET:TOO LARGE\r\n";
  		echo "POSTLET:ABORT THIS\r\n"; // Postlet should NOT send this file again.
  		echo "END POSTLET REPLY\r\n";
  		exit;
  	}
  	// Unable to write the file to the server ALL WILL FAIL
  	else if ($_FILES['userfile']['error']==6 || $_FILES['userfile']['error']==7){
  		// All replies MUST start with "POSTLET REPLY", if they don't, then Postlet will
  		// not read the reply and will assume the file uploaded successfully.
  		header("HTTP/1.1 500 Internal Server Error");
  		echo "POSTLET REPLY\r\n";
  		echo "POSTLET:NO\r\n";
  		echo "POSTLET:SERVER ERROR\r\n";
  		echo "POSTLET:ABORT ALL\r\n"; // Postlet should NOT send any more files
  		echo "END POSTLET REPLY\r\n";
  		exit;
  	}
  	// Unsure of the error here (leaves 2,3,4, which means try again)
  	else {
  		// All replies MUST start with "POSTLET REPLY", if they don't, then Postlet will
  		// not read the reply and will assume the file uploaded successfully.
  		header("HTTP/1.1 500 Internal Server Error");
  		echo "POSTLET REPLY\r\n";
  		echo "POSTLET:NO\r\n";
  		echo "POSTLET:UNKNOWN ERROR\r\n";
  		echo "POSTLET:RETRY\r\n";
  		print_r($_REQUEST); // Possible usefull for debugging
  		echo "END POSTLET REPLY\r\n";
  		exit;
  	}
  }
}


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

if (!empty($_REQUEST['query']))
{
	$query 			  = $_REQUEST['query'];
	$process 		  = $query['process'];
	$completedir 	= $query['completedir'];
}
else
{
	$query 			= false;
	$process 		= 0;
	$completedir 	= false;
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

	if ($completedir) {

		// get cache directory
		$upload_dir = $config['uploaddir'];
		if ($upload_dir{strlen($upload_dir)-1} != DIRECTORY_SEPARATOR ) {
			$upload_dir .= DIRECTORY_SEPARATOR;
		}
		
		// set source directory to personal user upload directory
		$dir = $dest_dir;

		if(!is_dir($dir)) {
			echo ("No Directory\n<br>\n");
		}

		if ($debug)
		{
			echo "Dir: ".$dir."\n<br\n";
		}

		echo ("<em>Reading directory structure:</em>\n<br>\n<br>\n");

		process_image_directory($dir,$query,false);
	}
	else
	{
		
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
		elseif ($mimetype=="application/x-zip") // extension to handle zip files
		{
			$type = "ZIP";
			
			echo ("Mimetype: ".$mimetype."\n<br>\n");
			echo ("Type: ".$type."\n<br>\n");
			
			// get cache directory
			$upload_dir = $config['uploaddir'];
			
  		if ($upload_dir{strlen($upload_dir)-1} != DIRECTORY_SEPARATOR ) {
  			 $upload_dir .= DIRECTORY_SEPARATOR;
  		}
  		
  		$zip_dir = generate_random_string(16);
  		$dest_dir = $upload_dir.$zip_dir.DIRECTORY_SEPARATOR;
  		
			$ret = check_dir($dest_dir,true,true,0755);
			
			if (!$ret)
			{
				$errorstring = "Could not create temporary directory for archive extraction! \n<br>\n";
				die ($errorstring);
			}
			
			// move_uploaded_file($filename,$dest_dir);
			
			if (!$ret)
			{
				$errorstring = "Could not copy archive to temporary directory! \n<br>\n";
				die ($errorstring);
			}
			
			move_uploaded_file($filename,$dest_dir.'images.zip');
			
			echo ("\n<br>\nUnzipping file\n<br>\n");
						
			// unzip the file
			$cmd = $unzip_binary." -o ".escapeshellarg($dest_dir.'images.zip')." -d ".escapeshellarg(substr($dest_dir,0,strlen($dest_dir)-1));
			exec($cmd,$errors,$ret);
			
			// die("Cmd: ".$cmd."\n<br>n");
			
			echo ("\n<br>\nUnzipping file - done\n");
			
			@unlink($dest_dir.'images.zip');
			
			echo ("\n<br>\n");
			echo ("Reading directory structure:\n<br>\n<br>\n");

			process_image_directory($dest_dir,$query,false);
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
					
					$tmpid 		= generate_random_string();
					
					
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
						
						// get new id for filename

						$sql 		=	"SELECT max(imageid)+1 FROM ".$db_prefix."img";
						$newid 		= $db->GetOne($sql);

						if (!$newid)
						{
							$newid 	= 1;
						}
						
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
								
							$output_filename = $output_dir.DIRECTORY_SEPARATOR.'cache'.DIRECTORY_SEPARATOR.$res.DIRECTORY_SEPARATOR.$query['collectionid'].'-'.$newid.'.jpg';

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
																	
							$output_filename = $output_dir.DIRECTORY_SEPARATOR.'cache'.DIRECTORY_SEPARATOR.$query['collectionid'].'-'.$newid.'.jpg';

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
							
							$newfilename = $query['collectionid'].'-'.$newid.'.'.$formats_suffix[$img_data["mime"]];
	
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
	
								// here our critical section ends, after the next command, the image counter
								// is increased by 1
	
								// get current time
								$sql =	"SELECT NOW()";
								$time = $db->GetOne($sql);
	
								$ret = insert_img($query['collectionid'],$newid,$baseid,$userfilename,$img_data,$time);
	
								if (!$ret)
								{
									echo ("Inserting into database (image)\t\t\t: failed\n<br>\n");
									echo ("Aborting...\n<br>\n");
								}
								else
								{
									echo ("Inserting into database (image)\t\t\t: success\n<br>\n");
	
									$ret = insert_meta($query['collectionid'],$newid,$time,$user['login'],$query['type']);
	
									if (!$ret)
									{
										echo ("Inserting into database (meta)\t\t\t: failed\n<br>\n");
										echo ("Aborting...\n<br>\n");
									}
									else
									{
										echo ("Inserting into database (meta)\t\t\t: success\n<br>\n");
	
										if(!empty($query['group1id']))
										{
											$ret = insert_img_group($query['group1id'],$query['collectionid'],$newid);
	
											if (!$ret)
											{
												// a failed group insertion is non-critical, so we continue
												echo ("Inserting into database (group1)\t\t\t: failed\n<br>\n");														}
											else
											{
												echo ("Inserting into database (group1)\t\t\t: success\n<br>\n");
											}
										}
	
										if(!empty($query['group2id']))
										{
											$ret = insert_img_group($query['group2id'],$query['collectionid'],$newid);
	
											if (!$ret)
											{
												// a failed group insertion is non-critical, so we continue
												echo ("Inserting into database (group2)\t\t\t: failed\n<br>\n");														}
											else
											{
												echo ("Inserting into database (group2)\t\t\t: success\n<br>\n");
											}
										}
	
										if(!empty($query['group3id']))
										{
											$ret = insert_img_group($query['group3id'],$query['collectionid'],$newid);
	
											if (!$ret)
											{
												// a failed group insertion is non-critical, so we continue
												echo ("Inserting into database (group3)\t\t\t: failed\n<br>\n");														}
											else
											{
												echo ("Inserting into database (group3)\t\t\t: success\n<br>\n");
											}
										}
									}
	
									// end of actions - output a newline
									echo ("\n<br>\n");
	
								}
							}
						}									
					}
			 	}
			}
		}
	}

	echo ("\n<br>\n<em>Adding images - done</em>\n");
	echo ("<br>\n<br>\n");
	echo ('<a href="javascript:opener.document.forms[0].submit();window.close();" class="navigationlink">Close window</a>');

	echo ("</td>\n</tr>\n</table>");
	echo ('</body>');
	echo ('</html>');

} else {


	$smarty->assign('sessionid',$sessionid);
	$smarty->display( $config['skin'].DIRECTORY_SEPARATOR.'image_add.tpl' );

}

function process_image_directory ($dir, $query, $debug = false)
{
    global $config;
    global $db, $db_prefix, $user;
    
    global $resolutions_available;
    global $formats_available;
    global $formats_suffix;
    global $imagemagick_identify;
    global $imagemagick_convert;
    global $file_binary,$zip_binary,$unzip_binary;
    
    $files = array();
		$remove = array();

		if (!read_recursive($dir,$files,$remove))
		{
			echo ("Error reading directory structure\n<br>\n");
		}
		else
		{
			if (!empty($dir))
			{
				$offset = strlen($dir) + 1;
			}
			else
			{
				$offset = 0;
			}

			foreach ($files as $num => $val)
			{
				$files[$num] = substr($val,$offset);
			}

			foreach ($remove as $num => $val)
			{
				$remove[$num] = substr($val,$offset);
			}

			usort($remove,"cmp");

			if ($debug)
			{
				echo ("Files: \n<br>\n<br>\n");
				foreach ($files as $num => $val)
				{
					echo ("[".$num."]: ".$val."\n<br>\n");
				}

				echo ("Remove: \n<br>\n<br>\n");
				foreach ($remove as $num => $val)
				{
					echo ("[".$num."]: ".$val."\n<br>\n");
				}
			}

			echo ("Reading directory structure done.\n<br>\n<br>\n");

			foreach ($files as $file)
			{
				echo ("<em>Reading file: ".$file."</em>\n<br>\n");

				if (!empty($dir)){
					$filename = $dir.addslashes(DIRECTORY_SEPARATOR.$file);
				}
				else
				{
					$filename = $file;
				}

				if (is_file($filename)){

					$mimetype = '';

					$fileext = '';

					$dotpos = strrpos($filename,'.');

					if ((strlen($filename) - $dotpos) > 3 && (strlen($filename) - $dotpos) < 6)
					{
						$fileext = strtolower(substr($filename,$dotpos+1));
					}

					$ret = read_mime($filename, $mimetype, $fileext);

					if (!$ret)
					{
						$errorstring = "Error reading image mimetype! \n<br>\n";
						$errorstring .= "File:".$filename."\n<br>\n";
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
								$errorstring .= "File:".$filename."\n<br>\n";
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
								
								// generate temporary id string
								$tmpid 	= generate_random_string();
								
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
									
									// get new id for filename

									$sql 		=	"SELECT max(imageid)+1 FROM ".$db_prefix."img";
									$newid 		= $db->GetOne($sql);
	
									if (!$newid)
									{
										$newid 	= 1;
									}
									
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
											
										$output_filename = $output_dir.DIRECTORY_SEPARATOR.'cache'.DIRECTORY_SEPARATOR.$res.DIRECTORY_SEPARATOR.$query['collectionid'].'-'.$newid.'.jpg';
	
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
																				
										$output_filename = $output_dir.DIRECTORY_SEPARATOR.'cache'.DIRECTORY_SEPARATOR.$query['collectionid'].'-'.$newid.'.jpg';
		
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
										
										// all generated versions copied, so we finally try the original
										
										$newfilename = $query['collectionid'].'-'.$newid.'.'.$formats_suffix[$img_data["mime"]];
	
										$source = $filename;
										$dest = $output_dir.DIRECTORY_SEPARATOR.$newfilename;
	
										$ret = @copy($filename, $output_dir.DIRECTORY_SEPARATOR.$newfilename);
	
										if (!$ret)
										{
											echo ("Copying original image\t: failed\n<br>\n");
											echo ("Aborting...\n<br>\n");
										}
										else
										{
											echo ("Copying original image\t: success\n<br>\n");
	
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
	
											$ret = @unlink($filename);
	
											if (!$ret)
											{
												echo ("Removing uploaded file\t: failed\n<br>\n");
										 	}
											else
											{
												echo ("Removing uploaded file\t: success\n<br>\n");
											}
											echo ("\n<br>\n");
											
											// here our critical section ends, after the next command, the image counter
											// is increased by 1
	
											// get current time
											$sql =	"SELECT NOW()";
											$time = $db->GetOne($sql);
	
											$ret = insert_img($query['collectionid'],$newid,$baseid,$file,$img_data,$time);
	
											if (!$ret)
											{
												echo ("Inserting into database (image)\t\t\t: failed\n<br>\n");
												echo ("Aborting...\n<br>\n");
										 	}
											else
											{
												echo ("Inserting into database (image)\t\t\t: success\n<br>\n");
	
												$ret = insert_meta($query['collectionid'],$newid,$time,$user['login'],$query['type']);
	
												if (!$ret)
												{
													echo ("Inserting into database (meta)\t\t\t: failed\n<br>\n");
													echo ("Aborting...\n<br>\n");
												}
												else
												{
													echo ("Inserting into database (meta)\t\t\t: success\n<br>\n");
	
													if(!empty($query['group1id']))
													{
														$ret = insert_img_group($query['group1id'],$query['collectionid'],$newid);
	
														if (!$ret)
														{
															// a failed group insertion is non-critical, so we continue
															echo ("Inserting into database (group1)\t\t\t: failed\n<br>\n");														}
														else
														{
															echo ("Inserting into database (group1)\t\t\t: success\n<br>\n");
														}
													}
	
													if(!empty($query['group2id']))
													{
														$ret = insert_img_group($query['group2id'],$query['collectionid'],$newid);
	
														if (!$ret)
														{
															// a failed group insertion is non-critical, so we continue
															echo ("Inserting into database (group2)\t\t\t: failed\n<br>\n");														}
														else
														{
															echo ("Inserting into database (group2)\t\t\t: success\n<br>\n");
														}
													}
	
													if(!empty($query['group3id']))
													{
														$ret = insert_img_group($query['group3id'],$query['collectionid'],$newid);
	
														if (!$ret)
														{
															// a failed group insertion is non-critical, so we continue
															echo ("Inserting into database (group3)\t\t\t: failed\n<br>\n");														}
														else
														{
															echo ("Inserting into database (group3)\t\t\t: success\n<br>\n");
														}
													}
												}
	
												// end of actions - output a newline
												echo ("\n<br>\n");
	
											}
										}
									}									
								}
						 	}
						}
				 	}
				}

				// Image is processed completely

				echo ("<em>".$file." done</em>\n<br><br>\n");
				flush();
			}
		}
		
		// after all images have been processed, we try to clean up the upload directory, so things do not get inserted twice

		foreach ($remove as $removethis)
		{
			if (!empty($dir))
			{
				$removedir = $dir.DIRECTORY_SEPARATOR.$removethis;
			}
			else
			{
				$removedir = $removethis;
			}
			
			if ($debug)
			{
				echo ("Purging possible thumbs.db file from: ".$removedir."\n<br>\n");
			}
			
			$ret = @unlink($removedir.'Thumbs.db');

			if ($debug)
			{
				echo ("Now removing: ".$removedir."\n<br>\n");
			}			

			$ret = @rmdir($removedir);

			if (!$ret)
			{
				$errorstring = "Notice: ".$removedir." could not be removed\n<br>\n";
				$errorstring .= "Insufficient permission or directory not empty\n<br>\n";
				echo ($errorstring);
			}
		}
		
		if ($debug)
		{
			echo ("Purging possible thumbs.db file from: ".$dir."\n<br>\n");
		}
		
		$ret = @unlink($dir.'Thumbs.db');

		if ($debug)
		{
			echo ("Now removing: ".$dir."\n<br>\n");
		}

		$ret = @rmdir($dir);

		if (!$ret)
		{
			$errorstring = "Notice: ".$dir." could not be removed\n<br>\n";
			$errorstring .= "Insufficient permission or directory not empty\n<br>\n";
			echo ($errorstring);
		}
		
		return;
}

//phpinfo();
?>
