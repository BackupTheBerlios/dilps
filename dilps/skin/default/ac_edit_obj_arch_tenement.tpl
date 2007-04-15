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
BEGIN ac_edit_obj_arch_tenement.tpl
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
	
	{query_ext_element type="archaeology" element="obj_arch_tenement" fieldnames="fieldnames" values="values" sql="sql" query=$query}
	
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
			<td class="heading">Wohnhaus</td>
		</tr>
		<tr>
			<td style="height: 20px;">
				&nbsp;
			</td>
		</tr>
		<tr>
			<td>
					<u>allgemein:</u><br>
				
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSWohnhaus" value="Wohnhaus">Wohnhaus</td>
					<td><input type="checkbox" name="MSPalast" value="Palast">Palast</td>
				</tr>
				<tr>
					<td><input type="checkbox" name="MSGeh&ouml;ft" value="Geh&ouml;ft, Bauernhof">Geh&ouml;ft/Bauernhof</td>
				
					<td><input type="checkbox" name="MSTurmgeh&ouml;ft" value="Turmgeh&ouml;ft">Turmgeh&ouml;ft</td>	
				</tr>
				</table>  
				<hr>
				
					<u>griechisch:</u><br>
				
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSHerdhaus" value="Herdhaus, Herd-Haus">Herdhaus</td>
				
					<td><input type="checkbox" name="MSMegaron" value="Megaron">Megaron</td>
					<td><input type="checkbox" name="MSApsidenhaus" value="Apsidenhaus, Apsiden-Haus">Apsidenhaus</td>
					<td><input type="checkbox" name="MSPastas-Haus" value="Pastashaus, Pastas-Haus">Pastas-Haus</td>
					<td><input type="checkbox" name="MSProstas-Haus" value="Prostashaus, Prostas-Haus">Prostas-Haus</td>
					<td><input type="checkbox" name="MSPeristyl-Haus" value="Peristylhaus, Peristyl-Haus">Peristyl-Haus</td>
				</tr>
				</table>  
				
					Teile:<br>
				
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSAndron" value="Andron, Speiseraum, Symposionsraum">Andron</td>
					<td><input type="checkbox" name="MSOikos" value="Oikos">Oikos</td>
					<td><input type="checkbox" name="MSPeristyl" value="Peristyl">Peristyl</td>
					<td><input type="checkbox" name="MSGynaikonitis" value="Gynaikonitis, Frauengemach">Gynaikonitis</td>
				</tr>
				</table>  
				
				<hr>
				
					<u>r&ouml;misch:</u><br>
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSAtriumhaus" value="Atriumhaus, Atrium-Haus">Atriumhaus</td>
					<td><input type="checkbox" name="MSVilla" value="Villa">Villa</td>
					<td><input type="checkbox" name="MSVillaRustica" value="Villa Rustica">Villa Rustica</td>
				
					<td><input type="checkbox" name="MSDomus" value="Domus">Domus</td>
				</tr>
				</table>  
						
					Teile:<br>
				
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSAla" value="Ala">Ala</td>
					<td><input type="checkbox" name="MSCompluvium" value="Compluvium">Compluvium</td>
					<td><input type="checkbox" name="MSFauces" value="Fauces">Fauces</td>
				
					<td><input type="checkbox" name="MSTaberna" value="Taberna, Laden">Taberna</td>
					<td><input type="checkbox" name="MSTriclinium" value="Triclinium, Speiseraum">Triclinium</td>
				</tr>
				<tr>
					<td><input type="checkbox" name="MSAtrium" value="Atrium">Atrium</td>
					<td><input type="checkbox" name="MSCubiculum" value="Cubiculum">Cubiculum</td>
					<td><input type="checkbox" name="MSLararium" value="Lararium, Larenheiligtum, Hausaltar">Lararium</td>
				
					<td><input type="checkbox" name="MSTablinum" value="Tablinum">Tablinum</td>
					<td><input type="checkbox" name="MSVestibulum1" value="Vestibulum, Vestib&uuml;l">Vestibulum</td>
				</tr>
				</table>
				<p>
					<b>Anderer Geb&auml;ude- oder Raumtyp:</b><br>
					<textarea name="MSWohnhausText" rows="2" cols="40"></textarea><br>
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
						<td><input type="button" value="eingeben" onclick="saveSelection('obj_arch_tenement');history.back();"></td>
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
END ac_edit_obj_arch_tenement.tpl
================================================= -->
