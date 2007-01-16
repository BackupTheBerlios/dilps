{*
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
*}

<!-- =================================================
BEGIN ac_edit_obj_glass.tpl
================================================= -->

{if $config.utf8 eq "true"}
	{config_load file="`$config.skinBase``$config.skin`/`$config.language`/result.conf.utf8"}
{else}
	{config_load file="`$config.skinBase``$config.skin`/`$config.language`/result.conf"}
{/if}

<html>
<head>
<meta name="robots" content="index,follow">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="cache-control" content="no-cache">
<meta name="keywords" content="Bilddatenbanksystem, Bilddatenbank, Diathek, digitalisiert">

{if $config.utf8 eq 'true'}
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
{else}
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
{/if}

<meta http-equiv="Content-Script-Type" content="text/javascript">
<meta http-equiv="Content-Style-Type" content="text/css">
<meta name="author" content="jrgen enge, thorsten wbbena">
<meta name="date" content="2003-01-23">
<link rel="shortcut icon" href="favicon.ico">
<title>. : DILPS : .</title>
<link rel="stylesheet" type="text/css" href="css.php">
<script src="dilps.lib.js" type="text/javascript"></script>
<script src="include/archaeology/ac_edit.js" type="text/javascript"></script>
</head>

<body class="headerstyle" style="width: 100%; height: 100%; vertical-align: top;">
	<form name="Main" action="{$SCRIPT_NAME}" method="POST" enctype="multipart/form-data">
	<input type="hidden" name="PHPSESSID" value="{$sessionid}">

	{if $query.id ne ""}
	
	{query_ext_element type="archaeology" element="obj_glass" fieldnames="fieldnames" values="values" sql="sql" query=$query}
	
	<!-- {$sql} -->
	
	<script language="javascript">
		var rs_fn 	= "{$fieldnames}";
		var rs_val 	= "{$values}";
		
		js_fn 	= rs_fn.split('; ');
		js_val	= rs_val.split('; ');
	</script>

	<table class="header" style="width: 90%; margin: auto;"/>
		<tr>
			<td class="heading">Glas</td>
		</tr>
		<tr>
			<td style="height: 20px;">
				&nbsp;
			</td>
		</tr>
		<tr>
			<td>
				<b>Technik und Dekor:</b><p>
				<u>Glasart</u>
				<br>
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MStransparent" value="transparent">transparent</td>
					<td><input type="checkbox" name="MSopak" value="opak">opak (undurchsichtig)</td>
					<td><input type="checkbox" name="MStransparentundopak" value="transparent und opak">transparent und opak</td>	
				
				</tr>
				</table>  
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSeinfarbig" value="einfarbig">einfarbig</td>
					<td><input type="checkbox" name="MSmehrfarbig" value="mehrfarbig">mehrfarbig</td>
				</tr>
				</table>  
				<p>
				<u>Herstellungstechnik</u>
				<p>
					<input type="checkbox" name="MSSandkernglas" value="Sandkernglas, Sandkerngl&auml;ser, Sandkerngef&auml;&szlig;e">Sandkernglas<br>
				
					<input type="checkbox" name="MSformgeschmolzenesGlas" value="formgeschmolzenes Glas">formgeschmolzenes Glas
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSMillefioriglas" value="Millefioriglas">Millefioriglas</td>
					<td><input type="checkbox" name="MSMosaikglas" value="Mosaikglas">Mosaikglas</td>
					<td><input type="checkbox" name="MSAchatglas" value="Achatglas">Achatglas</td>
					<td><input type="checkbox" name="MSKameoglas" value="Kameoglas">Kameoglas</td>
				
				</tr>
				</table>  
				<br>
					<input type="checkbox" name="MSgeblasenesGlas" value="geblasenes Glas">geblasenes Glas
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSfreigeblasen" value="frei geblasenes Glas">frei geblasen</td>
					<td><input type="checkbox" name="MSformgeblasen" value="formgeblasenes Glas">formgeblasen</td>
				</tr>
				</table>
				<br>
					<input type="checkbox" name="MSGlasschliff" value="Glasschliff, geschliffenes Glas, Schliffglas">Glasschliff
				
				
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSDiatretglas" value="Diatretglas">Diatretglas</td>
					<td><input type="checkbox" name="MSFacettenglas" value="Facettenglas, Facettenschliff">Facettenglas</td>
					<td><input type="checkbox" name="MSSchnittglas" value="geschliffenes Glas mit fig&uuml;rlichem Dekor, Schnittglas">geschliffenes Glas mit fig&uuml;rlichem Dekor</td>
				</tr>
				</table>  
				<br>
					<input type="checkbox" name="MSGlasauflagen" value="Glasauflagen">Glasauflagen
				
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSFadenglas" value="Fadenglas">Fadenglas</td>
					<td><input type="checkbox" name="MSSchlangenfadenglas" value="Schlangenfadenglas">Schlangenfadenglas</td>
					<td><input type="checkbox" name="MSNuppenglas" value="Nuppenglas">Nuppenglas</td>
				</tr>
				</table>
				<br>
					<input type="checkbox" name="MSGoldglas" value="Goldglas">Goldglas<br>
				
					<input type="checkbox" name="MSZwischengoldglas" value="Zwischengoldglas">Zwischengoldglas<br>
					<input type="checkbox" name="MSbemaltes Glas" value="bemaltes Glas">bemaltes Glas<p>
				<br>
				
				<hr>
				
				<b>Form:</b><p>
				<i>Angaben zu plastischem und fig&uuml;rlichem Glas (au&szlig;er zu Figurengef&auml;&szlig;en) bitte unter Plastik oder Schmuck machen.</i><p>
				
				<u>Gef&auml;&szlig;e:</u>
				
				<ul>	<input type="checkbox" name="MSAcetabulumG" value="Acetabulum (Glas)">Acetabulum<br>
					<input type="checkbox" name="MSAlabastronG" value="Alabastron, Alabastra (Glas)">Alabastron<br>
					<input type="checkbox" name="MSAmphoraG" value="Amphora, Amphore (Glas)">Amphora
				<ul>		<input type="checkbox" name="MSAmphoriskosG" value="Amphoriskos (Glas)">Amphoriskos</ul>
					<input type="checkbox" name="MSAmpullaG" value="Ampulla (Glas)">Ampulla<br>
				
					<input type="checkbox" name="MSAryballosG" value="Aryballos (Glas)">Aryballos<br>
					<input type="checkbox" name="MSBalsamariumG" value="Balsamarium (Glas)">Balsamarium ("Tr&auml;nenfl&auml;schchen")
				<ul>		<input type="checkbox" name="MSZwillingsbalsamariumG" value="Zwillingsbalsamarium (Glas)">Zwillingsbalsamarium</ul>
					<input type="checkbox" name="MSBecherG" value="Becher (Glas)">Becher
				<ul>		<input type="checkbox" name="MSKugelbecherG" value="Kugelbecher (Glas)">Kugelbecher<br>
						<input type="checkbox" name="MSSturzbecherG" value="Sturzbecher (Glas)">Sturzbecher<br>
				
						<input type="checkbox" name="MSZweihenkelbecherG" value="Zweihenkelbecher (Glas)">Zweihenkelbecher<br>
						<input type="checkbox" name="MSDreihenkelbecherG" value="Dreihenkelbecher (Glas)">Dreihenkelbecher<p>
						<input type="checkbox" name="MSR&uuml;sselbecherG" value="R&uuml;sselbecher (Glas)">R&uuml;sselbecher<br>
						<input type="checkbox" name="MSFacettenbecherG" value="Facettenbecher (Glas)">Facettenbecher<br>
						<input type="checkbox" name="MSGladiatorenbecherG" value="Gladiatorenbecher (Glas)">Gladiatorenbecher<br>
						<input type="checkbox" name="MSZirkusbecherG" value="Zirkusbecher (Glas)">Zirkusbecher</ul>
				
					<input type="checkbox" name="MSFigurengef&auml;&szlig;G" value="Figurengef&auml;&szlig; (Glas)">Figurengef&auml;&szlig;<br>
					<input type="checkbox" name="MSFlascheG" value="Flasche (Glas)">Flasche
				<ul>		<input type="checkbox" name="MSHenkelflascheG" value="Henkelflasche (Glas)">Henkelflasche<p>
						<input type="checkbox" name="MSDattelflascheG" value="Dattelflasche (Glas)">Dattelflasche<br>
						<input type="checkbox" name="MSDelphinflascheG" value="Delphinflasche (Glas)">Delphinflasche<br>
						<input type="checkbox" name="MSKopfflascheG" value="Kopfflasche (Glas)">Kopfflasche
				<ul>			<input type="checkbox" name="MSDoppelkopfflascheG" value="Doppelkopfflasche (Glas)">Doppelkopfflasche</ul>
				
						<input type="checkbox" name="MSKugelflascheG" value="Kugelflasche (Glas)">Kugelflasche<br>
						<input type="checkbox" name="MSLinsenflascheG" value="Linsenflasche (Glas)">Linsenflasche<br>
						<input type="checkbox" name="MSNetzflascheG" value="Netzflasche (Glas)">Netzflasche<br>
						<input type="checkbox" name="MSPilgerflascheG" value="Pilgerflasche (Glas)">Pilgerflasche<br>
						<input type="checkbox" name="MSStachelflascheG" value="Stachelflasche (Glas)">Stachelflasche<br>
						<input type="checkbox" name="MSTaubenfl&auml;schchenG" value="Taubenfl&auml;schchen (Glas)">Taubenfl&auml;schchen<br>
				
						<input type="checkbox" name="MSTraubenflascheG" value="Traubenflasche (Glas)">Traubenflasche<br>
						<input type="checkbox" name="MSTrichterflascheG" value="Trichterflasche (Glas)">Trichterflasche</ul>
					<input type="checkbox" name="MSGutturniumG" value="Gutturnium (Glas)">Gutturnium<br>
					<input type="checkbox" name="MSKanneG" value="Kanne (Glas)">Kanne
				<ul>		<input type="checkbox" name="MSFa&szlig;kanneG" value="Fa&szlig;kanne (Glas)">Fa&szlig;kanne</ul>
					<input type="checkbox" name="MSKelchG" value="Kelch (Glas)">Kelch<br>
				
					<input type="checkbox" name="MSLampeG" value="Lampe (Glas)">Lampe<br>
					<input type="checkbox" name="MSModiulusG" value="Modiulus (Glas)">Modiulus<br>
					<input type="checkbox" name="MSNapfG" value="Napf (Glas)">Napf<br>
					<input type="checkbox" name="MSOllaG" value="Olla (Glas)">Olla<br>
					<input type="checkbox" name="MSPlatteG" value="Platte (Glas)">Platte<br>
					<input type="checkbox" name="MSPyxisG" value="Pyxis (Glas)">Pyxis<br>
				
					<input type="checkbox" name="MSSchaleG" value="Schale (Glas)">Schale
				<ul>		<input type="checkbox" name="MSFacettenschaleG" value="Facettenschale (Glas)">Facettenschale<br>
						<input type="checkbox" name="MSRippenschaleG" value="Rippenschale (Glas)">Rippenschale<br>
						<input type="checkbox" name="MSzarteRippenschaleG" value="zarte Rippenschale (Glas)">zarte Rippenschale</ul>
					<input type="checkbox" name="MSSkyphosG" value="Skyphos (Glas)">Skyphos<br>
					<input type="checkbox" name="MSTellerG" value="Teller (Glas)">Teller<br>
				
					<input type="checkbox" name="MSUnguentariumG" value="Unguentarium (Glas)">Unguentarium</ul>
				<p>
					<b>weitere Angaben:</b><br>
					<textarea name="MSGlasText" rows="2" cols="40">Glas, </textarea>
			</td>
		</tr>
		<tr>
			<td style="height: 20px;">
				&nbsp;
			</td>
		</tr>
		<tr>
			<td>
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
					<tr>
						<td><input type="button" value="eingeben" onclick="saveSelection('obj_glass');history.back();"></td>
						<td><input type="button" value="zur&uuml;cksetzen" onclick="restoreState(js_fn, js_val);"></td>
						<td><input type="reset" value="alle l&ouml;schen"></td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<input type="hidden" name="step" value="1">
</form>

<script language="javascript">
	restoreState(js_fn, js_val);
</script>


{/if}

</body>
</html>

<!-- =================================================
END ac_edit_obj_glass.tpl
================================================= -->
