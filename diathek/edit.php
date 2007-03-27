<?php
	include_once( 'session.inc.php' );
	// include( 'db.inc.php' );
	include( 'DilpsEntryWrapper.class.php');
	include( 'DilpsBarcodeAndFileChecker.class.php');
	
	ini_set('display_errors',1);
	ini_set('magic_quotes_runtime',0);
	error_reporting (E_ALL);
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
<form name="Main" action="index.php" method="post" style="width: 100%;">

<input type="hidden" name="PHPSESSID" value="<?php echo session_id();?>">
<input type="hidden" name="saved" value="1">
<input type="hidden" name="barcode" value="<?php if(isset($_POST['barcode'])) { echo (trim($_POST['barcode'])); } ?>">

<script type="text/javascript">

var remoteHW = new DilpsAcquisitionAJAX();

var num = 20;

function do_getCompletions( field, sQuery, num )
{
    return remoteHW.getCompletions( field, sQuery, num );
}

</script> 

<table class="header" style="width: 100%;">
	<!-- back link -->
	<tr>
		<td colspan="2">
			&nbsp;<a href="index.php?PHPSESSID=<?php echo session_id()?>" style="text-decoration: underline;"><b>Zur&uuml;ck zur Barcode-Erfassung</b></a>
		</td>
	</tr>
	<!-- back end -->
	
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
		
			if (!isset($_POST['barcode']))
			{
				die("Fehler bei der Übergabe des Barcodes\n");
			}
			else 
			{
				// auf vorhandenes Bild prüfen
				
				$filechecker = new DilpsBarcodeAndFileChecker(trim($_POST['barcode']));
				
				$hasFile = $filechecker->hasFile();
				
				// print_r($filechecker);
				
				if ($hasFile)
				{
					// Datei existiert - zum Datenbankeintrag verbinden
				
					$wrapper = new DilpsEntryWrapper($db, $db_prefix, trim($_POST['barcode']));
					
					$createStatus = $wrapper->createIfNotExists();
					
					if (!$createStatus)
					{
						echo ("{$createStatus}\n");
					}
					else 
					{
						$loadStatus = $wrapper->loadFromDbOrSession();
					
						if (!$loadStatus)
						{
							echo ("{$loadStatus}\n");
						}
						else 
						{
							echo ("&nbsp;\n");
						}
					}
				}
				else 
				{
					echo ("&nbsp;");
				}
			}
		?>
		
		</td>
	</tr>
	<!-- result end -->
	
	<!-- content -->
	<tr>
		<td style="vertical-align: top; width: 50%">
			<!-- left side (form fields) -->
			<table class="query" cellspacing="0" cellpadding="0" style="width: 90%; vertical-align: top;">
			<?php
			if ($hasFile && $loadStatus)
			{
				if(isset($_SESSION['save_value']))
				{
					$save_value = $_SESSION['save_value'];
				}
				else 
				{
					$save_value = array();
				}
				
				?>
				<tr>
					<td style="text-align: right; padding-right: 10px;">
						<b>Feld</b>
					</td>
					<td style="text-align: left; padding-left: 3px;">
						<b title="Bitte hier die Werte zu diesem Bild auswählen/eingeben">Wert</b>
					</td>
					<td style="text-align: center;">
						<b title="Diesen Wert für die nächste Bearbeitung behalten">beh.</b>
					</td>
				</tr>
				<tr>
					<td class="queryinputfieldtext">
						Typ
					</td>
					<td>
						
					  <select class="queryselectfield" name="type" style="width: 20em; text-align: center;">
						   <option value="image" <?php if ($wrapper->getType() == 'image') { echo ('selected = "selected"'); } ?> >Bild</option>
						   <option value="architecture" <?php if ($wrapper->getType() == 'architecture') { echo ('selected = "selected"'); } ?> >Architektur</option>
						   <option value="other" <?php if ($wrapper->getType() == 'other') { echo ('selected = "selected"'); } ?> >Sonstige</option>
					  </select>
					  
					  
					  <!--
					  <select class="queryselectfield" name="type" style="width: 20em; text-align: center;">
						   <option value="image">Bild</option>
						   <option value="architecture">Architektur</option>
						   <option value="other">Sonstige</option>
					  </select>
					  -->
					</td>
					<td class="querycheckboxfield">
						<input type="checkbox" name="save_value[]" value="type" <?php if (in_array('type',$save_value)) { echo "checked='checked'"; } ?> >
					</td>
				</tr>
				<tr>
					<td class="queryinputfieldtext">
						Titel
					</td>
					<td class="queryinputfield">
						<input class="queryinputfield" type="text" name="title" size="80" value="<?php echo (htmlentities($wrapper->getTitle())); ?>">
					</td>
					<td class="querycheckboxfield">
						&nbsp;
					</td>
				</tr>
				<tr>
					<td class="queryinputfieldtext">
						<label for="name_mod">Name</label>
					</td>
					<td class="queryinputfield">
						<!-- autocomplete name -->
						<div id="name_mod">
							<input id="name_input" class="queryinputfield" type="text" name="name" size="80" value="<?php echo (htmlentities($wrapper->getName())); ?>">
						    <div id="name_container"></div>
						</div>
						<!-- autocomplete name end -->
					</td>
					<td class="querycheckboxfield">
						<input type="checkbox" name="save_value[]" value="name" <?php if (in_array('name',$save_value)) { echo "checked='checked'"; } ?>>
					</td>
				</tr>
				<tr>
					<td class="queryinputfieldtext">
						Datierung
					</td>
					<td class="queryinputfield">
						<input class="queryinputfield" type="text" name="dating" size="80" value="<?php echo (htmlentities($wrapper->getDating())); ?>">
					</td>
					<td class="querycheckboxfield">
						&nbsp;
					</td>
				</tr>
				<tr>
					<td class="queryinputfieldtext">
						<label for="location_mod">Ort</label>
					</td>
					<td class="queryinputfield">
						<!-- autocomplete name -->
						<div id="location_mod">
							<input id="location_input" class="queryinputfield" type="text" name="location" size="80" value="<?php echo (htmlentities($wrapper->getLocation())); ?>">
						    <div id="location_container"></div>
						</div>
						<!-- autocomplete name end -->
					</td>
					<td class="querycheckboxfield">
						<input type="checkbox" name="save_value[]" value="location" <?php if (in_array('location',$save_value)) { echo "checked='checked'"; } ?>>
					</td>
				</tr>
				<tr>
					<td class="queryinputfieldtext">
						<label for="institution_mod">Institution</label>
					</td>
					<td class="queryinputfield">
												
						<!-- autocomplete institution -->
						<div id="institution_mod">
							<input id="institution_input" class="queryinputfield" type="text" name="institution" size="80" value="<?php echo (htmlentities($wrapper->getInstitution())); ?>">
						    <div id="institution_container"></div>
						</div>
						<!-- autocomplete institution end -->
					</td>
					<td class="querycheckboxfield">
						<input type="checkbox" name="save_value[]" value="institution" <?php if (in_array('institution',$save_value)) { echo "checked='checked'"; } ?>>
					</td>
				</tr>
				<tr>
					<td class="queryinputfieldtext">
						<label for="material_mod">Material</label>
					</td>
					<td class="queryinputfield">
												
						<!-- autocomplete material -->
						<div id="material_mod">
							<input id="material_input" class="queryinputfield" type="text" name="material" size="80" value="<?php echo (htmlentities($wrapper->getMaterial())); ?>">
						    <div id="material_container"></div>
						</div>
						<!-- autocomplete material end -->
					</td>
					<td class="querycheckboxfield">
						<input type="checkbox" name="save_value[]" value="material" <?php if (in_array('material',$save_value)) { echo "checked='checked'"; } ?>>
					</td>
				</tr>
				<tr>
					<td class="queryinputfieldtext">
						<label for="technique_mod">Technik</label>
					</td>
					<td class="queryinputfield">
												
						<!-- autocomplete technique -->
						<div id="technique_mod">
							<input id="technique_input" class="queryinputfield"type="text" name="technique" size="80" value="<?php echo (htmlentities($wrapper->getTechnique())); ?>">
						    <div id="technique_container"></div>
						</div>
						<!-- autocomplete technique end -->
					</td>
					<td class="querycheckboxfield">
						<input type="checkbox" name="save_value[]" value="technique" <?php if (in_array('technique',$save_value)) { echo "checked='checked'"; } ?>>
					</td>
				</tr>
				<tr>
					<td class="queryinputfieldtext">
						Format / Ma&szlig;e
					</td>
					<td class="queryinputfield">
						<input class="queryinputfield" type="text" name="format" size="80" value="<?php echo (htmlentities($wrapper->getFormat())); ?>">
					</td>
					<td class="querycheckboxfield">
						&nbsp;
					</td>
				</tr>
				<tr>
					<td class="queryinputfieldtext">
						<label for="literature_mod">Quelle</label>
					</td>
					<td class="queryinputfield">
												
						<!-- autocomplete literature -->
						<div id="literature_mod">
							<input id="literature_input" class="queryinputfield"type="text" name="literature" size="80" value="<?php echo (htmlentities($wrapper->getLiterature())); ?>">
						    <div id="literature_container"></div>
						</div>
						<!-- autocomplete literature end -->
					</td>
					<td class="querycheckboxfield">
						<input type="checkbox" name="save_value[]" value="literature" <?php if (in_array('literature',$save_value)) { echo "checked='checked'"; } ?> >
					</td>
				</tr>
				<tr>
					<td class="queryinputfieldtext">
						Seite
					</td>
					<td class="queryinputfield">
						<input class="queryinputfield" type="text" name="page" size="80" value="<?php echo (htmlentities($wrapper->getPage())); ?>">
					</td>
					<td class="querycheckboxfield">
						&nbsp;
					</td>
				</tr>
				<tr>
					<td class="queryinputfieldtext">
						Tafel
					</td>
					<td class="queryinputfield">
						<input class="queryinputfield" type="text" name="tableno" size="80" value="<?php echo (htmlentities($wrapper->getTableno())); ?>">
					</td>
					<td class="querycheckboxfield">
						&nbsp;
					</td>
				</tr>
				<tr>
					<td class="queryinputfieldtext">
						Abbildung
					</td>
					<td class="queryinputfield">
						<input class="queryinputfield" type="text" name="figure" size="80" value="<?php echo (htmlentities($wrapper->getFigure())); ?>">
					</td>
					<td class="querycheckboxfield">
						&nbsp;
					</td>
				</tr>
				<tr>
					<td class="queryinputfieldtext">
						Kommentar / Sonstiges
					</td>
					<td class="queryinputfield">
						<input class="queryinputfield" type="text" name="commentary" size="80" value="<?php echo (htmlentities($wrapper->getCommentary())); ?>">
					</td>
					<td class="querycheckboxfield">
						&nbsp;
					</td>
				</tr>
				<tr>
					<td class="field_name">
					  &nbsp;
					</td>
					<td>
						<table border="0" cellspacing="0" style="width: 100%;">
							<tr>
								<td style="width: 75%; text-align: left;">
									<input type="submit" class="suche" name="save" value="SPEICHERN">
								</td>
								<td style="width: 25%; text-align: right;">
									<input type="reset" class="suche" name="reset" value="ZUR&Uuml;CKSETZEN">
								</td>
							</tr>
						</table>
					</td>
					<td>
						&nbsp;
					</td>
				</tr>
				<?php
			}
			else 
			{
				?>
				<tr>
					<td style="text-align: center;">
					<?php
						echo ("<b>Die Datei zum Barcode ".trim($_POST['barcode'])." konnte nicht gefunden werden <br/>-<br/> Bearbeitung nicht möglich\n</b>");
					?>
					</td>
				</tr>
			<?php
			}
			?>
			</table>
			<!-- left side (form fields) end -->
		</td>
		<td style="width: 50%;">
			<!-- right side (images)-->
			<table class="result_grid_data" cellpadding="0" cellspacing="0" style="width: 100%;">
				<tr>
					<!-- original image -->
					<td colspan="2" class="result_list_data_img" style="width: 400px; height: 400px; text-align: center; vertical-align: middle;">
						<table border="0" cellspacing="0" width="100%">
							<tr>
								<td rowspan="2"><img src="/icons/blank.gif" width="1" height="182"></td>
								<td><img src="/icons/blank.gif" width="121" height="1"></td>
							</tr>
							<tr colspan="2">
								<td style="text-align: center">
									<?php
										if ($filechecker->hasFile()) 
											{ $fn = $filechecker->getPreviewFilename();
											echo "<img src='image.php?filename=".$fn."' style='width: 280px;'>";
										}
										else 
										{
											echo "<img src='resource/empty.jpg' style='width: 280px;'>"; 
										}; 
									?>
								</td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td class="result_list_data_data" style="text-align: center">
									<b>Digitalisat</b>
								</td>
							</tr>
						</table>
					</td>
					<!-- original image end -->
				</tr>
				<tr>
					<!-- webcam image 1 -->
					<td class="result_list_data_img" style="width: 200px; height: 200px;">
						<table border="0" cellspacing="0" width="100%">
							<tr>
								<td rowspan="2"><img src="/icons/blank.gif" width="1" height="91"></td>
								<td><img src="/icons/blank.gif" width="121" height="1"></td>
							</tr>
							<tr colspan="2">
								<td style="text-align: center">
									<img src="<?php 
									
									if ($filechecker->hasWebcamImage('fs'))
										echo 'image.php?filename='.$filechecker->getWebcamImageFilename('fs');
									else 
										echo "resource/empty_small.jpg";
									?>" id="webcamFs" style="width: 160px;" onclick="getCameraImage('<?php echo session_id(); ?>','<?php echo trim($_POST['barcode']); ?>','fs');">
								</td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td class="result_list_data_data" style="text-align: center">
									<b>Webcam - Vorderseite</b>
								</td>
							</tr>
						</table>
					</td>
					<!-- webcam image 1 end -->
					
					<!-- webcam image 2 -->
					<td class="result_list_data_img" style="width: 200px; height: 200px;">
						<table border="0" cellspacing="0" width="100%">
							<tr>
								<td rowspan="2"><img src="/icons/blank.gif" width="1" height="91"></td>
								<td><img src="/icons/blank.gif" width="121" height="1"></td>
							</tr>
							<tr colspan="2">
								<td style="text-align: center">
									<img src="<?php 
									
									if ($filechecker->hasWebcamImage('bs'))
										echo 'image.php?filename='.$filechecker->getWebcamImageFilename('bs');
									else 
										echo "resource/empty_small.jpg";
									?>" id="webcamBs" style="width: 160px;" onclick="getCameraImage('<?php echo session_id(); ?>','<?php echo trim($_POST['barcode']); ?>','bs');">
								</td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td class="result_list_data_data" style="text-align: center">
									<b>Webcam - R&uuml;ckseite</b>
								</td>
							</tr>
						</table>
					</td>
					<!-- webcam image 2 end -->
				</tr>
			</table>
			<!-- right side (images) end -->
		</td>
	</tr>
	<!-- content end -->

	<!-- footing line -->
	<tr>
		<td colspan="2">
			<div id="line_1" style="text-align: center; vertical-align: middle; margin-top: 3px;"> 
				<span style="font-size: 0.9em;"><b>Datenerfassung für Bild-Nr. "<?php if(isset($_POST['barcode'])) { echo (trim($_POST['barcode'])); } ?>"</b></span>
			</div>
		</td>
	</tr>
	<!-- footing line end -->
