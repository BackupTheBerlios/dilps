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
	
	{archaeology_element element="material_ext" fieldnames="fieldnames" values="values" sql="sql" query=$query}
	
	<!-- {$sql} -->
	
	<script language="javascript">
		var rs_fn 	= "{$fieldnames}";
		var rs_val 	= "{$values}";
		
		js_fn 	= rs_fn.split('; ');
		js_val	= rs_val.split('; ');
	</script>

	<table class="header" style="width: 90%; margin: auto;"/>
		<tr>
			<td class="heading">Material</td>
		</tr>
		<tr>
			<td style="height: 20px;">
				&nbsp;
			</td>
		</tr>
		<tr>
			<td>
				<input type="checkbox" name="MSStein" value="Stein"><b>Stein</b>
				
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSMarmor" value="Marmor">Marmor</td>
					<td><input type="checkbox" name="MSKalkstein" value="Kalkstein">Kalkstein</td>
					<td><input type="checkbox" name="MSAlabaster" value="Alabaster">Alabaster</td>
					<td><input type="checkbox" name="MSBasalt" value="Basalt">Basalt</td>
					<td><input type="checkbox" name="MSSandstein" value="Sandstein">Sandstein</td>
				
					<td><input type="checkbox" name="MSTravertin" value="Travertin">Travertin</td>
					<td><input type="checkbox" name="MSTuff" value="Tuff">Tuff</td>
					<td><input type="checkbox" name="MSPorphyr" value="Porphyr">Porphyr</td>
				</tr>
				</table>  
				
				<i>Exakte Bezeichnungen z.B. f&uuml;r Halbedelsteine bitte unten eintragen.</i>
				<p>
				<input type="checkbox" name="MSMetall" value="Metall"><b>Metall</b>
				
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSBronze" value="Bronze">Bronze</td>
					<td><input type="checkbox" name="MSSilber" value="Silber">Silber</td>
					<td><input type="checkbox" name="MSGold" value="Gold">Gold</td>
					<td><input type="checkbox" name="MSElektron" value="Elektron">Elektron</td>
					<td><input type="checkbox" name="MSEisen" value="Eisen">Eisen</td>
				
					<td><input type="checkbox" name="MSKupfer" value="Kupfer">Kupfer</td>
					<td><input type="checkbox" name="MSBlei" value="Blei">Blei</td>
				</tr>
				</table>  
				
				<input type="checkbox" name="MSTon" value="Ton"><b>Ton</b>
				
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSZiegel2" value="Ziegel">Ziegel</td>
					<td><input type="checkbox" name="MSTerracotta" value="Terracotta, Terrakotta">Terracotta</td>
				
					<td><input type="checkbox" name="MSKeramik" value="Keramik">Keramik</td>
				</tr>
				</table>  
				
				<b>andere anorganische Materialien</b><br>
				
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSGlas" value="Glas">Glas</td>
					<td><input type="checkbox" name="MSFayence" value="Fayence">Fayence</td>
					<td><input type="checkbox" name="MSFritte" value="Fritte">Fritte</td>
				
				</tr>
				<tr>
					<td><input type="checkbox" name="MSStuck" value="Stuck, Putz">Stuck/Putz</td>
					<td><input type="checkbox" name="MSEmail" value="Email, Emaille">Email</td>
				</tr>	
				<tr>
					<td><input type="checkbox" name="MSPerlmutt" value="Perlmutt">Perlmutt</td>
					<td><input type="checkbox" name="MSMuschelschale" value="Muschelschale">Muschelschale</td>
					<td><input type="checkbox" name="MSSchneckenhaus" value="Schneckenhaus">Schneckenhaus</td>
				
				</tr>
				</table>  
				
				<input type="checkbox" name="MSorganisch" value="organisches Material"><b>organische Materialien</b>
				
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSHolz" value="Holz">Holz</td>
					<td><input type="checkbox" name="MSKnochen" value="Knochen, Bein">Knochen/Bein</td>
					<td><input type="checkbox" name="MSElfenbein" value="Elfenbein">Elfenbein</td>
					<td><input type="checkbox" name="MSBernstein" value="Bernstein">Bernstein</td>
				
					<td><input type="checkbox" name="MSAsphalt" value="Asphalt, Bitumen">Asphalt/Bitumen</td>
				</tr>
				<tr>
					<td><input type="checkbox" name="MSTextil" value="Textil, Textilien">Textil</td>
					<td><input type="checkbox" name="MSSeide" value="Seide, Seidenstoff">Seide</td>
				</tr>
				</table>  
				<b>anderes Material oder genauere Benennung:</b><br>
				
				<textarea name="MSMaterialVerschText" rows="2" cols="40"></textarea>
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
						<td><input type="button" value="eingeben" onclick="saveSelection('material_ext');window.close();"></td>
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
