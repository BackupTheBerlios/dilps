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
BEGIN ac_edit_obj_toreutics.tpl
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
<meta name="author" content="juergen enge, thorsten wuebbena, sebastian doeweling">
<meta name="date" content="2003-01-23">
<link rel="shortcut icon" href="favicon.ico">
<title>. : DILPS : .</title>
<link rel="stylesheet" type="text/css" href="css.php">
<script src="dilps.lib.js" type="text/javascript"></script>
<script src="include/extended/ext_edit.js" type="text/javascript"></script>
</head>

<body class="headerstyle" style="width: 100%; height: 100%; vertical-align: top;">
	<form name="Main" action="{$SCRIPT_NAME}" method="POST" enctype="multipart/form-data">
	<input type="hidden" name="PHPSESSID" value="{$sessionid}">

	{if $query.id ne ""}
	
	{query_ext_element type="archaeology" element="obj_toreutics" fieldnames="fieldnames" values="values" sql="sql" query=$query}
	
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
			<td class="heading">Toreutik</td>
		</tr>
		<tr>
			<td style="height: 20px;">
				&nbsp;
			</td>
		</tr>
		<tr>
			<td>
				<i>&Uuml;berschneidungen mit anderen Bereichen wie z.B. Plastik oder Schmuck sind m&ouml;glich!<br>
					Spezielle Typenbezeichnungen bitte immer unten eintragen.</i><p>
				
					<b>Ger&auml;te</b>
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
				
					<td><input type="checkbox" name="MSL&ouml;ffel" value="L&ouml;ffel">L&ouml;ffel</td>
					<td><input type="checkbox" name="MSSieb" value="Siebe">Sieb</td>
					<td><input type="checkbox" name="MSKelle" value="Kellen">Kelle (mit waagerechtem Griff)</td>
					<td><input type="checkbox" name="MSSch&ouml;pfer" value="Sch&ouml;pfer">Sch&ouml;pfer (mit senkrechtem Griff)</td>
				</tr>
				<tr>
					<td><input type="checkbox" name="MSSpiegel" value="Spiegel">Spiegel</td>
				
					<td><input type="checkbox" name="MSStrigilis" value="Strigilis, Strigiles">Strigilis</td>
				</tr>
				<tr>
					<td><input type="checkbox" name="MSGlocke" value="Glocken">Glocke</td>
				</tr>
				<tr>
					<td><input type="checkbox" name="MSLampeBr" value="Lampen, Bronze">Lampe</td>
					<td><input type="checkbox" name="MSKandelaber" value="Kandelaber">Kandelaber</td>
					<td><input type="checkbox" name="MSThymiaterion" value="Thymiaterion, Thymiateria">Thymiaterion</td>
				
				</tr>
				</table>
				<br>
				
					<b>Gef&auml;&szlig;e</b>
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSKesselMe" value="Kessel, Metall">Kessel</td>
					<td><input type="checkbox" name="MSDreifu&szlig;kesselMe" value="Dreifu&szlig;kessel, Metall">Dreifu&szlig;kessel</td>
				
					<td><input type="checkbox" name="MSKraterMe" value="Kratere, Metall">Krater</td>
				</tr>
				<tr>
					<td><input type="checkbox" name="MSEimerMe" value="Eimer, Metall">Eimer</td>
					<td><input type="checkbox" name="MSHemmoorerEimer" value="Hemmoorer Eimer">Hemmoorer Eimer</td>
					<td><input type="checkbox" name="MSCiste" value="Cisten">Ciste</td>
					<td><input type="checkbox" name="MSRippenciste" value="Rippencisten">Rippenciste</td>
				
					<td><input type="checkbox" name="MSSitula" value="Situlae">Situla</td>
				</tr>
				<tr>
					<td><input type="checkbox" name="MSAmphoraMe" value="Amphora, Amphoren, Metall">Amphora</td>
					<td><input type="checkbox" name="MSKanneMe" value="Kannen, Metall">Kanne</td>
					<td><input type="checkbox" name="MSSchnabelkanne" value="Schnabelkannen">Schnabelkanne</td>
					<td><input type="checkbox" name="MSFlascheMe" value="Flasche, Metall">Flasche</td>
				
				</tr>
				<tr>
					<td><input type="checkbox" name="MSKasserole" value="Griffschalen, Kasserolen">Griffschale/Kasserole</td>
					<td><input type="checkbox" name="MSPatera" value="Patera, Metall">Patera</td>
					<td><input type="checkbox" name="MSSchaleMe" value="Schalen, Metall">Schale</td>
					<td><input type="checkbox" name="MSSch&uuml;sselMe" value="Sch&uuml;ssel, Metall">Sch&uuml;ssel</td>
					<td><input type="checkbox" name="MSKragensch&uuml;ssel" value="Kragensch&uuml;sseln">Kragensch&uuml;ssel</td>
				
					<td><input type="checkbox" name="MSBeckenMe" value="Becken, Metall">Becken</td>
				</tr>
				<tr>
					<td><input type="checkbox" name="MSKantharosMe" value="Kantharos, Kantharoi, Metall">Kantharos</td>
					<td><input type="checkbox" name="MSSkyphosMe" value="Skyphos, Skyphoi, Metall">Skyphos</td>
					<td><input type="checkbox" name="MSBecherMe" value="Becher, Metall">Becher</td>
					<td><input type="checkbox" name="MSdoppelkonischer Becher" value="doppelkonischer Becher">doppelkonischer Becher</td>
				
				</tr>
				<tr>
					<td><input type="checkbox" name="MSTablett" value="Tablett, Platte, Metall">Tablett/Platte</td>
					<td><input type="checkbox" name="MSTellerMe" value="Teller, Metall">Teller</td>
					<td><input type="checkbox" name="MSMissorium" value="Missorium">Missorium</td>
				</tr>
				</table>  
				<br>
				
					<b>Technik</b><br>
				
					<i>Nicht selten werden Techniken kombiniert!</i>
				
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSgetrieben" value="getrieben, Treibtechnik">getrieben</td>
					<td><input type="checkbox" name="MSgedreht" value="gedreht">gedreht</td>
					<td><input type="checkbox" name="MSgegossen" value="gegossen">gegossen</td>
					<td><input type="checkbox" name="MSgezogen" value="gezogen">gezogen</td>
				
				</tr>
				</table>
				<br>
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSNiello" value="Niello">Niello (schwarze Bitumeneinlagen)</td>
					<td><input type="checkbox" name="MStauschiert" value="tauschiert, Tauschierung">Tauschierung (farbige Metalleinlagen)</td></tr>
				</table>  
				<p>
					<b>weitere Angaben zu Form und Technik:</b><br>
					<textarea name="MSToreutikText" rows="2" cols="40">Toreutik, </textarea>
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
						<td><input type="button" value="eingeben" onclick="saveSelection('obj_toreutics');history.back();"></td>
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
END ac_edit_obj_toreutics.tpl
================================================= -->