</table>

<script type="text/javascript">
//
// Name
//
var name_data = function( sQuery ) {
    arr = do_getCompletions( "name", sQuery, num );
    return arr;
} 
name_DS = new YAHOO.widget.DS_JSFunction(name_data);
//name_DS.queryMatchContains = true;
//name_DS.maxCacheEntries = num; 

// Instantiate AutoComplete
name_AutoComp = new YAHOO.widget.AutoComplete("name_input","name_container", name_DS);
name_AutoComp.useShadow = true;
name_AutoComp.minQueryLength = 1;
name_AutoComp.queryDelay = 0;
name_AutoComp.maxResultsDisplayed = num;
name_AutoComp.allowBrowserAutocomplete = true; 
name_AutoComp.formatResult = function(oResultItem, sQuery) 
{
    return oResultItem[1];
};
name_AutoComp.doBeforeExpandContainer = function(oTextbox, oContainer, sQuery, aResults) {
    var pos = YAHOO.util.Dom.getXY(oTextbox);
    pos[1] += YAHOO.util.Dom.get(oTextbox).offsetHeight;
    YAHOO.util.Dom.setXY(oContainer,pos);
    return true;
};

//
// Location
//
var location_data = function( sQuery ) {
    arr = do_getCompletions( "location", sQuery, num );
    return arr;
} 
location_DS = new YAHOO.widget.DS_JSFunction(location_data);
//location_DS.queryMatchContains = true;
//location_DS.maxCacheEntries = num; 

