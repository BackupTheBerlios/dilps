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
BEGIN ac_edit_obj_arch_amusement.tpl
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
	
	{query_ext_element type="archaeology" element="obj_arch_amusement" fieldnames="fieldnames" values="values" sql="sql" query=$query}
	
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
			<td class="heading">Unterhaltung/Sport/Thermen</td>
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
					<td><input type="checkbox" name="MSAmphitheater" value="Amphitheater">Amphitheater</td>
					<td><input type="checkbox" name="MSArena" value="Arena">Arena</td>
					<td><input type="checkbox" name="MSZirkus" value="Cirkus, Zirkus">Circus</td>
				
				</tr>
				<tr>
					<td><input type="checkbox" name="MSPal&auml;stra" value="Pal&auml;stra, Palaistra">Pal&auml;stra</td>
					<td><input type="checkbox" name="MSGymnasion" value="Gymnasion, Gymnasium">Gymnasion</td>
					<td><input type="checkbox" name="MSStadion" value="Stadion">Stadion</td>
					<td><input type="checkbox" name="MSHippodrom" value="Hippodrom, Rennbahn, Pferderennbahn">Hippodrom</td>
				</tr>
				<tr>
				
					<td><input type="checkbox" name="MSBibliothek" value="Bibliothek">Bibliothek</td>
					<td><input type="checkbox" name="MSOdeion" value="Odeion">Odeion</td>
				</tr>
				</table>  
				
				<hr>
				
					<input type="checkbox" name="MSTheater" value="Theater"><b>Theater</b><p>
					<input type="checkbox" name="MSgriechischesTheater" value="griechisches Theater"><u>Griechisches Theater</u><br>
					Teile:<br>
				
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSKoilon" value="Koilon, Zuschauerraum">Koilon/Zuschauerraum</td>
					<td><input type="checkbox" name="MSOrchestra1" value="Orchestra">Orchestra</td>
					<td><input type="checkbox" name="MSParodos" value="Parodos">Parodos</td>
				</tr>
				<tr>
					<td><input type="checkbox" name="MSDiazoma" value="Diazoma, Umgang">Diazoma/Umgang</td>
				
					<td><input type="checkbox" name="MSProskenion" value="Proskenion, B&uuml;hne">Proskenion/B&uuml;hne</td>
					<td><input type="checkbox" name="MSSkene" value="Skene, B&uuml;hnengeb&auml;ude">Skene/B&uuml;hnengeb&auml;ude</td>
				</tr>
				</table>  
				<br>
					<input type="checkbox" name="MSR&ouml;mischesTheater" value="r&ouml;misches Theater"><u>R&ouml;misches Theater</u><br>
					Teile:<br>
				
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				
				<tr>
					<td><input type="checkbox" name="MSCavea" value="Cavea, Zuschauerraum">Cavea/Zuschauerraum</td>
					<td><input type="checkbox" name="MSPraecinctio" value="Praecinctio, Umgang">Praecinctio/Umgang</td>
					<td><input type="checkbox" name="MSProscaenium" value="Proscaenium, B&uuml;hne">Proscaenium/B&uuml;hne</td>
					<td><input type="checkbox" name="MSScenaefrons" value="Scenae frons, B&uuml;hnenfassade">Scenae frons/B&uuml;hnenfassade</td>
				
				</tr>
				<tr>
					<td><input type="checkbox" name="MSCuneus" value="Cuneus, Sitzreihenkeil">Cuneus/Sitzreihenkeil</td>
					<td><input type="checkbox" name="MSOrchestra2" value="Orchestra">Orchestra</td>
					<td><input type="checkbox" name="MSScenae" value="Scenae, Skene">Scenae</td>
				</tr>
				</table>  
				<br>
				<hr>
				
					<input type="checkbox" name="MSTherme" value="Therme, Thermenanlage"><b>Therme/Thermenanlage</b><br>
				
					
					Teile:<br>
				
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSVestibulum2" value="Vestibulum, Vestib&uuml;l">Vestibulum/Vestib&uuml;l (Vorraum)</td>
					<td><input type="checkbox" name="MSFrigidarium" value="Frigidarium, Kaltwasserraum, Kaltbaderaum">Frigidarium (Kaltwasserraum)</td>
					<td><input type="checkbox" name="MSCaldarium" value="Caldarium, Warmwasserraum, Warmbaderaum">Caldarium (Hei&szlig;wasserraum)</td>
				
					<td><input type="checkbox" name="MSNatatio" value="Natatio, Schwimmbad">Natatio (Schwimmbad)</td>
				</tr>
				<tr>
					<td><input type="checkbox" name="MSApodyterium" value="Apodyterium, Umkleideraum">Apodyterium (Umkleideraum)</td>
					<td><input type="checkbox" name="MSTepidarium" value="Tepidarium">Tepidarium (lauwarmer Raum)</td>
					<td><input type="checkbox" name="MSSudatorium" value="Sudatorium, Schwitzraum">Sudatorium (Schwitzraum)</td>
				</tr>
				</table>  	
				<br>
				
					<b>anderer Geb&auml;udetyp oder Geb&auml;udeteil:</b><br>
					<textarea name="MSArchitekturUnterhaltungText" rows="2" cols="40"></textarea>
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
						<td><input type="button" value="eingeben" onclick="saveSelection('obj_arch_amusement');history.back();"></td>
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
END ac_edit_obj_arch_amusement.tpl
================================================= -->
