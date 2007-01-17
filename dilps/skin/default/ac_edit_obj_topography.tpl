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
BEGIN ac_edit_obj_topography.tpl
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
	
	{query_ext_element type="archaeology" element="obj_topography" fieldnames="fieldnames" values="values" sql="sql" query=$query}
	
	<!-- {$sql} -->
	
	<script language="javascript">
		var rs_fn 	= "{$fieldnames}";
		var rs_val 	= "{$values}";
		
		js_fn 	= rs_fn.split('; ');
		js_val	= rs_val.split('; ');
	</script>
	
	<input type="hidden" name="imageid" value="{$query.id}">

	<table class="header" style="width: 90%; margin: auto;"/>
		<tr>
			<td class="heading">Bildkategorie</td>
		</tr>
		<tr>
			<td style="height: 20px;">
				&nbsp;
			</td>
		</tr>
		<tr>
			<td>
				<input type="checkbox" name="MSTopographie" value="Topographie"><b>Topographie</b>
				<p>
				<i>nat&uuml;rliches Gel&auml;nde</i>
				
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSFestland" value="Festland">Festland</td>
					<td><input type="checkbox" name="MSInsel" value="Insel">Insel</td>
					<td><input type="checkbox" name="MSEbene" value="Ebene">Ebene</td>
					<td><input type="checkbox" name="MSBerg" value="Berg">Berg</td>
					<td><input type="checkbox" name="MSBach" value="Bach">Bach</td>
				
					<td><input type="checkbox" name="MSSee" value="See">See</td>
				</tr>
				<tr>
					<td><input type="checkbox" name="MSK&uuml;ste" value="K&uuml;ste">K&uuml;ste</td>
					<td><input type="checkbox" name="MSHalbinsel" value="Halbinsel">Halbinsel</td>
					<td><input type="checkbox" name="MSTal" value="Tal">Tal</td>
					<td><input type="checkbox" name="MSH&uuml;gel" value="H&uuml;gel">H&uuml;gel</td>
				
					<td><input type="checkbox" name="MSFlu&szlig;" value="Flu&szlig;">Flu&szlig;</td>
					<td><input type="checkbox" name="MSMeer" value="Meer">Meer</td>
				</tr>
				</table>	
				<p>
				
				<i>menschliche Ver&auml;nderungen</i>
				
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="Grenze" value="Grenze">Grenze</td>
				
					<td><input type="checkbox" name="Stra&szlig;e2" value="Landstra&szlig;e, Fernstra&szlig;e">Landstra&szlig;e/Fernstra&szlig;e</td>
					<td><input type="checkbox" name="Steinbruch" value="Steinbruch">Steinbruch</td>
				</tr>
				<tr>
					<td><input type="checkbox" name="Grenzstein" value="Grenzstein">Grenzstein</td>
					<td><input type="checkbox" name="Meilenstein" value="Meilenstein">Meilenstein</td>
					<td><input type="checkbox" name="Bergwerk" value="Bergwerk">Bergwerk</td>
				
				</tr>
				</table>  
				
				<hr>
				<input type="checkbox" name="MSUrbanistik" value="Urbanistik"><b>Urbanistik</b><p>
				
					<input type="checkbox" name="Stadt" value="Stadt">Stadt
					
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSAkropolis" value="Akropolis">Akropolis</td>
					<td><input type="checkbox" name="MSStra&szlig;e1" value="Stra&szlig;e">Stra&szlig;e     </td>
				
					<td><input type="checkbox" name="MSWohnviertel1" value="Wohnviertel, Wohnquartier">Wohnviertel</td>
					<td><input type="checkbox" name="MSHaus" value="Wohnhaus, Haus">Haus</td>
				</tr>
				<tr>
					<td><input type="checkbox" name="MSBefestigung" value="Befestigung">Befestigung</td>
					<td><input type="checkbox" name="MSPlatz" value="Platz">Platz</td>
					<td><input type="checkbox" name="MSHandwerkerviertel" value="Handwerkerviertel">Handwerkerviertel</td>
				
					<td><input type="checkbox" name="MSInsula" value="Insula">Insula</td>	
				</tr>
				</table>
				<br>
				
					<input type="checkbox" name="MSl&auml;ndliche Umgebung" value="l&auml;ndliche Umgebung">l&auml;ndliche Umgebung
				
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSGarten" value="Garten">Garten</td>
					<td><input type="checkbox" name="MSHain" value="Hain">Hain</td>
				
					<td><input type="checkbox" name="MSPark" value="Park">Park</td>
				</tr>
				<tr>
					<td><input type="checkbox" name="MSGeh&ouml;ft" value="Geh&ouml;ft">Geh&ouml;ft</td>
					<td><input type="checkbox" name="MSLandgut" value="Landgut">Landgut</td>
					<td><input type="checkbox" name="MSVilla" value="Villa">Villa</td>
				</tr>
				</table>  
				
				<br>
					
				<input type="checkbox" name="MSHafenanlage1" value="Hafen, Hafenanlage">Hafenanlage<p>
				<input type="checkbox" name="MSHeiligtum1" value="Heiligtum">Heiligtum<p>
				<input type="checkbox" name="MSNekropole1" value="Nekropole, Friedhof">Nekropole<p>
			
				<b>anderer Zusammenhang oder genauere Bezeichnung:</b><br>
				<textarea name="MSTopographieText" rows="2" cols="40"></textarea>
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
						<td><input type="button" value="eingeben" onclick="saveSelection('obj_topography');history.back();"></td>
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
END ac_edit_obj_topography.tpl
================================================= -->