// Instantiate AutoComplete
location_AutoComp = new YAHOO.widget.AutoComplete("location_input","location_container", location_DS);
location_AutoComp.useShadow = true;
location_AutoComp.minQueryLength = 1;
location_AutoComp.queryDelay = 0;
location_AutoComp.maxResultsDisplayed = num;
location_AutoComp.allowBrowserAutocomplete = true; 
location_AutoComp.formatResult = function(oResultItem, sQuery) 
{
    return oResultItem[1];
};
location_AutoComp.doBeforeExpandContainer = function(oTextbox, oContainer, sQuery, aResults) {
    var pos = YAHOO.util.Dom.getXY(oTextbox);
    pos[1] += YAHOO.util.Dom.get(oTextbox).offsetHeight;
    YAHOO.util.Dom.setXY(oContainer,pos);
    return true;
};

//
// Institution
//
var institution_data = function( sQuery ) {
    arr = do_getCompletions( "institution", sQuery, num );
    return arr;
} 
institution_DS = new YAHOO.widget.DS_JSFunction(institution_data);
//institution_DS.queryMatchContains = true;
//institution_DS.maxCacheEntries = num; 

// Instantiate AutoComplete
institution_AutoComp = new YAHOO.widget.AutoComplete("institution_input","institution_container", institution_DS);
institution_AutoComp.useShadow = true;
institution_AutoComp.minQueryLength = 1;
institution_AutoComp.queryDelay = 0;
institution_AutoComp.maxResultsDisplayed = num;
institution_AutoComp.allowBrowserAutocomplete = true; 
institution_AutoComp.formatResult = function(oResultItem, sQuery) 
{
    return oResultItem[1];
};
institution_AutoComp.doBeforeExpandContainer = function(oTextbox, oContainer, sQuery, aResults) {
    var pos = YAHOO.util.Dom.getXY(oTextbox);
    pos[1] += YAHOO.util.Dom.get(oTextbox).offsetHeight;
    YAHOO.util.Dom.setXY(oContainer,pos);
    return true;
};

