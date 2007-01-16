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
BEGIN ac_edit_obj_arch_economy.tpl
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
	
	{query_ext_element type="archaeology" element="obj_arch_economy" fieldnames="fieldnames" values="values" sql="sql" query=$query}
	
	<!-- {$sql} -->
	
	<script language="javascript">
		var rs_fn 	= "{$fieldnames}";
		var rs_val 	= "{$values}";
		
		js_fn 	= rs_fn.split('; ');
		js_val	= rs_val.split('; ');
	</script>

	<table class="header" style="width: 90%; margin: auto;"/>
		<tr>
			<td class="heading">Wirtschaft, Transport und Verkehr</td>
		</tr>
		<tr>
			<td style="height: 20px;">
				&nbsp;
			</td>
		</tr>
		<tr>
			<td>
				<input type="checkbox" name="MSWirtschaft" value="Wirtschaft">Wirtschaft
				
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSMarkt" value="Markt">Markt</td>
					<td><input type="checkbox" name="MSMacellum" value="Macellum">Macellum</td>
					<td><input type="checkbox" name="MSHorreum" value="Lagerhaus, Horreum, Speicher">Lagerhaus/Horreum/Speicher</td>
				
				</tr>
				</table><br>
				
					<input type="checkbox" name="MSTransport" value="Transport, Verkehr">Transport und Verkehr
				
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSBr&uuml;cke" value="Br&uuml;cke">Br&uuml;cke</td>
					<td><input type="checkbox" name="MSPlatz" value="PLatz, Platzanlage">Platz</td>
					<td><input type="checkbox" name="MSHafen" value="Hafen, Hafenanlage">Hafenanlage</td>
				
				</tr>
				<tr>
					<td><input type="checkbox" name="MSLandstra&szlig;e" value="Landstra&szlig;e">Landstra&szlig;e</td>
					<td><input type="checkbox" name="MSAgora" value="Agora">Agora</td>
					<td><input type="checkbox" name="MSKanal" value="Kanal">Kanal</td>
				</tr>
				<tr>
					<td><input type="checkbox" name="MSStra&szlig;e" value="Stra&szlig;e (st&auml;dtisch)">Stra&szlig;e (st&auml;dtisch)</td>
				
					<td><input type="checkbox" name="MSForum" value="Forum, Forumsanlage">Forum</td>
					<td><input type="checkbox" name="MSSchiffshaus" value="Schiffshaus">Schiffshaus</td>
				</tr>
				<tr>
					<td><input type="checkbox" name="MSGasse" value="Gasse">Gasse</td>
					<td></td>
					<td><input type="checkbox" name="MSWerft" value="Werftanlage">Werftanlage</td>
				</tr>
				
				<tr>
					<td><input type="checkbox" name="MSS&auml;ulenstra&szlig;e" value="S&auml;ulenstra&szlig;e">S&auml;ulenstra&szlig;e</td>
				</tr>
				<tr>
					<td><input type="checkbox" name="MSStra&szlig;enkreuzung" value="Stra&szlig;enkreuzung">Stra&szlig;enkreuzung</td>
				</tr>
				</table>
				<br>
				
					<input type="checkbox" name="MSVersorgung" value="Verorgung, Entsorgung">Versorgung/Entsorgung
				
				
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSAquaedukt" value="Aquaedukt, Wasserleitung">Aquaedukt/Wasserleitung</td>
					<td><input type="checkbox" name="MSBrunnen" value="Brunnen">Brunnen</td>
					<td><input type="checkbox" name="MSLatrine" value="Latrine, Latrina">Latrine</td>
				</tr>
				<tr>
					<td><input type="checkbox" name="MSZisterne" value="Zisterne, Cistene">Zisterne</td>
					<td><input type="checkbox" name="MSBrunnenhaus" value="Brunnenhaus">Brunnenhaus</td>
				
					<td><input type="checkbox" name="MSAbwasser" value="Abwasserkanal, Kloake, Cloaca, Kanalisation">Kanalisation</td>
				</tr>
				</table>
				<br>
					<b>Andere Geb&auml;udetypen und Geb&auml;udeteile:</b><br>
					<textarea name="MSArchitekturWirtschaftText" rows="1" cols="40"></textarea>
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
						<td><input type="button" value="eingeben" onclick="saveSelection('obj_arch_economy');history.back();"></td>
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
END ac_edit_obj_arch_economy.tpl
================================================= -->
