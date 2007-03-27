<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN"
  "http://www.w3.org/TR/html4/strict.dtd">

<html>
<head>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="expires" content="0">
	<meta http-equiv="cache-control" content="no-cache">
	<meta name="keywords" content="Bilddatenbanksystem, Bilddatenbank, Diathek, digitalisiert">
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	<meta http-equiv="Content-Script-Type" content="text/javascript">
	<meta http-equiv="Content-Style-Type" content="text/css">
	<meta name="author" content="jrgen enge, thorsten wbbena">
	<meta name="date" content="2003-01-23">
	<link rel="shortcut icon" href="favicon.ico">
	<title>. : DILPS : .</title>
	<link rel="stylesheet" type="text/css" href="resource/dilps.css">
</head>

<body class="main" style="width: 100%;">

<?php
	include_once( 'session.inc.php' );
	include('DilpsBarcodeAndFileChecker.class.php');
	
	$base_dir = '/home/kunst/diathek/archiv';
	$basedir = '/home/kunst/diathek';
    $convert = '/opt/freeware/bin/convert';
    
    $resolutions = array (
		"0"	=>	"120x90",
		"1"	=>	"640x480",
		"2"	=>	"800x600",
		"3"	=>	"1024x768",
		"4"	=>	"1280x1024",
	);
	

	function read_recursive($dir, &$files)
	{
		if(is_dir($dir))
		{
			$dir_handle=opendir($dir);
	
			while($file = readdir($dir_handle))
			{
				if($file != "." && $file != "..")
				{
					if(is_dir($dir.addslashes(DIRECTORY_SEPARATOR.$file)))
					{
						read_recursive($dir.addslashes(DIRECTORY_SEPARATOR.$file), $files);
					}
					else
					{
						$files[] = $dir.DIRECTORY_SEPARATOR.$file;
					}
				}
			}
	
			closedir($dir_handle);
		}
		else
		{
			if (is_file($dir))
			{
				$files[] = $dir;
			}
			else
			{
				echo ("Fehler beim rekursiven Einlesen der Verzeichnisse: \n<br>\n");
				echo ("Die Ressource '".$dir."' konnte nicht geöffnet werden\n<br>\n");
				return false;
			}
		}
		return true;
	}
	
	function checkDir($dir, $test_writeable = false, $create_nonexistant = false, $create_perms = 0755)
	{		
		if (!is_dir($dir))
		{
			if ($create_nonexistant)
			{
				$ret = mkdir($dir,$create_perms);
				return $ret;
			}
			else
			{
				return false;
			}
		}
		else
		{
			if ($test_writeable)
			{
				$ret = is_writeable($dir);
				return $ret;
			}
		}
	}
	
	function convertImage($input, $output, $to_res,$is_thumbnail = false)
	{
		global $convert;
		$imagemagick_convert = $convert;
		
		if ($is_thumbnail)
		{
			// we sharpen thumbnails
			$cmd = $imagemagick_convert
							." \"".$input."\" "
							."-flatten -scale ".$to_res
							." -sharpen 4 \"".$output."\"";
		}
		else
		{
			$cmd = $imagemagick_convert
							." \"".$input."\" "
							."-flatten -scale ".$to_res
							." \"".$output."\"";
		}
		
		unset($result);
		exec(escapeshellcmd($cmd), $result, $ret);
		
		echo ("Cmd: $cmd\n<br>\n");
		echo ("Ret: $ret\n<br>\n");
		
		echo ("Result:\n<br>\n");
		print_r($result);
						
		if ($ret == 0) {
			return true;
		}
		else {
			return false;
		}
	}
	
	function buildCache($barcode, $filename)
    {
    	global $basedir;
    	global $resolutions;
    	
    	$filename_base = $barcode;
		    	
    	// Zwischenspeicher prüfen und bei Bedarf anlegen

		$ret = checkDir($basedir.'/cache/',true,true,0777);

		if (!$ret)
		{
			$errorstring = "Fehler beim Anlegen des Zwischenspeicher-Verzeichnisses! \n<br>\n";
			die ($errorstring);
		}
		else 
		{
		
			$ret = checkDir($basedir.'/cache/1600x1200/',true,true,0777);
	
			if (!$ret)
			{
				$errorstring = "Fehler beim Anlegen des Zwischenspeicher-Verzeichnisses (1600x1200)! \n<br>\n";
				die ($errorstring);
			}
			
			// zunächst in 1600x1200 umwandeln (als Basis für weitere Konvertierungen)
			
			$baseimage_filename = $basedir.'/cache/1600x1200/'.$filename_base.'.jpg';
	
			$res = '1600x1200';
	
			$ret = convertImage($filename,$baseimage_filename,$res, false);
	
			if (!$ret)
			{
				$errorstring = "Fehler beim Umrechnen des Bildes in die Aufl&ouml;sung 1600x1200! \n<br>\n";
				die ($errorstring);
			}
								
			foreach ($resolutions as $res)
			{
				// Unterverzeichnisse für einzelne Auflösungen prüfen
				$ret = checkDir($basedir.'/cache/'.$res,true,true, 0777);
				
				if (!$ret) {
					$errorstring = "Fehler beim Anlegen des Zwischenspeicher-Verzeichnisses (".$res.")\n<br>\n";
					die ($errorstring);
				}

				if ($res == '120x90') {
					$is_thumbnail = true;
				}
				else {
					$is_thumbnail = false;
				}

				$output_filename = $basedir.'/cache/'.$res.'/'.$filename_base.'.jpg';

				$ret = convertImage($baseimage_filename,$output_filename,$res, $is_thumbnail);

				if (!$ret) {
					$errorstring = "Fehler beim Umrechnen des Bildes in die Aufl&ouml;sung (".$res.")! \n<br>\n";
					die ($errorstring);
				}
			}
		}
    }
	

	if (!isset($_POST['proceed']))
	{

?>

<form name="Main" action="prepare.php" method="post" style="width: 100%;">

<input type="hidden" name="PHPSESSID" value="<?php echo session_id();?>">
<table class="header" style="width: 100%;">
	<!-- heading line -->
	<tr>
		<td colspan="3">
			<div id="line_2" style="text-align: center;"> 
				<b>Vorbereitung von Verzeichnissen (<a class="heading" href="index.php?PHPSESSID=<?php echo session_id()?>"><b>Zur&uuml;ck zur Hauptseite</b></a>)</b>
			</div>
		</td>
	</tr>
	<!-- heading line end -->
	
	<tr>
		<td colspan="3" style="height: 40px;">
			&nbsp;
		</td>
	</tr>
	
	<!-- content -->
	<tr>
		<td style="text-align: center; width: 100%">
			<!-- selection for directory to prepare -->
				<b>Bitte ausw&auml;hlen, welche Digitalisate für die Erfassung vorbereitet werden sollen: </b>
				<select name="select_dir" style="text-align: center; vertical-align: middle;">
				<?php
				
					$dir_handle=opendir($base_dir);
			
					while($file = readdir($dir_handle))
					{
						/*
						if($file != "." && $file != ".." && $file != '.listing')
						{
							echo ("<option value='".$file."'>".htmlentities($file)."</option>\n");
						}
						*/
						if($file != "." && $file != ".." && $file != '.listing' && $file != 'index.html')
						{
							echo ("<option value='".$file."'>".htmlentities($file)."</option>\n");
						}
						
					}
					closedir($dir_handle);
				?>
				</select>
				&nbsp; &nbsp;
				<input type="submit" class="suche" name="proceed" value="WEITER" style="vertical-align: middle;">
			<!-- selection for directory to prepare end -->
		</td>
	</tr>
	<!-- content end -->
	
	<tr>
		<td colspan="3" style="height: 50px;">
			&nbsp;
		</td>
	</tr>

	<!-- footing line -->
	<tr>
		<td colspan="2">
			<div id="line_1" style="text-align: center; vertical-align: middle; margin-top: 3px;"> 
				<span style="font-size: 0.9em;"><b>Achtung - der Vorbereitungsvorgang kann sehr viel Zeit in Anspruch nehmen.</b></span>
			</div>
		</td>
	</tr>
	<!-- footing line end -->
</table>
</form>
<?php
	}
	else 
	{
	?>
		<!-- heading line -->
		<div id="line_2" style="text-align: center;"> 
			<b>Bitte den Browser nicht schließen, solange die Ladeanzeige aktiv ist.</b>
		</div>
		<!-- heading line end -->
		
		<div style="height: 20px;">
			&nbsp;
		</div>
		
		<!-- content -->
		<?php
			$work_dir = $base_dir.'/'.trim($_POST['select_dir']);
			$files = array();
			
			echo ("<span style='font-size: 0.9em;'>Verzeichnis: ".$work_dir."</span>\n<br/>\n<br>\n");
			
			if (read_recursive($work_dir,$files))
			{
				foreach ($files as $filename)
				{
					if (strpos($filename,'.tif') > 0)
					{
						$barcode = substr($filename,strrpos($filename,'/')+1,13);
						echo ("<span style='font-size: 0.9em;'>Barcode: ".$barcode."</span>\n - ");
						
						// auf vorhandenes Bild prüfen
				
						$smallest = $basedir.'/cache/120x90/'.$barcode.'.jpg';
						
						// echo ("smallest: ".$smallest."\n<br>\n");
    		
						if (!file_exists($smallest))
						{
							echo ("<span style='font-size: 0.9em>");
							buildCache($barcode, $filename);
							echo ("</span>\n");
							echo ("<span style='font-size: 0.9em;'>abgearbeitet</span>\n<br/>\n");
						}
						else 
						{
							echo ("<span style='font-size: 0.9em;'>Dateien bereits vorhanden</span>\n<br/>\n");
						}
					}
				}
			}
			else 
			{
				echo ("<br/>\n<br/>\Fehler beim rekursiven Einlesen des Diathek<br/>\n<br>\n");
			}
		?>
		<!-- content end -->
		<div id="line_1" style="text-align: center; vertical-align: middle; margin-top: 3px;"> 
			<span style="font-size: 0.9em;"><a class="heading" href="index.php?PHPSESSID=<?php echo session_id()?>"><b>Zur&uuml;ck zur Hauptseite</b></a></span>
		</div>
		
		<?php
	}
	?>
</body>
</html>
