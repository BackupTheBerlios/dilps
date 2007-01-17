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
BEGIN ac_edit_obj_arch_sepulchre.tpl
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
	
	{query_ext_element type="archaeology" element="obj_arch_sepulchre" fieldnames="fieldnames" values="values" sql="sql" query=$query}
	
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
			<td class="heading">Ehrenmonumente und Grabarchitektur</td>
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
					<td><input type="checkbox" name="MSBogen" value="Bogen, B&ouml;gen">Bogen</td>
					<td><input type="checkbox" name="S&auml;ulenmonument" value="S&auml;ulenmonument, Ehrens&auml;ulen">S&auml;ulenmonument</td>
					<td><input type="checkbox" name="MSChoregischesWeihgeschenk" value="Choregisches Denkmal/Choregisches Weihgeschenk">Choregisches Weihgeschenk</td>
				</tr>
				<tr>
					<td><input type="checkbox" name="MSEhrenbogen" value="Ehrenbogen, Ehrenb&ouml;gen">Ehrenbogen</td>
				
					<td><input type="checkbox" name="MSExedra" value="Exedra, Exedren">Exedra</td>
					<td><input type="checkbox" name="MSObelisk" value="Obelisk">Obelisk</td>
				</tr>
				<tr>
					<td><input type="checkbox" name="MSTriumphbogen" value="Triumphbogen, Triumphb&ouml;gen">Triumphbogen</td>
				</tr>
				<tr>
					<td><input type="checkbox" name="MSQuadrifrons" value="Quadrifrons">Quadrifrons</td>
				</tr>
				
				</table>
				<hr>
				<br>
					<b>Grabarchitektur</b><p>
				
					<input type="checkbox" name="MSGrabh&uuml;gel" value="Grabh&uuml;gel, Tumulus">Grabh&uuml;gel<p>
					<input type="checkbox" name="MSGrabbau" value="Grabbau">Grabbau<p>
						
					<input type="checkbox" name="MSKammergrab" value="Kammergrab">Kammergrab
				
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				
				<tr>
					<td><input type="checkbox" name="MSGrabkammer" value="Grabkammer">Grabkammer</td>
					<td><input type="checkbox" name="MSDromos" value="Dromos">Dromos</td>
				</tr>
				</table>  
					
					<input type="checkbox" name="MSGrabpfeiler" value="Grabpfeiler">Grabpfeiler<br>
					<input type="checkbox" name="MSPfeilergrab" value="Pfeilergrab">Pfeilergrab<br>
					<input type="checkbox" name="MSFelsgrab" value="Felsgrab">Felsgrab
				
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				
				<tr>
					<td><input type="checkbox" name="MSGrabfassade" value="Grabfassade">Grabfassade</td>
				</tr>
				</table>  
				<br>
				
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSHeroon" value="Heroon">Heroon</td>
					<td><input type="checkbox" name="MSMausoleum" value="Mausoleum">Mausoleum</td>
				</tr>
				
				</table>  
				<br>
				
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSKatakombe" value="Katakombe">Katakombe</td>
					<td><input type="checkbox" name="MSLoculus" value="Loculus">Loculus</td>
					<td><input type="checkbox" name="MSArkosolgrab" value="Arkosolgrab, Arkosolium">Arkosolgrab</td>
				</tr>
				<tr>
					<td><input type="checkbox" name="MSHypog&auml;um" value="Hypog&auml;um">Hypog&auml;um</td>
				
					<td><input type="checkbox" name="MSColumbarium" value="Columbarium">Columbarium</td>
					<td><input type="checkbox" name="MSCoemeterium" value="Coemeterium">Coemeterium</td>
				</tr>
				</table>  
				
				
				<p>
					<b>andere Bezeichnung:</b><br>
					<textarea name="MSGrabText" rows="2" cols="40"></textarea>
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
						<td><input type="button" value="eingeben" onclick="saveSelection('obj_arch_sepulchre');history.back();"></td>
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
END ac_edit_obj_arch_sepulchre.tpl
================================================= -->