//
// Material
//
var material_data = function( sQuery ) {
    arr = do_getCompletions( "material", sQuery, num );
    return arr;
} 
material_DS = new YAHOO.widget.DS_JSFunction(material_data);
//material_DS.queryMatchContains = true;
//material_DS.maxCacheEntries = num; 

// Instantiate AutoComplete
material_AutoComp = new YAHOO.widget.AutoComplete("material_input","material_container", material_DS);
material_AutoComp.useShadow = true;
material_AutoComp.minQueryLength = 1;
material_AutoComp.queryDelay = 0;
material_AutoComp.maxResultsDisplayed = num;
material_AutoComp.allowBrowserAutocomplete = true; 
material_AutoComp.formatResult = function(oResultItem, sQuery) 
{
    return oResultItem[1];
};
material_AutoComp.doBeforeExpandContainer = function(oTextbox, oContainer, sQuery, aResults) {
    var pos = YAHOO.util.Dom.getXY(oTextbox);
    pos[1] += YAHOO.util.Dom.get(oTextbox).offsetHeight;
    YAHOO.util.Dom.setXY(oContainer,pos);
    return true;
};

//
// Technique
//
var technique_data = function( sQuery ) {
    arr = do_getCompletions( "technique", sQuery, num );
    return arr;
} 
technique_DS = new YAHOO.widget.DS_JSFunction(technique_data);
//technique_DS.queryMatchContains = true;
//technique_DS.maxCacheEntries = num; 

