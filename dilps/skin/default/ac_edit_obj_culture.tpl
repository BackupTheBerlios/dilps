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
BEGIN ac_edit_obj_culture.tpl
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
	
	{query_ext_element type="archaeology" element="obj_culture" fieldnames="fieldnames" values="values" sql="sql" query=$query}
	
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
			<td class="heading">Landschaften und Kulturkreise</td>
		</tr>
		<tr>
			<td style="height: 20px;">
				&nbsp;
			</td>
		</tr>
		<tr>
			<td>
				<i>Diese Angabe dient der groben Einordnung des Objektes, um eine &uuml;bergreifende Suche zu erm&ouml;glichen.<br>
				Angaben in den Feldern "Ort" und "Fundort" werden dadurch nicht &uuml;berfl&uuml;ssig!<br>
				<b>Achtung:</b> Moderne und antike Bezeichnungen sind nicht immer deckungsgleich!<br>
				Vollst&auml;ndigkeit kann bei den Vorgaben nicht geleistet werden.<br>
				Mehrfachnennungen sind - wenn sinnvoll - m&ouml;glich.</i>
				
				<p>
				<b>Alphabetische Liste moderner Staaten:</b>
				
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MS&Auml;gypten" value="&Auml;gypten, &auml;gyptisch">&Auml;gypten</td>
					<td><input type="checkbox" name="MSFrankreich" value="Frankreich">Frankreich</td>
					<td><input type="checkbox" name="MSJordanien" value="Jordanien">Jordanien</td>
					<td><input type="checkbox" name="MSMazedonien" value="Mazedonien">Mazedonien</td>
				
					<td><input type="checkbox" name="MSSlowenien" value="Slowenien">Slowenien</td>
				</tr>
				<tr>
					<td><input type="checkbox" name="MSAlbanien" value="Albanien">Albanien</td>
					<td><input type="checkbox" name="MSGeorgien" value="Georgien">Georgien</td>
					<td><input type="checkbox" name="MSIsrael" value="Israel">Israel</td>
					<td><input type="checkbox" name="MSNiederlande" value="Niederlande">Niederlande</td>
				
					<td><input type="checkbox" name="MSSpanien" value="Spanien">Spanien</td>
				</tr>
				<tr>
					<td><input type="checkbox" name="MSAlgerien" value="Algerien">Algerien</td>
					<td><input type="checkbox" name="MSGriechenland" value="Griechenland, griechisch">Griechenland</td>
					<td><input type="checkbox" name="MSKroatien" value="Kroatien">Kroatien</td>
					<td><input type="checkbox" name="MS&Ouml;sterreich" value="&Ouml;sterreich">&Ouml;sterreich</td>
				
					<td><input type="checkbox" name="MSSyrien" value="Syrien">Syrien</td>
				</tr>
				<tr>
					<td><input type="checkbox" name="MSArmenien" value="Armenien, armenisch">Armenien</td>
					<td><input type="checkbox" name="MSGro&szlig;britannien" value="Gro&szlig;britannien">Gro&szlig;britannien</td>
					<td><input type="checkbox" name="MSLibanon" value="Libanon">Libanon</td>
					<td><input type="checkbox" name="MSPortugal" value="Portugal">Portugal</td>
				
					<td><input type="checkbox" name="MST&uuml;rkei" value="T&uuml;rkei">T&uuml;rkei</td>
				</tr>
				<tr>
					<td><input type="checkbox" name="MSBelgien" value="Belgien">Belgien</td>
					<td><input type="checkbox" name="MSItalien" value="Italien">Italien</td>
					<td><input type="checkbox" name="MSLibyen" value="Libyen">Libyen</td>
					<td><input type="checkbox" name="MSRum&auml;nien" value="Rum&auml;nien">Rum&auml;nien</td>
				
					<td><input type="checkbox" name="MSTunesien" value="Tunesien">Tunesien</td>
				</tr>
				<tr>
					<td><input type="checkbox" name="MSBosnien" value="Bosnien">Bosnien</td>
					<td><input type="checkbox" name="MSIran" value="Iran, iranisch">Iran</td>
					<td><input type="checkbox" name="MSLuxemburg" value="Luxemburg">Luxemburg</td>
					<td><input type="checkbox" name="MSRu&szlig;land" value="Ru&szlig;land">Ru&szlig;land</td>
				
					<td><input type="checkbox" name="MSUkraine" value="Ukraine">Ukraine</td>
				</tr>
				<tr>
					<td><input type="checkbox" name="MSBulgarien" value="Bulgarien">Bulgarien</td>
					<td><input type="checkbox" name="MSIrak" value="Irak">Irak</td>
					<td><input type="checkbox" name="MSMalta" value="Malta">Malta</td>
					<td><input type="checkbox" name="MSSchweiz" value="Schweiz">Schweiz</td>
				
					<td><input type="checkbox" name="MSUngarn" value="Ungarn">Ungarn</td>
				</tr>
				<tr>
					<td><input type="checkbox" name="MSDeutschland" value="Deutschland">Deutschland</td>
					<td><input type="checkbox" name="MSIrland" value="Irland">Irland</td>
					<td><input type="checkbox" name="MSMarokko" value="Marokko">Marokko</td>
					<td><input type="checkbox" name="MSSerbien" value="Serbien">Serbien</td>
				
					<td><input type="checkbox" name="MSZypern" value="Zypern, zyprisch">Zypern</td>
				</tr>
				</table>  
				
				<p>
					<b>anderes modernes Land oder regionaler Zusatz:</b><br>
					<textarea name="MSGeographieText" rows="1" cols="40"></textarea>
				<p>
				<hr>
				<p>
				
				<b>Ausgew&auml;hlte Landschaftsbezeichnungen und Kulturkreise:</b><p>
				
				<i>Die geographischen Auswahlfelder beinhalten in der Regel zugleich das zugeh&ouml;rige Adjektiv (z.B. Griechenland, griechisch oder Italien, italisch).</i><p>
				
				<u><input type="checkbox" name="MSGermanien" value="Germanien, Germania, germanisch">Germanien:</u>
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSGermaniasuperior" value="Germania superior">Germania superior</td>
					<td><input type="checkbox" name="MSRaetien" value="Raetien, Raetia, raetisch">Raetien</td>
				</tr>
				<tr>
					<td><input type="checkbox" name="MSGermania inferior" value="Germania inferior">Germania inferior</td>
				
					<td><input type="checkbox" name="MSNoricum" value="Noricum, norisch">Noricum</td>
				</tr>
				</table><hr>
				<br>
				<input type="checkbox" name="MSr&ouml;misch" value="r&ouml;misch"><b>r&ouml;misch</b><p>
				
				<u><input type="checkbox" name="MSItalien2" value="Italien, italisch">Italien:</u>
				
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSEtrurien" value="Etrurien, etruskisch, Etrusker">Etrurien</td>
				
					<td><input type="checkbox" name="MSLatium" value="Latium, latinisch, Latiner">Latium</td>
					<td><input type="checkbox" name="MSUmbrien" value="Umbrien, umbrisch, Umbrer">Umbrien</td>
					<td>Sabin</td>
					<td></td>
				</tr>
				</table>
				<hr>
				<br>
				
				<u><input type="checkbox" name="MSGriechenland2" value="Griechenland, griechisch"><b>Griechenland</b>:</u>
				
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSPeloponnes" value="Peloponnes">Peloponnes</td>
				</tr>
				<tr>
					<td><input type="checkbox" name="MS&Auml;g&auml;is" value="&Auml;g&auml;is, &auml;g&auml;isch">&Auml;g&auml;is</td>
					<td><input type="checkbox" name="MSKykladen" value="Kykladen, kykladisch">Kykladen</td>
					<td><input type="checkbox" name="MSKreta" value="Kreta, kretisch">Kreta</td>
				
				</tr>
				<tr>
					<td><input type="checkbox" name="MSIonien" value="Ionien, ionisch">Ionien</td>
					<td><input type="checkbox" name="MSostgriechisch" value="ostgriechisch">ostgriechisch</td>
					<td><input type="checkbox" name="MSRhodos" value="Rhodos, rhodisch">Rhodos</td>
				</tr>
				</table>
				
				<u>antike Landschaften:</u>
				
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSAchaia" value="Achaia, Achaea, ach&auml;isch">Achaia</td>
					<td><input type="checkbox" name="MSAkarnanien" value="Akarnanien, akarnanisch">Akarnanien</td>
					<td><input type="checkbox" name="MSArkadien" value="Arkadien, Arcadia, arkadisch">Arkadien</td>
					<td><input type="checkbox" name="MSB&ouml;otien" value="B&ouml;otien, Boiotien, boiotisch, b&ouml;otisch">B&ouml;otien</td>
					<td><input type="checkbox" name="MSEpirus" value="Epirus, Epeiros, epirotisch, epeirotisch">Epirus</td>
				
					<td><input type="checkbox" name="MSLakonien" value="Lakonien, Sparta, lakonisch, spartanisch">Lakonien, Sparta</td>
					<td><input type="checkbox" name="MSMessene" value="Messene, messenisch">Messene</td>
				</tr>
				<tr>
					<td><input type="checkbox" name="MSAitolien" value="Aitolien, &Auml;tolien, aitolisch, &auml;tolisch">Aitolien</td>
					<td><input type="checkbox" name="MSArgolis" value="Argolis, argivisch">Argolis</td>
					<td><input type="checkbox" name="MSAttika" value="Attika, attisch">Attika</td>
				
					<td><input type="checkbox" name="MSElis" value="Elis, elisch">Elis</td>
					<td><input type="checkbox" name="MSEub&ouml;a" value="Eub&ouml;a, Euboia, eub&ouml;isch">Eub&ouml;a</td>
					<td><input type="checkbox" name="MSMakedonien" value="Makedonien, makedonisch">Makedonien</td>
					<td><input type="checkbox" name="MSThessalien" value="Thessalien, thessalisch">Thessalien</td>
				</tr>
				</table>
				<hr>
				<br>
				
				<u><input type="checkbox" name="MSGro&szlig;griechenland" value="Gro&szlig;griechenland, Magna Graecia, gro&szlig;griechisch, westgriechisch">Gro&szlig;griechenland:</u>
				
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSApulien" value="Apulien, apulisch">Apulien</td>
					<td><input type="checkbox" name="MSKampanien" value="Kampanien, Campanien, kampanisch, campanisch">Kampanien</td>
					<td><input type="checkbox" name="MSLukanien" value="Lukanien, lukanisch">Lukanien</td>
					<td><input type="checkbox" name="MSSizilien" value="Sizilien, sizilisch">Sizilien</td>
				
				</tr>
				</table>
				<hr>
				<br>
				
				<u><input type="checkbox" name="MSKleinasien" value="Kleinasien, kleinasiatisch">Kleinasien:</u>
				
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSArmenien2" value="Armenien, armenisch">Armenien</td>
					<td><input type="checkbox" name="MSGalatien" value="Galatien, Galatia, galatisch">Galatien</td>
					<td><input type="checkbox" name="MSKarien" value="Karien, karisch">Karien</td>
				
					<td><input type="checkbox" name="MSLydien" value="Lydien, lydisch">Lydien</td>
					<td><input type="checkbox" name="MSMysien" value="Mysien, mysisch">Mysien</td>
					<td><input type="checkbox" name="MSPaphlagonien" value="Paphlagonien, paphlagonisch">Paphlagonien</td>
					<td><input type="checkbox" name="MSPisidien" value="Pisidien, pisidisch">Pisidien</td>
				</tr>
				<tr>
					<td><input type="checkbox" name="MSBithynien" value="Bithynien, Bithynia, bithynisch">Bithynien</td>
				
					<td><input type="checkbox" name="MSKappadokien" value="Kappadokien, Cappadocia, kappadokisch">Kappadokien</td>
					<td><input type="checkbox" name="MSKilikien" value="Kilikien, Cilicien, Cilicia, kilikisch">Kilikien</td>
					<td><input type="checkbox" name="MSLykien" value="Lykien, lykisch">Lykien</td>
					<td><input type="checkbox" name="MSPamphylien" value="Pamphylien, pamphylisch">Pamphylien</td>
					<td><input type="checkbox" name="MSPhrygien" value="Phrygien, phrygisch">Phrygien</td>
					<td><input type="checkbox" name="MSPontos" value="Pontos, Pontus, pontisch">Pontos</td>
				
				</tr>
				</table>  
				<br>
					
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSanatolisch" value="anatolisch">anatolisch</td>
					<td><input type="checkbox" name="MSwestanatolisch" value="westanatolisch">westanatolisch</td>
					<td><input type="checkbox" name="MShethitisch" value="hethitisch, Hethiter">hethitisch</td>
					<td><input type="checkbox" name="MSurart&auml;isch" value="urart&auml;isch, Urartu">urart&auml;isch</td>
				
				</tr>
				</table>
				<hr>
				<br>
				
				<input type="checkbox" name="MSSchwarzmeergebiet" value="Schwarzmeergebiet, Schwarzes Meer"><u>Schwarzmeergebiet:</u>
				
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSThrakien" value="Thrakien, thrakisch, Thraker">Thrakien</td>
					<td><input type="checkbox" name="MSBosporanischesReich" value="Bosporanisches Reich, bosporanisch">Bosporanisches Reich</td>
					<td><input type="checkbox" name="MSSkythen" value="Skythen, skythisch, Skythien">Skythen</td>
				
				</tr>
				</table>
				<hr>
				<br>
				
				<input type="checkbox" name="MSwestlicher Mittelmeerraum" value="westlicher Mittelmeerraum"><u>westlicher Mittelmeerraum</u>
				
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSGallien" value="Gallien, gallisch, Gallier">Gallien</td>
					<td><input type="checkbox" name="MSgallo-r&ouml;misch" value="gallo-r&ouml;misch">gallo-r&ouml;misch</td>
				
					<td><input type="checkbox" name="MSKelten" value="Kelten, keltisch">Kelten</td>
					<td><input type="checkbox" name="MSkelt-iberisch" value="kelt-iberisch">kelt-iberisch</td>
				</tr>
				<tr>
					<td><input type="checkbox" name="MSIberien" value="Iberien, iberisch, Iberer">Iberien</td>
					<td><input type="checkbox" name="MSHispania" value="Hispania, hispanisch">Hispania</td>
					<td><input type="checkbox" name="MSBaetica" value="Baetica, baetisch">Baetica</td>
				
					<td><input type="checkbox" name="MSLusitania" value="Lusitania, lusitanisch">Lusitania</td>
				</tr>
				</table> 
				<hr>
				<br>
				
				<input type="checkbox" name="MS&ouml;stlicherMittelmeerraum" value="&ouml;stlicher Mittelmeerraum"><u>&ouml;stlicher Mittelmeerraum</u><br>
				<br>
				
					<input type="checkbox" name="MSVordererOrient" value="Vorderer Orient, Naher Osten, vorderorientalisch"><u>Vorderer Orient</u>
					
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				
				<tr>
					<td><input type="checkbox" name="MSPh&ouml;nizien" value="Ph&ouml;nizien, Ph&ouml;nizier, Ph&ouml;niker, Phoiniker, phoinikisch, ph&ouml;nizisch">Ph&ouml;nizien</td>
					<td><input type="checkbox" name="MSPal&auml;stina" value="Pal&auml;stina, pal&auml;stinisch">Pal&auml;stina</td>
					<td><input type="checkbox" name="MSpalmyrenisch" value="palmyrenisch, Palmyra">palmyrenisch</td>
					<td><input type="checkbox" name="MSnabat&auml;isch" value="nabat&auml;isch">nabat&auml;isch</td>
					<td><input type="checkbox" name="MSJud&auml;a" value="Jud&auml;a, jud&auml;isch">Jud&auml;a</td>
				
				</tr>
				</table>
				
					<input type="checkbox" name="MSMesopotamien" value="Mesopotamien, mesopotamisch"><u>Mesopotamien</u>
				
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSbabylonisch" value="babylonisch, Babylonier">babylonisch</td>
					<td><input type="checkbox" name="MSassyrisch" value="assyrisch, Assyrer">assyrisch</td>
					<td><input type="checkbox" name="MSneubabylonisch" value="neubabylonisch">neubabylonisch</td>
				
				</tr>
				</table>
				
					<input type="checkbox" name="MSPersien" value="Persien"><u>Persien</u>
				
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSmedisch" value="medisch, Meder">medisch</td>
					<td><input type="checkbox" name="MSpersisch" value="persisch">persisch</td>
					<td><input type="checkbox" name="MSparthisch" value="parthisch, Parther">parthisch</td>
				
					<td><input type="checkbox" name="MSsassanidisch" value="sassanidisch">sassanidisch</td>
				</tr>
				<tr>
					<td><input type="checkbox" name="MSgraeco-persisch" value="graeco-persisch, graeko-persisch">graeco-persisch</td>
				</tr>
				</table>
				<hr>
				<br>
				
				<input type="checkbox" name="MSBaktrien" value="Baktrien, baktrisch"><u>Baktrien</u>
				<br><br>
				<hr>
				
				<br>
				
				<input type="checkbox" name="MSNordafrika" value="Nordafrika, nordafrikanisch"><u>Nordafrika</u>
				
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				
					<input type="checkbox" name="MS&Auml;gypten" value="&Auml;gypten, &auml;gyptisch">&Auml;gypten
				<tr>	
					<td><input type="checkbox" name="MSAltesReich" value="Altes Reich">Altes Reich</td>
					<td><input type="checkbox" name="MSMittleres Reich" value="Mittleres Reich">Mittleres Reich</td>
					<td><input type="checkbox" name="MSNeues Reich" value="Neues Reich">Neues Reich</td>
				
					<td><input type="checkbox" name="MSPtolem&auml;isch" value="ptolem&auml;isch">ptolem&auml;isch</td>
					<td><input type="checkbox" name="MSkoptisch" value="koptisch, Kopten">koptisch</td>
				</tr>
				<tr>
					<td><input type="checkbox" name="MSKarthago" value="Karthago, karthagisch, punisch">Karthago</td>
					<td><input type="checkbox" name="MSCyrenaica" value="Cyrenaica, Kyrene, kyrenisch">Cyrenaica</td>
					<td><input type="checkbox" name="MSNumidien" value="Numidien, Numidia, numidisch">Numidien</td>
				
				</tr>
				</table>
				<hr>
				<p>
					<b>anderer Kulturkreis oder genauere Bezeichnung:</b><br>
					<textarea name="MSKulturkreisText" rows="2" cols="40"></textarea>
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
						<td><input type="button" value="eingeben" onclick="saveSelection('obj_culture');history.back();"></td>
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
END ac_edit_obj_culture.tpl
================================================= -->
