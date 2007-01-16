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
BEGIN ac_edit_obj_glyptics.tpl
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
	
	{query_ext_element type="archaeology" element="obj_glyptics" fieldnames="fieldnames" values="values" sql="sql" query=$query}
	
	<!-- {$sql} -->
	
	<script language="javascript">
		var rs_fn 	= "{$fieldnames}";
		var rs_val 	= "{$values}";
		
		js_fn 	= rs_fn.split('; ');
		js_val	= rs_val.split('; ');
	</script>

	<table class="header" style="width: 90%; margin: auto;"/>
		<tr>
			<td class="heading">Glyptik</td>
		</tr>
		<tr>
			<td style="height: 20px;">
				&nbsp;
			</td>
		</tr>
		<tr>
			<td>
				<b>Gattung</b>
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSGemme" value="Gemmen, Intaglio">Gemme/Intaglio</td>
					<td>eingetieftes Relief</td>
				</tr>
				<tr>
					<td><input type="checkbox" name="MSKameo" value="Kameo, Kameen">Kameo</td>
				
					<td>erhabenes Relief</td>
				</tr>
				<tr>
					<td><input type="checkbox" name="MSGlaspaste" value="Glaspasten">Glaspaste</td>
				</tr>
				</table>  
				<br>
					<u>spezielle Gruppenbezeichnung:</u><br>
					<i>nur Beispiele, genauere Bezeichnungen bitte unten eintragen.</i>
				
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSInselstein" value="Inselsteine, Inselgemmen">Inselstein, Inselgemme</td>
					<td><input type="checkbox" name="MSmagische Gemme" value="magische Gemmen">magische Gemme</td>
				</tr>
				</table>  
				<br>
					<b>Form</b><br>
					<i>Die Angabe bezieht sich nur auf den Stein und nicht auf die Fassung.</i>
				
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSDiskos" value="Diskos">Diskos</td>
					<td><input type="checkbox" name="MSLentoid" value="Lentoid">Lentoid</td>
					<td><input type="checkbox" name="MSKonoid" value="Konoid">Konoid</td>
					<td><input type="checkbox" name="MSAmygdaloid" value="Amygdaloid">Amygdaloid</td>
				</tr>
				<tr>
					<td><input type="checkbox" name="MSQuader" value="Quader">Quader</td>
				
					<td><input type="checkbox" name="MSPyramide" value="Pyramide">Pyramide</td>
					<td><input type="checkbox" name="MSPrisma" value="Prisma">Prisma</td>
					<td><input type="checkbox" name="MSPolyeder" value="Polyeder">Polyeder</td>
					<td><input type="checkbox" name="MSSpule" value="Spule">Spule</td>
					<td><input type="checkbox" name="MSZylinder" value="Zylinder">Zylinder</td>
				</tr>
				<tr>
				
					<td><input type="checkbox" name="MSTiersiegel" value="Tiersiegel">Tiersiegel</td>
					<td><input type="checkbox" name="MSSkarab&auml;us" value="Skarab&auml;us">Skarab&auml;us</td>
					<td><input type="checkbox" name="MSSkarab&auml;oid" value="Skarab&auml;oid">Skarab&auml;oid</td>
					<td><input type="checkbox" name="MSFu&szlig;amulett" value="Fu&szlig;amulett">Fu&szlig;amulett</td>
					<td><input type="checkbox" name="MSGesichtssiegel" value="Gesichtssiegel">Gesichtssiegel</td>
				
					<td><input type="checkbox" name="MSKopfsiegel" value="Kopfsiegel">Kopfsiegel</td>
				</tr>
				<tr>
					<td><input type="checkbox" name="MSRollsiegel" value="Rollsiegel">Rollsiegel</td>
					<td><input type="checkbox" name="MSPetschaft" value="Petschaft">Petschaft</td>
					<td><input type="checkbox" name="MSPlattemitGriff" value="Platte mit Griff">Platte mit Griff</td>
					<td><input type="checkbox" name="MSKnopfGl" value="Knopf">Knopf</td>
				
				</tr>
				</table>  
				<br>
					<b>Stil/Technik</b>
				
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSaglobolo" value="a globolo">a globolo</td>
				</tr>
				</table>  
				<br>
					<b>Verwendung</b>
				
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSSiegel" value="Siegel">Siegel</td>
					<td><input type="checkbox" name="MSSiegelring" value="Siegelringe, Ringfassung">Siegelring</td>
					<td><input type="checkbox" name="MSAmulett" value="Amulette">Amulett</td>
					<td><input type="checkbox" name="MSEinlage" value="MSEinlage">Einlage</td>
				</tr>
				</table>  
				<p>
				<b>spezifischere Angaben:</b><br>
				<textarea name="MSGlyptikText" rows="2" cols="40">Glyptik, </textarea>
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
						<td><input type="button" value="eingeben" onclick="saveSelection('obj_glyptics');history.back();"></td>
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
END ac_edit_obj_glyptics.tpl
================================================= -->