// Instantiate AutoComplete
technique_AutoComp = new YAHOO.widget.AutoComplete("technique_input","technique_container", technique_DS);
technique_AutoComp.useShadow = true;
technique_AutoComp.minQueryLength = 1;
technique_AutoComp.queryDelay = 0;
technique_AutoComp.maxResultsDisplayed = num;
technique_AutoComp.allowBrowserAutocomplete = true; 
technique_AutoComp.formatResult = function(oResultItem, sQuery) 
{
    return oResultItem[1];
};
technique_AutoComp.doBeforeExpandContainer = function(oTextbox, oContainer, sQuery, aResults) {
    var pos = YAHOO.util.Dom.getXY(oTextbox);
    pos[1] += YAHOO.util.Dom.get(oTextbox).offsetHeight;
    YAHOO.util.Dom.setXY(oContainer,pos);
    return true;
};

//
// Literature
//
var literature_data = function( sQuery ) {
    arr = do_getCompletions( "literature", sQuery, num );
    return arr;
} 
literature_DS = new YAHOO.widget.DS_JSFunction(literature_data);
//literature_DS.queryMatchContains = true;
//literature_DS.maxCacheEntries = num; 

// Instantiate AutoComplete
literature_AutoComp = new YAHOO.widget.AutoComplete("literature_input","literature_container", literature_DS);
literature_AutoComp.useShadow = true;
literature_AutoComp.minQueryLength = 1;
literature_AutoComp.queryDelay = 0;
literature_AutoComp.maxResultsDisplayed = num;
literature_AutoComp.allowBrowserAutocomplete = true; 
literature_AutoComp.formatResult = function(oResultItem, sQuery) 
{
    return oResultItem[1];
};
literature_AutoComp.doBeforeExpandContainer = function(oTextbox, oContainer, sQuery, aResults) {
    var pos = YAHOO.util.Dom.getXY(oTextbox);
    pos[1] += YAHOO.util.Dom.get(oTextbox).offsetHeight;
    YAHOO.util.Dom.setXY(oContainer,pos);
    return true;
};


</script>


</form>
</body>
</html>