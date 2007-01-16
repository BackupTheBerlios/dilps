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
BEGIN ac_edit_obj_arch_sacral.tpl
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
	
	{query_ext_element type="archaeology" element="obj_arch_sacral" fieldnames="fieldnames" values="values" sql="sql" query=$query}
	
	<!-- {$sql} -->
	
	<script language="javascript">
		var rs_fn 	= "{$fieldnames}";
		var rs_val 	= "{$values}";
		
		js_fn 	= rs_fn.split('; ');
		js_val	= rs_val.split('; ');
	</script>

	<table class="header" style="width: 90%; margin: auto;"/>
		<tr>
			<td class="heading">Sakralarchitektur</td>
		</tr>
		<tr>
			<td style="height: 20px;">
				&nbsp;
			</td>
		</tr>
		<tr>
			<td>
				<input type="checkbox" name="MSAltar" value="Altar"><u>Altar</u><br>
				<hr>
					<u>Heiligtum</u><br>
				
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSgriechisches Heiligtum" value="griechisches Heiligtum">griechisches Heiligtum</td>
					<td><input type="checkbox" name="MSr&ouml;misches Heiligtum" value="r&ouml;misches Heligtum">r&ouml;misches Heiligtum</td>
				
					<td><input type="checkbox" name="MSetruskischesHeiligtum" value="etruskisches Heiligtum">etruskisches Heiligtum</td>
					<td><input type="checkbox" name="MSgallo-r&ouml;misches Heiligtum" value="gallo-r&ouml;misches Heiligtum">gallo-r&ouml;misches Heiligtum</td>
				</tr>
				</table>  
				
					andere:<br>
					<textarea name="MSandereHeiligt&uuml;merText" rows="1" cols="40"> Heiligtum</textarea><br>
					<i>Bitte eintragen als "... Heiligtum"</i><br></ul>
				
				<hr>
					<input type="checkbox" name="MSTempel" value="Tempel, Templum"><u>Tempel</u><p>
					
					<u>Typ</u><br>
				
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSHerdhaustempel" value="Herdhaustempel">Herdhaustempel</td>
					<td><input type="checkbox" name="MSAntentempel" value="Antentempel">Antentempel</td>
					<td><input type="checkbox" name="MSPeripteros" value="Peripteros, Umgangstempel">Peripteros</td>
				
					<td><input type="checkbox" name="MSTolos" value="Tolos">Tholos</td>
					
				</tr>
				<tr>
					<td></td>
					<td><input type="checkbox" name="MSProstylos" value="Prostylos">Prostylos</td>
					<td><input type="checkbox" name="MSPseudoperipteros" value="Pseudoperipteros">Pseudoperipteros</td>
					<td><input type="checkbox" name="MSMonopteros" value="Monopteros">Monopteros</td>
				
					</tr>
				<tr>
					<td><input type="checkbox" name="MSNaiskos" value="Naiskos">Naiskos</td>
					<td><input type="checkbox" name="MSAmphiprostylos" value="Amphiprostylos">Amphiprostylos</td>
					<td><input type="checkbox" name="MSDipteros" value="Dipteros">Dipteros</td>
					<td><input type="checkbox" name="MSPeripterossine" value="Peripteros sine Postico">Peripteros sine Postico</td>
				</tr>
				<tr>
				
					<td></td>
					<td></td>
					<td><input type="checkbox" name="MSPseudodipteros" value="Pseudodipteros">Pseudodipteros</td>
				</tr>
				<tr>
					<td><input type="checkbox" name="MSHypaithraltempel" value="Hypaithraltempel, Hyp&auml;thraltempel">Hypaithraltempel</td>
				</tr>
				
				<tr>
					<td><input type="checkbox" name="MSPodiumstempel" value="Podiumstempel, Podium-Tempel">Podiumstempel</td>
				
				</tr>
				</table>  
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSUmgangstempel" value="gallo-r&ouml;mischer Umgangstempel">gallo-r&ouml;mischer Umgangstempel</td>
				</tr>
				</table>  
				<br>
					<u>Teile</u><br>
				
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
				
					<td><input type="checkbox" name="MSAdyton" value="Adyton">Adyton</td>
					<td><input type="checkbox" name="MSCella" value="Cella">Cella</td>
					<td><input type="checkbox" name="MSOpisthodom" value="Opisthodom">Opisthodom</td>
				</tr>
				<tr>
					<td><input type="checkbox" name="MSPeristasis" value="Peristasis, Peristase, S&auml;ulenkranz">Peristasis (S&auml;ulenkranz)</td>
					<td><input type="checkbox" name="MSPteron" value="Pteron, Umgang">Pteron (Umgang)</td>
				
					<td><input type="checkbox" name="MSPronaos" value="Pronaos">Pronaos</td>
				</tr>
				</table>
				<hr>
				<br>
				
					<input type="checkbox" name="MSBanketthaus" value="Banketthaus">Banketthaus<br>
					<input type="checkbox" name="MSSchatzhaus" value="Schatzhaus, Thesaurus, Thesauros">Schatzhaus<br>
					<input type="checkbox" name="MSTemenosmauer" value="Temenosmauer">Temenosmauer<br>
				
					<input type="checkbox" name="MSPropylon" value="Propylon">Propylon<p>
				<hr>
					<b>christliche Bauten</b><p>
					<input type="checkbox" name="MSKirche" value="Kirche, Kirchenbau">Kirche<br>
				
					<input type="checkbox" name="MSBasilika2" value="Basilika">Basilika
				
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSdreischiffigeBasilika" value="dreischiffige Basilika">dreischiffig</td>
				
					<td><input type="checkbox" name="MSf&uuml;nfschiffige Basilika" value="f&uuml;nfschiffige Basilika">f&uuml;nfschiffig</td>
				</tr>
				</table>  
					<input type="checkbox" name="MSBaptisterium" value="Baptisterium">Baptisterium<br>
					<input type="checkbox" name="MSZentralbau" value="christlicher Zentralbau">Zentralbau<br></ul>
					
					<input type="checkbox" name="MSTrikonchenanlage" value="Trikonchenanlage">Trikonchenanlage<p>
					
					<u>Geba&uuml;deteile und Ausstattung:</u><br>
				
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSAtrium2" value="Atrium">Atrium</td>
					<td><input type="checkbox" name="MSNarthex" value="Narthex">Narthex</td>
					<td><input type="checkbox" name="MSSchiffGeb" value="Schiff (Geb&auml;udeteil)">Schiff</td>
					<td><input type="checkbox" name="MSChor" value="Chor">Chor</td>
					<td><input type="checkbox" name="MSApsis" value="Apsis, Konche">Apsis/Konche</td>
				
					<td><input type="checkbox" name="MSEmpore" value="Empore">Empore</td>
				</tr>
				<tr>
					<td><input type="checkbox" name="MSAmbo" value="Ambo">Ambo</td>
					<td><input type="checkbox" name="MSSchranke" value="Schranke">Schranke</td>
				</tr>
				</table>  
				<hr>
					<b>j&uuml;dische Bauten</b>
				
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSSynagoge" value="Synagoge">Synagoge</td>
					<td><input type="checkbox" name="MSMikwe" value="Mikwe">Mikwe (Ritualbad)</td>
				</tr>
				</table>  
				<br>
						
					<b>andere Heiligt&uuml;mer</b><p>
					<input type="checkbox" name="" value="">Mithr&auml;um<p>
				
					<b>andere Bautypen und Geb&auml;udetypen:</b><br>
					<textarea name="MSSakralarchitekturText" rows="2" cols="40"></textarea>
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
						<td><input type="button" value="eingeben" onclick="saveSelection('obj_arch_sacral');history.back();"></td>
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
END ac_edit_obj_arch_sacral.tpl
================================================= -->
