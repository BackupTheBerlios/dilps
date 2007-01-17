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
BEGIN ac_edit_obj_jewellery.tpl
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
	
	{query_ext_element type="archaeology" element="obj_jewellery" fieldnames="fieldnames" values="values" sql="sql" query=$query}
	
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
			<td class="heading">Schmuck</td>
		</tr>
		<tr>
			<td style="height: 20px;">
				&nbsp;
			</td>
		</tr>
		<tr>
			<td>
				<i>Darstellungen von Schmuck geh&ouml;ren in die <b>Ikonographie</b>!<br>
				&Uuml;berschneidungen mit anderen Bereichen wie z.B. der Toreutik sind m&ouml;glich!</i><p>
				
				<b>Gewand- und Kleiderschmuck</b>
				
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSFibel" value="Fibeln">Fibel</td>
					<td><input type="checkbox" name="MSSchmuckblech" value="Schmuckbleche">Schmuckblech</td>
					<td><input type="checkbox" name="MSZierknopf" value="Zierknopf">Zierknopf</td>
					<td><input type="checkbox" name="MSGewandnadel" value="Gewandnadeln">Gewandnadel</td>
					<td><input type="checkbox" name="MSG&uuml;rtelbeschlag" value="G&uuml;rtelbeschlag">G&uuml;rtelbeschlag</td>
				
				</tr>
				</table>  
				<p>
					<b>K&ouml;rperschmuck</b><p>
					<input type="checkbox" name="MSHaarschmuck" value="Haarschmuck"><u>Haarschmuck</u>
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSDiadem" value="Diademe">Diadem</td>
					<td><input type="checkbox" name="MSKranz" value="Kranz, Kr&auml;nze">Kranz</td>
				
					<td><input type="checkbox" name="MSHaarnadel" value="Haarnadeln">Haarnadel</td>
					<td><input type="checkbox" name="MSHaarspirale" value="Haarspiralen">Haarspirale</td>
					<td><input type="checkbox" name="MSSchl&auml;fenring" value="Schl&auml;fenringe">Schl&auml;fenring</td>
					<td><input type="checkbox" name="MSHaarnetz" value="Haarnetze">Haarnetz</td>
				</tr>
				</table>  
				<p>
					<input type="checkbox" name="MSOhrschmuck" value="Ohrschmuck"><u>Ohrschmuck</u>
				
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSOhrscheibe" value="Ohrscheibe">Ohrscheibe</td>
					<td><input type="checkbox" name="MSOhrreifen" value="Ohrreifen">Ohrreifen</td>
					<td><input type="checkbox" name="MSOhrspirale" value="Ohrspiralen">Ohrspirale</td>
					<td><input type="checkbox" name="MSkahnf&ouml;rmiger Ohrring" value="kahnf&ouml;rmiger Ohrring">kahnf&ouml;rmiger Ohrring</td>
					<td><input type="checkbox" name="MSkegelf&ouml;rmiger Ohrring" value="kegelf&ouml;rmiger Ohrring">kegelf&ouml;rmiger Ohrring</td>
				
				</tr>
				</table>  
				<p>
				
					<input type="checkbox" name="MSHalsschmuck" value="Halsschmuck"><u>Halsschmuck</u>
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSHalsband" value="Halsband, Halsb&auml;nder">Halsband</td>
					<td><input type="checkbox" name="MSHalskette" value="Halsketten">Halskette</td>
					<td><input type="checkbox" name="MSHalsreif" value="Halsreif">Halsreif</td>
				
					<td><input type="checkbox" name="MSTorques" value="Torques">Torques</td>
					<td><input type="checkbox" name="MSPektorale" value="Pektorale, Pectorale">Pektorale</td>
				</tr>
				</table>  
				<p>
				
					<input type="checkbox" name="MSArmschmuck" value="Armschmuck"><u>Armschmuck</u>
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSArmband" value="Armband, Armb&auml;nder">Armband (aus beweglichen Gliedern)</td>
				
					<td><input type="checkbox" name="MSArmreif" value="Armreif, Armreife">Armreif (feste Grundstruktur)</td>
					<td><input type="checkbox" name="MSSchlangenarmreif" value="Schlangenarmreif, Schlangenarmreife">Schlangenarmreif</td>
				</tr>
				</table>  
				<p>
				
					<input type="checkbox" name="MSFingerring" value="Fingerring, Fingerringe"><u>Fingerring</u>
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSSiegelring" value="Siegelring">Siegelring</td>
				
				</tr>
				</table>  
				<p>
				
					<u>Anh&auml;nger und Perlen</u>
				
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSAnh&auml;nger" value="Anh&auml;nger">Anh&auml;nger</td>
					<td><input type="checkbox" name="MSPerle" value="Perle, Perlen">Perle</td>
				
					<td><input type="checkbox" name="MSSchmuckmedaillon" value="Schmuckmedaillon">Schmuckmedaillon</td>
					<td><input type="checkbox" name="MSAmulett" value="Amulett, Amulette">Amulett</td>
					<td><input type="checkbox" name="MSLunula" value="Lunula, Lunulae">Lunula</td>
				</tr>
				</table>  
				<p>
				
					<b>Technik</b>
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				
				<tr>
					<td><input type="checkbox" name="MSDraht" value="Draht">Draht</td>
					<td><input type="checkbox" name="MSGranulation" value="Granulation">Granulation</td>
					<td><input type="checkbox" name="MSEinlagen" value="Einlagen">Einlagen</td>
				</tr>
				</table>  
				
				<p>
				
					<b>Weitere Angaben:</b><br>
				
					<textarea name="MSSchmuckText" rows="2" cols="40">Schmuck, </textarea><p>
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
						<td><input type="button" value="eingeben" onclick="saveSelection('obj_jewellery');history.back();"></td>
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
END ac_edit_obj_jewellery.tpl
================================================= -->
