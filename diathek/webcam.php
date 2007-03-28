<?php
	include_once( 'session.inc.php' );
	// include( 'db.inc.php' );
	include( 'PhpRequestAndSessionWrapper.class.php');
	include( 'DilpsBarcodeAndFileChecker.class.php');
	include( 'AxisImageAcquisition.class.php');
	
	ini_set('display_errors',1);
	ini_set('magic_quotes_runtime',0);
	error_reporting (E_ALL);
	
	// print_r($_REQUEST);
	
	/*
	echo ("SESSION-before:");
	print_r($_SESSION);
	echo ("\n<br>\n");
	*/
	
	$rasWrapper = new PhpRequestAndSessionWrapper($_POST, $_GET, $_SESSION);
	$barcode 	= $rasWrapper->getValue('post','barcode');
	
	if (empty($barcode))
	{
		$barcode 	= $rasWrapper->getValue('get','barcode');
	}
	
	// standardmaessig kamera 1 verwenden
	$useWebcamNo = 1;
	
	if ($rasWrapper->getValue('post','useWebcamNo') === false)
	{
		if (($rasWrapper->getValue('session','useWebcamNo')) !== false)
		{
			$useWebcamNo = $rasWrapper->getValue('session','useWebcamNo');
		}
	}
	else 
	{
		if ($rasWrapper->getValue('post','useWebcamNo') == 2) 
		{
			$useWebcamNo = 2;
		}
		else 
		{
			$useWebcamNo = 1;
		}	
	}

	$rasWrapper->setValue('session','useWebcamNo',$useWebcamNo);
	
	/*
	echo ("SESSION-after:");
	print_r($_SESSION);
	echo ("\n<br>\n");
	*/
	
	$camWrapper = new AxisImageAcquisition($barcode,$useWebcamNo);
	
	$fileWrapper = new DilpsBarcodeAndFileChecker($barcode);
	
?>

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
	<meta name="author" content="juergen enge, thorsten wuebbena">
	<meta name="date" content="2003-01-23">
	<link rel="shortcut icon" href="favicon.ico">
	<title>. : DILPS : .</title>
	<link rel="stylesheet" type="text/css" href="resource/dilps.css">
	<link rel="stylesheet" type="text/css" href="resource/yui-divs.css">
	
	<script type='text/javascript' src='dilpsserver.php?<?php echo strip_tags(SID); ?>&client=all&stub=dilpsacquisitionajax'></script>
	<script type="text/javascript" src="yui/build/yahoo/yahoo.js"></script> 
	<script type="text/javascript" src="yui/build/dom/dom.js"></script> 
	<script type="text/javascript" src="yui/build/event/event.js"></script> </head>
	<script type="text/javascript" src="yui/build/animation/animation.js"></script> 
	<script type="text/javascript" src="yui/build/autocomplete/autocomplete.js"></script> 
	<script type="text/javascript" src="yui/build/utilities/utilities.js"></script>
	
	<script type="text/javascript" src="resource/diathek.inc.js"></script>
	
</head>
<body class="main" style="width: 100%;">
<form name="Main" action="webcam.php" method="post" style="width: 100%;">

<input type="hidden" name="PHPSESSID" value="<?php echo session_id();?>">
<input type="hidden" name="barcode" value="<?php echo $barcode ?>">
<input type="hidden" name="reloadOrSave" value="reload">
<input type="hidden" name="side" value="fs">
<input type="hidden" name="useWebcamNo" value="<?php echo $useWebcamNo ?>">

<table class="header" style="width: 100%; text-align: center;">
	<!-- heading line -->
	<tr>
		<td colspan="2">
			<div id="line_2" style="text-align: center;"> 
				<b>Johann Wolfgang Goethe-Universität Frankfurt / Bilderfassungs-System der Diathek</b>
			</div>
		</td>
	</tr>
	<!-- heading line end -->
	
	<!-- result -->
	<tr>
		<td colspan="2"  style="text-align: center;">
		<?php
		
			if (!isset($barcode))
			{
				die("Fehler bei der Übergabe des Barcodes\n");
			}
			else 
			{
				// prüfe, ob gespeichert werden soll
				
				if ($rasWrapper->getValue('post','reloadOrSave') == 'save')
				{
					$camWrapper->saveCurrentImage($rasWrapper->getValue('post','side'));					
					
					if ($fileWrapper->hasWebcamImage($rasWrapper->getValue('post','side')))
					{
						$webcamImageUrl = $fileWrapper->getWebcamImageFilename($rasWrapper->getValue('post','side'));
						?>
						
						<script type="text/javascript">
							updateImageInParentWindow('<?php echo $rasWrapper->getValue('post','side'); ?>','<?php echo $webcamImageUrl; ?>');
						</script>
						
						<?php
					}
				}				
			}
		?>
		
		</td>
	</tr>
	<!-- result end -->
	
	<!-- close window -->
	<tr>
		<td colspan="2" style="text-align: center;">
			<input type="button" class="suche" name="close_win" value="Fenster schlie&szlig;en" onclick="window.close();">
		</td>
	</tr>
	<!-- close window end -->
	
	
	<!-- content -->
	<tr>
		<td style="vertical-align: middle; width: 100%; text-align: center;">
			<table class="centered" border="0" cellspacing="0" cellpadding="0" style="width: 100%;">
				<tr>
					<td colspan="2">
						<?php
							if (!$rasWrapper->getValue('get','showonly') == 'true')
							{
								$imageTag = "<img src='".$camWrapper->getImageURL()."'"
											." width='640px' >";
											
								echo $imageTag;
							}
							else 
							{
								if ($fileWrapper->hasWebcamImage($rasWrapper->getValue('get','side')))
								{
									$imageTag = "<img src='image.php?filename="
												.$fileWrapper->getWebcamImageFilename($rasWrapper->getValue('get','side'))
												."'"
												." width='640px' >";
									echo $imageTag;
								}
								else 
								{
									$imageTag = "<img src='".$camWrapper->getImageURL()."'"
												." width='640px' >";
											
									echo $imageTag;
								}
							}
						?>
					</td>
				</tr>
				<tr>
					<td colspan="2" style="text-align: center;">
						<table class="centered" border="0" cellspacing="0" cellpadding="0" style="width: 100%;">
							<td style="width: 20%; text-align: left;">
								<input type="button" class="suche" name="reload_cam" value="Neu Laden" onclick="reloadWebcam();">
							</td>
							<td style="width: 20%; text-align: left;">
								<input type="button" class="suche" name="change_cam" value="Kamera wechseln" onclick="changeWebcam('<?php echo ($useWebcamNo == 1 ? 2 : 1); ?>');">
							</td>							
							<td style="width: 10%; text-align: left;">
								&nbsp;
							</td>							
							<td style="width: 25%; text-align: right;">
								<input type="button" class="suche" name="save_fs" value="Als Vorderseite speichern" onclick="saveWebcam('fs');" style="width: 175px;">
							</td>
							<td style="width: 25%; text-align: right;">
								<input type="button" class="suche" name="save_bs" value="Als R&uuml;ckseite speichern" onclick="saveWebcam('bs');" style="width: 175px;">
							</td>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<!-- content end -->

	<!-- footing line -->
	<tr>
		<td colspan="2">
			<div id="line_1" style="text-align: center; vertical-align: middle; margin-top: 3px;"> 
				<span style="font-size: 0.9em;"><b>Datenerfassung für Bild-Nr. "<?php echo $barcode; ?>" - Webcam <?php echo $useWebcamNo ?></b></span>
			</div>
		</td>
	</tr>
	<!-- footing line end -->
	
</table>

</form>
</body>
</html>