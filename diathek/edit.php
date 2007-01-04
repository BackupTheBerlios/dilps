<?php
	// include_once( 'session.inc.php' );
	include( 'db.inc.php' );
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
	<meta name="author" content="jrgen enge, thorsten wbbena">
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
	
</head>
<body class="main" style="width: 100%;">
<form name="Main" action="index.php" method="post" style="width: 100%;">

<script type="text/javascript">

var remoteHW = new DilpsAcquisitionAJAX();

var num = 20;

function do_getTitles( field, sQuery, num )
{
    return remoteHW.getTitles( field, sQuery, num );
}

function do_getNames( field, sQuery, num )
{
    return remoteHW.getNames( field, sQuery, num );
}

function do_getLocations( field, sQuery, num )
{
    return remoteHW.getLocations( field, sQuery, num );
}

</script> 

<body>
<form name="main" method="get" action="<?=$_SERVER['PHP_SELF'] ?>">


<table class="header" style="width: 100%;">
	<!-- back link -->
	<tr>
		<td colspan="2">
			&nbsp;<a href="index.php" style="text-decoration: underline;"><b>Zur&uuml;ck zur Barcode-Erfassung</b></a>
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
	
	<!-- content -->
	<tr>
		<td style="vertical-align: top; width: 50%">
			<!-- left side (form fields) -->
			<table class="query" cellspacing="0" cellpadding="0" style="width: 90%; vertical-align: top;">
				<tr>
					<td class="queryinputfieldtext">
						<label for="title_mod">Titel</label>
					</td>
					<td class="queryinputfield">
												
						<!-- autocomplete title -->
						<div id="title_mod">
							<input id="title_input" class="queryinputfield" type="text" name="title" size="80" value="">
						    <div id="title_container"></div>
						</div>
						<!-- autocomplete title end -->
					</td>
				</tr>
				<tr>
					<td class="queryinputfieldtext">
						<label for="name_mod">Name</label>
					</td>
					<td class="queryinputfield">
						<!-- autocomplete name -->
						<div id="name_mod">
							<input id="name_input" class="queryinputfield" type="text" name="name" size="80" value="">
						    <div id="name_container"></div>
						</div>
						<!-- autocomplete name end -->
					</td>
				</tr>
				<tr>
					<td class="queryinputfieldtext">
						Datierung
					</td>
					<td class="queryinputfield">
						<input class="queryinputfield" type="text" name="dating" size="80" value="">
					</td>
				</tr>
				<tr>
					<td class="queryinputfieldtext">
						<label for="location_mod">Ort</label>
					</td>
					<td class="queryinputfield">
						<!-- autocomplete name -->
						<div id="location_mod">
							<input id="location_input" class="queryinputfield" type="text" name="location" size="80" value="">
						    <div id="location_container"></div>
						</div>
						<!-- autocomplete name end -->
					</td>
				</tr>
				<tr>
					<td class="queryinputfieldtext">
						Institution
					</td>
					<td class="queryinputfield">
						<input class="queryinputfield" type="text" name="institution" size="80" value="">
					</td>
				</tr>
				<tr>
					<td class="queryinputfieldtext">
						Quelle
					</td>
					<td class="queryinputfield">
						<input class="queryinputfield" type="text" name="literature" size="80" value="">
					</td>
				</tr>
				<tr>
					<td class="queryinputfieldtext">
						Seite
					</td>
					<td class="queryinputfield">
						<input class="queryinputfield" type="text" name="page" size="80" value="">
					</td>
				</tr>
				<tr>
					<td class="queryinputfieldtext">
						Abbildung
					</td>
					<td class="queryinputfield">
						<input class="queryinputfield" type="text" name="figure" size="80" value="">
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
				</tr>
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
								<td style="text-align: center"><img src="image.php?id="></td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td class="result_list_data_data" style="text-align: center">
									<b>Hauptbild</b>
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
								<td style="text-align: center"><img src="image.php?id="></td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td class="result_list_data_data" style="text-align: center">
									<b>Webcam Bild 1</b>
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
								<td style="text-align: center"><img src="image.php?id="></td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td class="result_list_data_data" style="text-align: center">
									<b>Webcam Bild 2</b>
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
				<span style="font-size: 0.9em;"><b>Datenerfassung für Bild-Nr. "Barcode hier"</b></span>
			</div>
		</td>
	</tr>
	<!-- footing line end -->
</table>

<script type="text/javascript">
//
// Title
//
var title_data = function( sQuery ) {
    arr = do_getNames( "signatur", sQuery, num );
    return arr;
} 
title_DS = new YAHOO.widget.DS_JSFunction(title_data);
//name_DS.queryMatchContains = true;
//name_DS.maxCacheEntries = num; 

// Instantiate AutoComplete
title_AutoComp = new YAHOO.widget.AutoComplete("title_input","title_container", title_DS);
title_AutoComp.useShadow = true;
title_AutoComp.minQueryLength = 1;
title_AutoComp.queryDelay = 0;
title_AutoComp.maxResultsDisplayed = num;
title_AutoComp.allowBrowserAutocomplete = true; 
title_AutoComp.formatResult = function(oResultItem, sQuery) 
{
    return oResultItem[1];
};
title_AutoComp.doBeforeExpandContainer = function(oTextbox, oContainer, sQuery, aResults) {
    var pos = YAHOO.util.Dom.getXY(oTextbox);
    pos[1] += YAHOO.util.Dom.get(oTextbox).offsetHeight;
    YAHOO.util.Dom.setXY(oContainer,pos);
    return true;
};

//
// Name
//
var name_data = function( sQuery ) {
    arr = do_getNames( "name1", sQuery, num );
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
    arr = do_getLocations( "name1", sQuery, num );
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
</script>


</form>
</body>
</html>