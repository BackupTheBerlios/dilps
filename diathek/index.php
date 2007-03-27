<?php
	include_once( 'session.inc.php' );
	// include( 'db.inc.php' );
	include( 'DilpsEntryWrapper.class.php');
	include( 'PhpRequestAndSessionWrapper.class.php');
	ini_set('magic_quotes_runtime',0);
	
	global $db, $db_prefix;
	
	/*
	print_r($_REQUEST);
	$db->debug = true;
	*/
	
	error_reporting(E_ALL);
	ini_set('display_errors',1);
	
?>


<!-- ============================================
BEGIN grid_detail.tpl
============================================ -->
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
	<meta name="author" content="juergen enge, sebastian doeweling, thorsten wuebbena">
	<meta name="date" content="2007-01-01">
	<link rel="shortcut icon" href="favicon.ico">
	<title>. : DILPS : .</title>
	<link rel="stylesheet" type="text/css" href="resource/dilps.css">
	
	
	<script type="text/javascript">
		function checkBarcode()
		{
			var barcode = document.forms[0].elements['barcode'].value;
			
			if( barcode == '') 
			{ 
				alert('Bitte einen Wert eingeben!');
				return false;
			}
			else
			{
				if (barcode.length != 13)
				{
					alert('Barcode hat die falsche Länge!');
					return false;
				}
				else
				{
					reg = new RegExp('^(A[0-9]{2}[-|ß][0-9]{2})[-|ß][0-9]{2}[-|ß][0-9]{3}$');
					res = reg.test(barcode);
					
					if (res)
					{					
						return true;
					}
					else
					{
						alert('Barcode hat die falsche Struktur (korrekt: Axx-xx-xx-xxx)!');
						return false;						
					}
					
				}
			}	
		}
	</script>
	
	
	
</head>
<body class="main" style="width: 100%;">
<form name="Main" action="edit.php" method="post" style="width: 100%;" onsubmit="javascript:return checkBarcode();">

<input type="hidden" name="PHPSESSID" value="<?php echo session_id();?>">

<table class="header" style="width: 100%;">
	<!-- heading line -->
	<tr>
		<td colspan="3">
			<div id="line_2" style="text-align: center;"> 
				<a class="heading" href="index.php?PHPSESSID=<?php echo session_id()?>"><b>Johann Wolfgang Goethe-Universität Frankfurt / Bilderfassungs-System der Diathek</b></a>
			</div>
		</td>
	</tr>
	<!-- heading line end -->
	
	<tr>
		<td colspan="3" style="height: 40px;">&nbsp;
			
		</td>
	</tr>
	
	<!-- result -->
	<tr>
		<td style="vertical-align: top; text-align: center; width: 100%">
			<table class="query" cellspacing="0" cellpadding="0" style="width: 60%; vertical-align: top; text-align: center;">
				<tr>
					<td colspan="3" style="text-align: center;">
					
					<?php
						if (isset($_POST['saved']) && $_POST['saved'] == 1)
						{
							$rasWrapper = new PhpRequestAndSessionWrapper($_POST, $_GET, $_SESSION);
							
							if (!$rasWrapper->getValue('post','barcode'))
							{
								echo ("Fehler bei der Übergabe des Barcodes\n");
							}
							else 
							{
								?>
								<!-- barcode o.k. -->
								<?php
								$barcode = $rasWrapper->getValue('post','barcode');
								
								// eventuell noch vorhandene, nicht mehr gewünschte Werte aus der Session entfernen
								
								$unsetSessionValues = array(	
																'type', 'name', 'location',
																'institution', 'material',
																'technique', 'format',
																'literature', 'commentary'
															);
								
								foreach ($unsetSessionValues as $valueKey)
								{
									$rasWrapper->unsetValue('session',$valueKey);
									// echo ("\$rasWrapper->unsetValue('session',$valueKey); aufgerufen\n<br>\n");
								}
								
								?>
								<!-- session bereinigt -->
								<?php
															
								// Datenbank-Objekt initialisieren
							
								$wrapper = new DilpsEntryWrapper($db, $db_prefix, $barcode);
								
								$storeDbValues = array(	
															'type', 'title', 'dating', 
															'material', 'technique', 'format',
															'institution', 'literature',
															'page', 'figure', 'tableno',
															'name', 'location', 'commentary'
														);
														
								$sessionSavedValues = $rasWrapper->getValue('post','save_value');
								
								foreach ($storeDbValues as $valueKey)
								{
									if ($rasWrapper->getValue('post',$valueKey))
									{
										$funcName = 'set'.ucfirst($valueKey);
										if (method_exists($wrapper,$funcName))
										{
											$wrapper->{$funcName}($rasWrapper->getValue('post',$valueKey));
											// echo ("\$wrapper->{$funcName}(".$rasWrapper->getValue('post',$valueKey).") aufgerufen\n<br>\n");
										}
										/*
										else 
										{
											echo ("\$wrapper->{$funcName}() nicht gefunden\n<br>\n");
										}
										*/
										
										if ($sessionSavedValues)
										{
											if (in_array($valueKey,$sessionSavedValues))
											{
												$rasWrapper->setValue('session',$valueKey,$rasWrapper->getValue('post',$valueKey));
											}
										}
									}
									/*
									else 
									{
										echo ("Wert {$valueKey} nicht in \$_POST enthalten\n<br>\n");
									}
									*/
								}
								
								// zur einfacheren Handhabung, die Angabe zu den in der Session gespeicherten Werten,
								// dort ablegen
								
								if (isset($_POST['save_value']))
								{
									$_SESSION['save_value'] = $_POST['save_value'];
								}
								else 
								{
									$rasWrapper->unsetValue('session','save_value');
								}
								
								// print_r($_SESSION);
								
								// die("Here we stop!\n<br>\n");
								
								echo ($wrapper->updateDB()."\n");
							}
							
						}
						else 
						{
							echo ("&nbsp;\n");
						}
					?>
					
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<!-- result end -->
	
	<!-- content -->
	<tr>
		<td style="vertical-align: top; text-align: center; width: 100%">
			<!-- barcode input field -->
			<table class="query" cellspacing="0" cellpadding="0" style="width: 60%; vertical-align: top; text-align: center;">
				<tr>
					<td class="queryinputfieldtext">
						Barcode
					</td>
					<td class="queryinputfield">
						<input class="queryinputfield" type="text" name="barcode" size="80" value="">
					</td>
					<td class="queryinputfield">
						<input type="submit" class="suche" name="save" value="WEITER">
					</td>
				</tr>
			</table>
			<!-- barcode input field end -->
		</td>
	</tr>
	<!-- content end -->
	
	<tr>
		<td colspan="3" style="height: 50px;">&nbsp;
			
		</td>
	</tr>

	<!-- footing line -->
	<tr>
		<td colspan="2">
			<div id="line_1" style="text-align: center; vertical-align: middle; margin-top: 3px;"> 
				<span style="font-size: 0.9em;"><b>Bitte den Barcode des Bildes scannen</b></span>
			</div>
		</td>
	</tr>
	<!-- footing line end -->
	
	<tr>
		<td colspan="3" style="height: 5px;">&nbsp;
			
		</td>
	</tr>
	
	<!-- link to directory preparation -->
	<tr>
		<td colspan="2">
			<div style="text-align: right; margin-right: 10px;"> 
				<a href="prepare.php?PHPSESSID=<?php echo session_id()?>" style="text-decoration: underline;"><b>Verzeichnisse f&uuml;r Erfassung vorbereiten</b></a>
			</div>
		</td>
	</tr>
	<!-- link to directory preparation end -->
</table>
</form>
</body>
</html>