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
BEGIN ac_edit_iconography.tpl
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
	
	{query_ext_element type="archaeology" element="dating_ext" fieldnames="fieldnames" values="values" sql="sql" query=$query}
	
	<!-- {$sql} -->
	
	<script language="javascript">
		var rs_fn 	= "{$fieldnames}";
		var rs_val 	= "{$values}";
		
		js_fn 	= rs_fn.split('; ');
		js_val	= rs_val.split('; ');
	</script>

	<table class="header" style="width: 90%; margin: auto;"/>
		<tr>
			<td class="heading">Datierung (beschreibend)</td>
		</tr>
		<tr>
			<td style="height: 10px;">
				&nbsp;
			</td>
		</tr>
		<tr>
			<td>
				<i>Bitte auch bei einer exakten Datierung ein fett hervorgehobenes Auswahlfeld markieren!</i>
			</td>
		</tr>
		<tr>
			<td style="height: 20px;">
				&nbsp;
			</td>
		</tr>
		<tr>
			<td>
				<p>
				<input type="checkbox" name="MSpraehistorisch" value="praehistorisch"><b>pr&auml;historisch</b>
				<p>
				
				<hr><br>
				
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MShelladisch" value="helladisch"><b>helladisch</b></td>
					<td><input type="checkbox" name="MSminoisch" value="minoisch"><b>minoisch</b></td>
					<td><input type="checkbox" name="MSmykenisch" value="mykenisch"><b>mykenisch</b></td>
				</tr>
				<tr>
					<td><input type="checkbox" name="MSfr&uuml;hhelladisch" value="fr&uuml;hhelladisch">fr&uuml;hhelladisch</td>
				
					<td><input type="checkbox" name="MSfr&uuml;hminoisch" value="fr&uuml;hminoisch">fr&uuml;hminoisch</td>
					<td><input type="checkbox" name="MSfr&uuml;hmykenisch" value="fr&uuml;hmykenisch">fr&uuml;hmykenisch</td>
				</tr>
				<tr>
					<td><input type="checkbox" name="MSmittelhelladisch" value="mittelhelladisch">mittelhelladisch</td>
					<td><input type="checkbox" name="MSmittelminoisch" value="mittelminoisch">mittelminoisch</td>
					<td><input type="checkbox" name="MSmittelmykenisch" value="mittelmykenisch">mittelmykenisch</td>
				
				</tr>
				<tr>
					<td><input type="checkbox" name="MSsp&auml;thelladisch" value="sp&auml;thelladisch">sp&auml;thelladisch</td>
					<td><input type="checkbox" name="MSsp&auml;tminoisch" value="sp&auml;tminoisch">sp&auml;tminoisch</td>
					<td><input type="checkbox" name="MSsp&auml;tmykenisch" value="sp&auml;tmykenisch">sp&auml;tmykenisch</td>
				</tr>
				</table>  
				<hr><br>
				
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSgeometrisch" value="geometrisch"><b>geometrisch</b></td>
					<td><input type="checkbox" name="MSarchaisch" value="archaisch"><b>archaisch</b></td>
					<td><input type="checkbox" name="MSklassisch" value="klassisch"><b>klassisch</b></td>
					<td><input type="checkbox" name="MShellenistisch" value="hellenistisch"><b>hellenistisch</b></td>
				</tr>
				<tr>
					<td><input type="checkbox" name="MSprotogeometrisch" value="protogeometrisch">protogeometrisch<br></td>
				
				</tr>
				<tr>
					<td><input type="checkbox" name="MSfr&uuml;hgeometrisch" value="fr&uuml;hgeometrisch">fr&uuml;hgeometrisch</td>
					<td><input type="checkbox" name="MSfr&uuml;harchaisch" value="fr&uuml;harchaisch">fr&uuml;harchaisch</td>
					<td><input type="checkbox" name="MSfr&uuml;hklassisch" value="fr&uuml;hklassisch">fr&uuml;hklassisch</td>
					<td><input type="checkbox" name="MSfr&uuml;hhellenistisch" value="fr&uuml;hhellenistisch">fr&uuml;hhellenistisch</td>
				
				</tr>
				<tr>
					<td><input type="checkbox" name="MShochgeometrisch" value="hochgeometrisch">hochgeometrisch</td>
					<td><input type="checkbox" name="MShocharchaisch" value="hocharchaisch">hocharchaisch</td>
					<td><input type="checkbox" name="MShochklassisch" value="hochklassisch">hochklassisch</td>
					<td><input type="checkbox" name="MShochhellenistisch" value="hochhellenistisch">hochhellenistisch</td>
				</tr>
				<tr>
					<td><input type="checkbox" name="MSsp&auml;tgeometrisch" value="sp&auml;tgeometrisch">sp&auml;tgeometrisch</td>
				
					<td><input type="checkbox" name="MSsp&auml;tarchaisch" value="sp&auml;tarchaisch">sp&auml;tarchaisch</td>
					<td><input type="checkbox" name="MSsp&auml;tklassisch" value="sp&auml;tklassisch">sp&auml;tklassisch</td>
					<td><input type="checkbox" name="MSsp&auml;thellenistisch" value="sp&auml;thellenistisch">sp&auml;thellenistisch</td>
				</tr>
				<tr>
					<td><input type="checkbox" name="MSsubgeometrisch" value="subgeometrisch">subgeometrisch</td>
				
					<td>
				</tr>
				</table>  	
				<hr><br>
				
				<input type="checkbox" name="MSetruskisch" value="etruskisch"><b>etruskisch</b><p>
				
				<input type="checkbox" name="MSrepublikanisch" value="republikanisch"><b>republikanisch</b>
				<ul><input type="checkbox" name="MSsp&auml;trepublikanisch" value="sp&auml;trepublikanisch">sp&auml;trepublikanisch<br></ul>
				
				<input type="checkbox" name="MSkaiserzeitlich" value="kaiserzeitlich"><b>kaiserzeitlich</b>
				
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSfr&uuml;hkaiserzeitlich" value="fr&uuml;hkaiserzeitlich"><u>fr&uuml;he Kaiserzeit</u></td>
					<td><input type="checkbox" name="MSmittelkaiserzeitlich" value="mittlere Kaiserzeit, mittelkaiserzeitlich"><u>mittlere Kaiserzeit</u></td>
					<td><input type="checkbox" name="MSsp&auml;tkaiserzeitlich" value="sp&auml;te Kaiserzeit, sp&auml;tkaiserzeitlich"><u>sp&auml;te Kaiserzeit</u></td>
				
				</tr>
				<tr>
					<td><input type="checkbox" name="MSaugusteisch" value="augusteisch">augusteisch</td>
					<td><input type="checkbox" name="MStrajanisch" value="trajanisch">trajanisch</td>
					<td><input type="checkbox" name="MSseverisch" value="severisch">severisch</td>
				</tr>
				<tr>
					<td><input type="checkbox" name="MSiulisch-claudisch" value="iulisch-claudisch, julisch-claudisch">iulisch-claudisch</td>
					<td><input type="checkbox" name="MShadrianisch" value="hadrianisch">hadrianisch</td>
				
					<td><input type="checkbox" name="MSsoldatenkaiserzeitlich" value="soldatenkaiserzeitlich">soldatenkaiserzeitlich</td>
				</tr>
				<tr>
					<td><input type="checkbox" name="MSflavisch" value="flavisch">flavisch	</td>
					<td><input type="checkbox" name="MSantoninisch" value="antoninisch">antoninisch</td>
				</tr>
				</table>  
				
				<hr><br>
				<input type="checkbox" name="MSsp&auml;tantik" value="sp&auml;tantik"><b>sp&auml;tantik</b>
					
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
						<td><input type="checkbox" name="MStetrarchisch" value="tetrarchisch">tetrarchisch</td>
						<td><input type="checkbox" name="MSkonstantinisch" value="konstantinisch">konstantinisch</td>
						<td><input type="checkbox" name="MStheodosianisch" value="theodosianisch">theodosianisch</td>
				</tr>
				</table>  
				
				<b><input type="checkbox" name="MSfr&uuml;hchristlich" value="fr&uuml;hchristlich">fr&uuml;hchristlich<p>
			
				<input type="checkbox" name="MSbyzantinisch" value="byzantinisch">byzantinisch<p>
				<input type="checkbox" name="MSmittelalterlich" value="mittelalterlich">mittelalterlich<p>
				<input type="checkbox" name="MSmodern" value="modern, neuzeitlich">modern/neuzeitlich<br></b>
				<hr>
				<p>
					<b>spezifische Datierung oder andere Bezeichnung:</b><br>
					<textarea name="MSDatierungText" rows="2" cols="40"></textarea>
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
						<td><input type="button" value="eingeben" onclick="saveSelection('dating_ext');saveAdditionalData('MSDatierungText','edit[dating]');window.close();"></td>
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
END ac_edit_iconography.tpl
================================================= -->
