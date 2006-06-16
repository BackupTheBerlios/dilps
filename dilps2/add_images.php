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
 * File:     			add_images.php
 * Purpose:  	process and store images that are either
 *						uploaded via FTP or browser-file-transfer,
 *						add the corresponding database entries
 * Requires:		file, identify and convert (imagemagick)
 * ---------------------------------------------------------------------
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
if (isset($_REQUEST['PHPSESSID']))
{
	$sessionid = $_REQUEST['PHPSESSID'];
}
else
{
	$sessionid = '';
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
	$query 			= $_REQUEST['query'];
	$process 		= $query['process'];
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
	echo ("Adding Images - Started\n<br>\n");

	if ($completedir) {

		$dir = trim($query['sourcedirectory']);

		if ($dir{strlen($dir)-1} == DIRECTORY_SEPARATOR ) {
			$dir = substr($dir,0,strlen($dir)-1);
		}

		if(!is_dir($dir)) {
			echo ("No Directory\n<br>\n");
		}

		if ($debug)
		{
			echo "Dir: ".$dir."\n<br\n";
		}

		echo ("Reading directory structure:\n<br>\n<br>\n");

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
				echo ("Reading file: ".$file."\n<br>\n");

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
						$fileext = substr($filename,$dotpos+1);
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
									die ($errorstring);
								}

								// check if we already have a cache directory structure, otherwise create

								$ret = check_dir($output_dir.DIRECTORY_SEPARATOR.'cache'.DIRECTORY_SEPARATOR,true,true,0755);

								if (!$ret)
								{
									$errorstring = "Output directory cache does not exist or is not writable! \n<br>\n";
									die ($errorstring);
								}

								// get new id for filename

								$sql 			=	"SELECT max(imageid)+1 FROM ".$db_prefix."img";
								$newid 		= $db->GetOne($sql);

								if (!$newid)
								{
									$newid 	= 1;
								}

								// iterate through all available resolutions
								$resolutions = $resolutions_available;

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

									if ($res == '120x90')
									{
										$is_thumbnail = true;
									}
									else
									{
										$is_thumbnail = false;
									}

									$output_filename = $output_dir.DIRECTORY_SEPARATOR.'cache'.DIRECTORY_SEPARATOR.$res.DIRECTORY_SEPARATOR.$query['collectionid'].'-'.$newid.'.jpg';

									$ret = convert_image($filename,$output_filename,$res, $is_thumbnail);

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

								// convert to JPEG with original resolution
								if ($convert_success)
								{
									$output_filename = $output_dir.DIRECTORY_SEPARATOR.'cache'.DIRECTORY_SEPARATOR.$query['collectionid'].'-'.$newid.'.jpg';

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

								if ($convert_success)
								{
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
											echo ("Removing upload file\t: failed\n<br>\n");
									 	}
										else
										{
											echo ("Removing upload file\t: success\n<br>\n");
										}
										echo ("\n<br>\n");

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

											$ret = insert_meta($query['collectionid'],$newid,$time,$user['login']);

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

				// Image is processed completely

				echo ($file." done\n<br><br>\n");
				flush();
			}
		}

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
			echo ("Now removing: ".$dir."\n<br>\n");
		}

		$ret = @rmdir($dir);

		if (!$ret)
		{
			$errorstring = "Notice: ".$dir." could not be removed\n<br>\n";
			$errorstring .= "Insufficient permission or directory not empty\n<br>\n";
			echo ($errorstring);
		}
	}
	else
	{

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
			$userfileext = substr($userfilename,$dotpos+1);
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
						die ($errorstring);
					}

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

					// iterate through all available resolutions
					$resolutions = $resolutions_available;

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

						if ($res == '120x90')
						{
							$is_thumbnail = true;
						}
						else
						{
							$is_thumbnail = false;
						}

						$output_filename = $output_dir.DIRECTORY_SEPARATOR.'cache'.DIRECTORY_SEPARATOR.$res.DIRECTORY_SEPARATOR.$query['collectionid'].'-'.$newid.'.jpg';

						$ret = convert_image($filename,$output_filename,$res, $is_thumbnail);

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

					// convert to JPEG with original resolution
					if ($convert_success)
					{
						$output_filename = $output_dir.DIRECTORY_SEPARATOR.'cache'.DIRECTORY_SEPARATOR.$query['collectionid'].'-'.$newid.'.jpg';

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

					if ($convert_success)
					{
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
								echo ("Removing upload file\t: failed\n<br>\n");
							}
							else
							{
								echo ("Removing upload file\t: success\n<br>\n");
							}
							echo ("\n<br>\n");

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

								$ret = insert_meta($query['collectionid'],$newid,$time,$user['login']);

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

	echo ("\n<br>\nAdding images - done\n");
	echo ("<br>\n<br>\n");
	echo ('<a href="javascript:opener.document.forms[0].submit();window.close();" class="navlink">Close window</a>');

	echo ("</td>\n</tr>\n</table>");
	echo ('</body>');
	echo ('</html>');

} else {


	$smarty->assign('sessionid',$sessionid);
	$smarty->display( $config['skin'].DIRECTORY_SEPARATOR.'add_images.tpl' );

}

//phpinfo();
?>
