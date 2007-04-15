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
BEGIN ac_edit_obj_portrait.tpl
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
	
	{query_ext_element type="archaeology" element="obj_portrait" fieldnames="fieldnames" values="values" sql="sql" query=$query}
	
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
			<td class="heading">Porträt</td>
		</tr>
		<tr>
			<td style="height: 20px;">
				&nbsp;
			</td>
		</tr>
		<tr>
			<td>
				<b><i>Bitte innerhalb jeder Kategorie einen Eintrag vornehmen!</i></b><p>
				<hr>
					<b>Benennung</b><p>
					<b>Name:</b><br>
					<textarea name="MSPortr&auml;tBenennungText" rows="1" cols="50"></textarea>
				
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSBenennunggesichert" value="Benennung gesichert">Benennung gesichert</td>
				
					<td><input type="checkbox" name="MSBenennungnichtgesichert" value="Benennung nicht gesichert">Benennung nicht gesichert</td>
					<td><input type="checkbox" name="MSunbekannt" value="unbekannt">unbekannt</td>
					<td><input type="checkbox" name="MSunbekannt" value="unbenannt, nicht benannt">unbenannt</td>
				</tr>
				</table>  
				<hr>
					<b>Form</b>
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
				
					<td><input type="checkbox" name="MSKopf" value="Portrait, Portr&auml;t, Kopf">Kopf</td>
					<td><input type="checkbox" name="MSHerme" value="Portrait, Portr&auml;t, Herme">Herme</td>
					<td><input type="checkbox" name="MSGanzfigur" value="Portrait, Portr&auml;t, Ganzfigur">Ganzfigur</td>
					<td><input type="checkbox" name="MSSarkophag" value="Portrait, Portr&auml;t, Sarkophag">Sarkophag</td>
					<td><input type="checkbox" name="MSMumienportr&auml;t" value="Portrait, Portr&auml;t, Mumienportr&auml;t">Mumienportr&auml;t</td>
				</tr>
				
				<tr>
					<td><input type="checkbox" name="MSB&uuml;ste" value="Portrait, Portr&auml;t, B&uuml;ste">B&uuml;ste</td>
					<td><input type="checkbox" name="MSDoppelherme" value="Portrait, Portr&auml;t, Doppelherme">Doppelherme</td>
					<td><input type="checkbox" name="MSReiterstatue" value="Portrait, Portr&auml;t, Reiterstatue">Reiterstatue</td>
					<td><input type="checkbox" name="MSM&uuml;nze" value="Portrait, Portr&auml;t, M&uuml;nze">M&uuml;nze</td>
				</tr>
				</table>  
				
					<b>Klasse</b>
				
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSKaiser" value="r&ouml;mischer Kaiser">r&ouml;mischer Kaiser</td>
					<td><input type="checkbox" name="MSHellenistischerHerrscher" value="Hellenistischer Herrscher">Hellenistischer Herrscher</td>
					<td><input type="checkbox" name="MSPolitiker" value="Politiker, Redner">Politiker/Redner</td>
					<td><input type="checkbox" name="MSDichter" value="Dichter">Dichter</td>
					<td><input type="checkbox" name="MSPrivatportr&auml;t" value="Privatportr&auml;t">Privatportr&auml;t</td>
				
				</tr>
				<tr>
					<td><input type="checkbox" name="MSMitglieddesKaiserhauses" value="Mitglied des Kaiserhauses">Mitglied des Kaiserhauses</td>
					<td><input type="checkbox" name="MSHellenistischeHerrscherin" value="Hellenistische Herrscherin">Hellenistische Herrscherin</td>
					<td><input type="checkbox" name="MSStratege" value="Stratege">Stratege</td>
					<td><input type="checkbox" name="MSPhilosoph" value="Philosoph">Philosoph</td>
					<td><input type="checkbox" name="MSAthlet" value="Athlet, Sportler">Athlet</td>
				
				</tr>
				<tr>
					<td><input type="checkbox" name="MSPrinz" value="Prinz">Prinz</td>
				</tr>
				</table>  
					<b>andere Bezeichnung:</b><br>
					<textarea name="MSPortr&auml;tKlasseText" rows="2" cols="40"></textarea>
				<hr>
					<b>Geschlecht und Altersstufe</b><br>
					<i>Geschlechts und Altersangeben hier machen entsprechende Eintragungen unter <b>Ikonographie</b> nicht &uuml;berfl&uuml;ssig!</i>
				
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSweiblich1" value="weiblich">weiblich</td>
					<td><input type="checkbox" name="MSm&auml;nnlich1" value="m&auml;nnlich">m&auml;nnlich</td>
					<td><input type="checkbox" name="MSGeschlechtunklar1" value="Geschlecht unklar, unklares Geschlecht">unklar</td>
				</tr>
				<tr>
					<td><input type="checkbox" name="MSKind4" value="M&auml;dchen, Kind, kindlich">M&auml;dchen</td>
				
					<td><input type="checkbox" name="MSKind5" value="Junge, Kind, kindlich">Junge</td>
				</tr>
				<tr>
					<td><input type="checkbox" name="MSJugendliche1" value="jugendlich, Jugendliche">Jugendliche</td>
					<td><input type="checkbox" name="MSJugendlicher1" value="jugendlich, Jugendlicher">Jugendlicher</td>
				</tr>
				<tr>
					<td><input type="checkbox" name="MSErwachsene1" value="erwachsen, Erwachsene">Erwachsene</td>
					<td><input type="checkbox" name="MSErwachsener1" value="erwachsen, Erwachsener">Erwachsener</td>
				
				</tr>
				<tr>
					<td><input type="checkbox" name="MSAlte1" value="alt, Alte, Greisin">Alte</td>
					<td><input type="checkbox" name="MSAlter1" value="alt, Alter, Greis">Alter</td>
				</tr>
				</table>
				<hr>
				<p>
					<b>weitere Angaben:</b><br>
					<textarea name="MSPortr&auml;tText" rows="2" cols="40"></textarea>

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
						<td><input type="button" value="eingeben" onclick="saveSelection('obj_portrait');history.back();"></td>
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
END ac_edit_obj_portrait.tpl
================================================= -->
