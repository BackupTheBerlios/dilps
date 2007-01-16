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
BEGIN ac_edit_obj_sculpture.tpl
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
	
	{query_ext_element type="archaeology" element="obj_sculpture" fieldnames="fieldnames" values="values" sql="sql" query=$query}
	
	<!-- {$sql} -->
	
	<script language="javascript">
		var rs_fn 	= "{$fieldnames}";
		var rs_val 	= "{$values}";
		
		js_fn 	= rs_fn.split('; ');
		js_val	= rs_val.split('; ');
	</script>

	<table class="header" style="width: 90%; margin: auto;"/>
		<tr>
			<td class="heading">Plastik</td>
		</tr>
		<tr>
			<td style="height: 20px;">
				&nbsp;
			</td>
		</tr>
		<tr>
			<td>
				<i>Bitte ausf&uuml;hrliche Eingaben im Feld <b>Ikonographie</b> vornehmen!</i><p>
				
				<input type="checkbox" name="MSRundplastik" value="Rundplastik"><b>Rundplastik</b>
				
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSEinzelfigur" value="Einzelfiguren">Einzelfigur</td>
					<td><input type="checkbox" name="MSGruppe" value="Figurengruppen">Gruppe</td>
				
				</tr>
				</table>  
				<hr>
				
					<input type="checkbox" name="MSRelief" value="Relief, Reliefplastik"><b>Relief</b>
				
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSGrabrelief" value="Grabrelief">Grabrelief</td>
					<td><input type="checkbox" name="MSGrabstele" value="Grabstele">Grabstele</td>
				</tr>
				
				</table>  
				
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSWeihrelief" value="Weihrelief">Weihrelief</td>
					<td><input type="checkbox" name="MSHeroenrelief" value="Heroenrelief">Heroenrelief</td>
					<td><input type="checkbox" name="MSHeroenmahlrelief" value="Heroenmahlrelief">Heroenmahlrelief</td>
					<td><input type="checkbox" name="MSNymphenrelief" value="Nymphenrelief">Nymphenrelief</td>
				</tr>
				</table>  
				
				
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSUrkundenrelief" value="Urkundenrelief">Urkundenrelief</td>
					<td><input type="checkbox" name="MSHistorischesRelief" value="Historisches Relief">Historisches Relief</td>
					<td><input type="checkbox" name="MSFelsrelief" value="Felsrelief">Felsrelief</td>
				</tr>
				</table>  
				
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSMithrasrelief" value="Mithrasrelief">Mithrasrelief</td>
				
				</tr>
				</table>  
				<hr>
				
					<input type="checkbox" name="MSSarkophag" value="Sarkophag"><b>Sarkophag</b>
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSKasten" value="Sarkophagkasten">Kasten</td>
					<td><input type="checkbox" name="MSSarkophagdeckel" value="Sarkophagdeckel">Deckel</td>
				</tr>
				<tr>
				
					<td><input type="checkbox" name="MSLangseite" value="Langseite">Langseite</td>
					<td><input type="checkbox" name="MSSchmalseite" value="Schmalseite">Schmalseite</td>
				</tr>
				<tr>
					<td><input type="checkbox" name="MSHalbfabrikat" value="Halbfabrikate">Halbfabrikat</td>
				</tr>
				</table>
				
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSUrnePlastik" value="Urnen">Urne</td>
				
					<td><input type="checkbox" name="MSOstothek" value="Ostotheken">Ostothek</td>
				</tr>
				</table>  
				
					<u>Formengruppen:</u>
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSFriessarkophag" value="Friessarkophage, Fries-Sarkophage">Friessarkophag</td>
					<td><input type="checkbox" name="MSRiefelsarkophag" value="Riefelsarkophage, Riefel-Sarkophage">Riefelsarkophag</td>
					<td><input type="checkbox" name="MSS&auml;ulensarkophag, S&auml;ulen-Sarkophag" value="S&auml;ulensarkophage, S&auml;ulen-Sarkophage">S&auml;ulensarkophag</td>
				
					<td><input type="checkbox" name="MSTruhensarkophag" value="Truhensarkophage, Truhen-Sarkophage">Truhensarkophag</td>
				</tr>
				<tr>
					<td><input type="checkbox" name="MSWannensarkophag, Wannen-Sarkophag" value="Wannensarkophage, Wannen-Sarkophage">Wannensarkophag</td>
					<td><input type="checkbox" name="MSanthropomorpher Sarkophag, anthropoider Sarkophag" value="anthropomorpher Sarkophag, anthropoider Sarkophag">anthropoider Sarkophag</td>
					<td><input type="checkbox" name="MSlykischerSarkophag" value="lykischer Sarkophag">lykischer Sarkophag</td>
					<td><input type="checkbox" name="MSScheinsarkophag" value="Scheinsarkophage, Schein-Sarkophage">Scheinsarkophag (aus einzelnen Platten zusammengesetzt)</td>
				
				</tr>
				</table>  
				
					<u>Deckelformen:</u>
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSKlinendeckel" value="Klinendeckel">Klinendeckel</td>
					<td><input type="checkbox" name="MSDachdeckel/Giebeldeckel" value="Dachdeckel/Giebeldeckel">Dachdeckel</td>
					<td><input type="checkbox" name="MSTafeldeckel" value="Tafeldeckel">Tafeldeckel</td>
				</tr>
				</table>  
				
					<u>Thematische Gruppen:</u><br>
				
					<i>Nur eine Auswahl der thematischen Gruppen kann hier angeboten werden.</i>
				
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSSchlachtsarkophag" value="Schlachtsarkophage">Schlachtsarkophag</td>
					<td><input type="checkbox" name="MSJagdsarkophag" value="Jagdsarkophage">Jagdsarkophag</td>
					<td><input type="checkbox" name="MSHochzeitssarkophag" value="Hochzeitssarkophag">Hochzeitssarkophag</td>
				</tr>
				<tr>
				
					<td><input type="checkbox" name="MSHippolytossarkophag" value="Hippolytossarkophage">Hippolytossarkophag</td>
					<td><input type="checkbox" name="MSDionysischer Sarkophag" value="Dionysischer Sarkophag, Dionysische Sarkophage">Dionysischer Sarkophag</td>
					<td><input type="checkbox" name="MSMeerwesensarkophag" value="Meerwesensarkophag">Meerwesensarkophag</td>
				</tr>
				<tr>
					<td><input type="checkbox" name="MSMusensarkophag" value="Musensarkophage">Musensarkophag</td>
					<td><input type="checkbox" name="MSErotensarkophag" value="Erotensarkophage">Erotensarkophag</td>
				
					<td><input type="checkbox" name="MSJahreszeitensarkophag" value="Jahreszeitensarkophage">Jahreszeitensarkophag</td>
				</tr>
				<tr>
					<td><input type="checkbox" name="MSGirlandensarkophag" value="Girlandensarkophage, Girlanden-Sarkophage">Girlandensarkophag</td>
				</tr>
				</table>  
				
				<hr>
				
					<input type="checkbox" name="MSBauplastik" value="Bauplastik"><b>Bauplastik</b>
				
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				
				<tr>
					<td><input type="checkbox" name="MSColumnaCellata" value="Columna Cellata">Columna Cellata</td>
					<td><input type="checkbox" name="MSFries2" value="Friese">Fries</td>
					<td><input type="checkbox" name="MSReliefmetope" value="Reliefmetopen">Reliefmetope</td>
				</tr>
				<tr>
					<td><input type="checkbox" name="MSGiebelfigur" value="Giebelfiguren">Giebelfigur</td>
					<td><input type="checkbox" name="MSAkroter" value="Akrotere">Akroter</td>
				
				</tr>
				</table>  
				
				<hr>
				
					<b>Format</b>
				
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSkleinformatig" value="kleinformatig">kleinformatig</td>
					<td><input type="checkbox" name="MSunterlebensgro&szlig;" value="unterlebensgro&szlig;">unterlebensgro&szlig;</td>
					<td><input type="checkbox" name="MSlebensgro&szlig;" value="lebensgro&szlig;">lebensgro&szlig;</td>
				
					<td><input type="checkbox" name="MS&uuml;berlebensgro&szlig;" value="&uuml;berlebensgro&szlig;">&uuml;berlebensgro&szlig;</td>
					<td><input type="checkbox" name="MSkolossal" value="kolossal">kolossal</td>
				</tr>
				</table>  
				<hr>
					<input type="checkbox" name="MSPolychromie" value="Polychromie"><b>Polychromie</b>
				
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSBemalungsreste" value="Bemalungsreste">Bemalungsreste</td>
				
				</tr>
				</table>  
				
				<p>
				<b>Weitere Angaben:</b><br>
				<textarea name="MSPlastikText" rows="3" cols="40">Plastik, </textarea>
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
						<td><input type="button" value="eingeben" onclick="saveSelection('obj_sculpture');history.back();"></td>
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
END ac_edit_obj_sculpture.tpl
================================================= -->
