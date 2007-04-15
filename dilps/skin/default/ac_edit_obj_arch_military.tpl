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
BEGIN ac_edit_obj_arch_military.tpl
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
	
	{query_ext_element type="archaeology" element="obj_arch_military" fieldnames="fieldnames" values="values" sql="sql" query=$query}
	
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
			<td class="heading">Wehrarchitektur</td>
		</tr>
		<tr>
			<td style="height: 20px;">
				&nbsp;
			</td>
		</tr>
		<tr>
			<td>
					<b>Wehrarchitektur/Milit&auml;rarchitektur</b><p>
				
					<input type="checkbox" name="MSBefestigung" value="Befestigung">Befestigung<br>
					<input type="checkbox" name="MSFestung" value="Festung">Festung (in sich geschlossene Anlage)<br>
					<input type="checkbox" name="MSMauer" value="Mauer">Mauer
					
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSStadtmauer" value="Stadtmauer">Stadtmauer</td>
				
					<td><input type="checkbox" name="MSProteichisma" value="Proteichisma">Proteichisma (Vormauer)</td>
				</tr>
				</table>  
					<input type="checkbox" name="MSTor" value="Tor">Tor
				
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSStadttor" value="Stadttor">Stadttor</td>
				</tr>
				</table>  
				
					<input type="checkbox" name="MSTurm" value="V">Turm<br>
				
					<input type="checkbox" name="MSWallanlage" value="Wallanlage">Wallanlage<br>
				
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSWall" value="Wall">Wall</td>
					<td><input type="checkbox" name="MSGraben" value="Graben">Graben</td>
					<td><input type="checkbox" name="MSSpitzgraben" value="Spitzgraben">Spitzgraben</td>
					<td><input type="checkbox" name="MSPalisade" value="Palisade">Palisade</td>
				</tr>
				</table>
				
				<br>
					<input type="checkbox" name="MSLager" value="Lager, Kastell, Milit&auml;rlager">Lager/Kastell/Milit&auml;rlager<p>
					<u>Lagerbauten:</u>
					
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSPrincipia" value="Principia">Principia</td>
					<td><input type="checkbox" name="MSPraetorium" value="Praetorium">Praetorium</td>
				
					<td><input type="checkbox" name="MSValetudinarium" value="Valetudinarium, Lazarett">Valetudinarium/Lazarett</td>
					<td><input type="checkbox" name="MSCanabae" value="Canabae">Canabae</td>
				</tr>
				</table>  
				
					<input type="checkbox" name="" value="">Grenzbefestigung/Limes
				
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="" value="">Wachturm</td>
				</tr>
				</table>  
				
					<input type="checkbox" name="" value="">Belagerungsrampe<p>
				
					<b>andere Bezeichnung:</b><br>
					<textarea name="MSWehrarchitekturText" rows="3" cols="40">Wehrarchitektur, Milit&auml;rarchitektur, </textarea>
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
						<td><input type="button" value="eingeben" onclick="saveSelection('obj_arch_military');history.back();"></td>
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
END ac_edit_obj_arch_military.tpl
================================================= -->
