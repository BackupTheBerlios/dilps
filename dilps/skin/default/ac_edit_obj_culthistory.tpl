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
BEGIN ac_edit_obj_culthistory.tpl
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
<script src="include/extended/ext_edit.js" type="text/javascript"></script>
</head>

<body class="headerstyle" style="width: 100%; height: 100%; vertical-align: top;">
	<form name="Main" action="{$SCRIPT_NAME}" method="POST" enctype="multipart/form-data">
	<input type="hidden" name="PHPSESSID" value="{$sessionid}">

	{if $query.id ne ""}
	
	{query_ext_element type="archaeology" element="obj_culthistory" fieldnames="fieldnames" values="values" sql="sql" query=$query}
	
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
			<td class="heading">Allgemeine Kulturgeschichte</td>
		</tr>
		<tr>
			<td style="height: 20px;">
				&nbsp;
			</td>
		</tr>
		<tr>
			<td>
				<i>An dieser Stelle kann eine kulturgeschichtliche Einordnung von Darstellungen und von Objekten erfolgen.<br>
				&Uuml;berschneidungen sind vor allem mit der <b>Ikonographie</b> gegeben.<br>
				Die Vorgaben k&ouml;nnen nicht vollst&auml;ndig sein, deshalb bitte unten weitere Eintr&auml;ge machen!</i><br>
				
				<hr>
				
					<b>Privatleben</b>
				
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSFamilie" value="Familie">Familie</td>
					<td><input type="checkbox" name="MSErziehung" value="Erziehung">Erziehung</td>
					<td><input type="checkbox" name="MSKindheit" value="Kindheit">Kindheit</td>
					<td><input type="checkbox" name="MSJugend" value="Jugend">Jugend</td>
				
					<td><input type="checkbox" name="MSAlter" value="Alter">Alter</td>
				</tr>
				<tr>
					<td><input type="checkbox" name="MSHaushalt" value="Haushalt, Mobiliar">Haushalt/Mobiliar</td>
				</tr>
				</table>  
				<hr>
					<b>&Ouml;ffentliches Leben</b>
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSPolitik" value="Politik">Politik</td>
				
					<td><input type="checkbox" name="MSAmtstr&auml;ger" value="Amtstr&auml;ger">Amtstr&auml;ger</td>
				</tr>
				<tr>
					<td><input type="checkbox" name="MSMusik" value="Musik">Musik</td>
					<td><input type="checkbox" name="MSTheater" value="Theater">Theater</td>
				</tr>
				<tr>
					<td><input type="checkbox" name="MSSport" value="Sport">Sport</td>
				
					<td><input type="checkbox" name="MSAgon" value="Wettk&auml;mpfe, Agon">Wettk&auml;mpfe, Agon</td>
					<td><input type="checkbox" name="MSGladiatorenwesen" value="Gladiatorenwesen">Gladiatorenwesen</td>
					<td><input type="checkbox" name="MSTierhetze" value="Tierhetze">Tierhetze</td>
				</tr>
				</table>  
				
				<hr>
				
					<b>Kultwesen/Religion</b>
				
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSKult" value="Kult, Religion">Kult, Religion</td>
					<td><input type="checkbox" name="MSKultperonal" value="Kultperonal">Kultperonal</td>
					<td><input type="checkbox" name="MSPriester" value="Priester, Priesterinen">Priester/Priesterin</td>
					<td><input type="checkbox" name="MSKultger&auml;t" value="Kultger&auml;te">Kultger&auml;t</td>
					<td><input type="checkbox" name="MSKultbild" value="Kultbilder">Kultbild</td>
				
				</tr>
				<tr>
					<td><input type="checkbox" name="MSOpferdiener" value="Opferdiener">Opferdiener</td>
					<td><input type="checkbox" name="MSOpferritual" value="Opferrituale">Opferritual</td>
					<td><input type="checkbox" name="MSOpferger&auml;t" value="Opferger&auml;t">Opferger&auml;t</td>
					<td><input type="checkbox" name="MSMenschenopfer" value="Menschenopfer">Menschenopfer</td>
				</tr>
				<tr>
				
					<td><input type="checkbox" name="MSTotenkult" value="Totenkult">Totenkult</td>
					<td><input type="checkbox" name="MSBegr&auml;bnisritual" value="Begr&auml;bnisrituale">Begr&auml;bnisritual</td>
				</tr>
				<tr>
					<td><input type="checkbox" name="MSProthesis" value="Prothesis">Prothesis</td>
					<td><input type="checkbox" name="MSEkphora" value="Ekphora">Ekphora</td>
					<td><input type="checkbox" name="MSGrabKult" value="Grab, Gr&auml;ber">Grab</td>
				
					<td><input type="checkbox" name="MSGrabdenkmal" value="Grabdenkmal, Grabdenkm&auml;ler">Grabdenkmal</td>
				</tr>
				</table>  
				
				<hr>
				
				
					<b>Kleidung/Tracht/Mode</b>
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSHaartracht" value="Haartracht">Haartracht</td>
					<td><input type="checkbox" name="MSKleidung" value="Kleidung">Kleidung</td>
				
					<td><input type="checkbox" name="MSTrachtbestandteile" value="Trachtbestandteile">Trachtbestandteile</td>
				</tr>
				</table>  
				
				<hr>
				
					<b>Berufe und Handwerk</b>
				<p>
					<u>Nahrungsmittel</u>
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSLandwirtschaft" value="Landwirtschaft, Bauer">Landwirtschaft</td>
				
					<td><input type="checkbox" name="MSWeinbau" value="Weinbau">Weinbau</td>
				</tr>
				<tr>
					<td><input type="checkbox" name="MSM&uuml;ller" value="M&uuml;ller">M&uuml;ller</td>
					<td><input type="checkbox" name="MSB&auml;cker" value="B&auml;cker">B&auml;cker</td>
				</tr>
				<tr>
					<td><input type="checkbox" name="MSJagd" value="Jagd, J&auml;ger">Jagd</td>
				
					<td><input type="checkbox" name="MSFischerei" value="Fischerei">Fischerei</td>
				</tr>
				</table>  
				
					<u>Textilherstellung</u>
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSSpinnen" value="Spinnen, Textilien">Spinnen</td>
					<td><input type="checkbox" name="MSWeben" value="Weben, Textilien">Weben</td>
				</tr>
				</table>  
				
					<u>Holzbearbeitung</u>
				
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSZimmermann" value="Zimmermann, Zimmerei">Zimmermann</td>
				</tr>
				</table>  
				
					<u>Steinbearbeitung</u>
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
						<td><input type="checkbox" name="MSSteinbruch" value="Steinbruch">Steinbruch</td>
						<td><input type="checkbox" name="MSSteinmetz" value="Steinmetz">Steinmetz</td>
				
						<td><input type="checkbox" name="MSBildhauer" value="Bildhauer">Bildhauer</td>
				</tr>
				</table>  
				
					<u>Metallbearbeitung</u>
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSSchmied" value="Schmiede">Schmied</td>
					<td><input type="checkbox" name="MSGu&szlig;technik" value="Gu&szlig;technik">Gu&szlig;technik</td>
					<td><input type="checkbox" name="MSSchmiedetechnik" value="Schmiedetechnik">Schmiedetechnik</td>
				
				</tr>
				</table>  
				
					<u>Markt und Handel</u>
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSH&auml;ndler" value="H&auml;ndler">H&auml;ndler</td>
					<td><input type="checkbox" name="MSWaagen" value="Waagen">Waagen</td>
					<td><input type="checkbox" name="MSGewichte" value="Gewichte">Gewichte</td>
					<td><input type="checkbox" name="MSMa&szlig;e" value="Ma&szlig;e">Ma&szlig;e</td>
				
				</tr>
				</table>  
				
					<u>T&ouml;pferei</u>
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MST&ouml;pfer" value="T&ouml;pferei">T&ouml;pfer</td>
					<td><input type="checkbox" name="MST&ouml;pferscheibe" value="T&ouml;pferscheiben">T&ouml;pferscheibe</td>
					<td><input type="checkbox" name="MST&ouml;pferofen" value="T&ouml;pferofen">T&ouml;pferofen</td>
				
					<td><input type="checkbox" name="MSVasenmaler" value="Vasenmaler">Vasenmaler</td>
				</tr>
				</table>
				
					<u>Glasherstellung<input type="checkbox" name="MSGlasherstellung" value="Glasherstellung"></u>
				<p>
					<u>Bergbau<input type="checkbox" name="MSBergbau" value="Bergbau"></u>
				<p>
					<u>andere</u>
				
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSMaler" value="Maler">Maler</td>
					<td><input type="checkbox" name="MSMosaizist" value="Mosaizist">Mosaizist</td>
				</tr>
				<tr>
					<td><input type="checkbox" name="MSArzt" value="Arzt, Medizin">Arzt/Medizin</td>
					<td><input type="checkbox" name="MSGerichtswesen" value="Gerichtswesen">Gerichtswesen</td>
				</tr>
				
				</table>  
				<hr>
				
					<b>Transport/Verkehr</b>
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSHandelswege" value="Handelswege">Handelswege</td>
					<td><input type="checkbox" name="MSLandverkehr" value="Landverkehr">Landverkehr</td>
					<td><input type="checkbox" name="MSWagen" value="Wagen">Wagen</td>
				
				</tr>
				<tr>
					<td><input type="checkbox" name="MSSeeverkehr" value="Seeverkehr, Schifffahrt">Schifffahrt</td>
					<td><input type="checkbox" name="MSFlu&szlig;schifffart" value="Flu&szlig;schifffart">Flu&szlig;schifffart</td>
					<td><input type="checkbox" name="MSSchiffe" value="Schiffe">Schiffe</td>
				</tr>
				</table>  
				
				<hr>
				
					<b>Milit&auml;rwesen</b>
				
				<p>
					<u>Waffen</u>
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSSchwert" value="Schwert">Schwert</td>
					<td><input type="checkbox" name="MSDolch" value="Dolch">Dolch</td>
					<td><input type="checkbox" name="MSMesser" value="Messer">Messer</td>
					<td><input type="checkbox" name="MSAxt" value="Axt">Axt</td>
				
				</tr>
				<tr>
					<td><input type="checkbox" name="MSLanze" value="Lanze">Lanze</td>
					<td><input type="checkbox" name="MSSpeer" value="Speer">Speer</td>
					<td><input type="checkbox" name="MSSchleuderblei" value="Schleuderblei">Schleuderblei</td>
					<td><input type="checkbox" name="MSPfeil" value="Pfeil">Pfeilspitze</td>
				</tr>
				</table>  
				
					<i>griechisch</i>
				
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSMacheira" value="Macheira">Macheira (Hiebschwert)</td>
				</tr>
				</table>  
				
					<i>r&ouml;misch</i>
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSGladius" value="Gladius">Gladius (Legion&auml;rsschwert)</td>
					<td><input type="checkbox" name="MSSpatha" value="Spatha">Spatha (Hiebschwert)</td>
				
					<td><input type="checkbox" name="MSPugio" value="Pugio">Pugio (Dolch)</td>
					<td><input type="checkbox" name="MSPilum" value="Pilum">Pilum</td>
				</tr>
				</table>  
					
					<u>R&uuml;stung</u>
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSHelm" value="Helm">Helm</td>
					<td><input type="checkbox" name="MSSchild" value="Schild">Schild</td>
				
					<td><input type="checkbox" name="MSPanzer" value="Panzer">Panzer</td>
				</tr>
				</table>  
				
					<i>griechisch</i>
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td>Helme</td>
					<td><input type="checkbox" name="MSattischerHelm" value="attischer Helm">attisch</td>
					<td><input type="checkbox" name="MSkorinthischerHelm" value="korinthischer Helm">korinthisch</td>
				
					<td><input type="checkbox" name="MSPiloshelm" value="Piloshelm">Piloshelm</td>
					<td><input type="checkbox" name="MSReiterhelm" value="Reiterhelm">Reiterhelm</td>
				</tr>
				<tr>
					<td>Schild</td>
					<td><input type="checkbox" name="MSHoplon" value="Hoplon">Hoplon</td>
					<td><input type="checkbox" name="MSPelta" value="Pelta">Pelta</td>
				
					<td><input type="checkbox" name="MSSchildzeichen" value="Schildzeichen">Schildzeichen</td>
				</tr>
				<tr>
					<td>Panzer</td>
					<td><input type="checkbox" name="MSGlockenpanzer" value="Glockenpanzer">Glockenpanzer</td>
					<td><input type="checkbox" name="MSMuskelpanzer" value="Muskelpanzer">Muskelpanzer</td>
					<td><input type="checkbox" name="MSPteryges" value="Pteryges">Pteryges (Lederzungen)</td>
				
					<td><input type="checkbox" name="MSBeinschienen" value="Beinschienen">Beinschienen</td>
				</tr>
				</table>  
				
					<i>r&ouml;misch</i>
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td>Helm</td>
					<td><input type="checkbox" name="MSMontefortino" value="Typ Montefortino">Typ Montefortino</td>
					<td><input type="checkbox" name="MSWeisenau" value="Typ Weisenau">Typ Weisenau</td>
				
					<td><input type="checkbox" name="MSHagenau" value="Typ Hagenau">Typ Hagenau</td>
					<td><input type="checkbox" name="MSGesichtshelm" value="Gesichtshelm">Gesichtshelm</td>
				</tr>
				<tr>
					<td>Schild</td>
					<td><input type="checkbox" name="MSScutum" value="Scutum">Scutum (Legion&auml;rsschild)</td>
				</tr>
				<tr>
				
					<td>Panzer</td>
					<td><input type="checkbox" name="MSLorica" value="Lorica">Lorica</td>
				</tr>
				<tr>
					<td>Gurte</td>
					<td><input type="checkbox" name="MSCingulum" value="Cingulum">Cingulum</td>
				</tr>
				</table>  
				
					<u>Kriegsmaschinen</u>
				
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
						<td><input type="checkbox" name="MSBelagerungsturm" value="Belagerungsturm">Belagerungsturm</td>
						<td><input type="checkbox" name="MSRammbock" value="Rammbock">Rammbock</td>
						<td><input type="checkbox" name="MSKatapult" value="Katapult">Katapult</td>
						<td><input type="checkbox" name="MSBallista" value="Ballista, Balliste">Ballista</td>
				</tr>
				</table>  
				
					<u>Rang und Ehrenzeichen</u>
				
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
						<td><input type="checkbox" name="MSFeldherrnbinde" value="Feldherrnbinde">Feldherrnbinde</td>
						<td><input type="checkbox" name="MSPhalerae" value="Phalerae">Phalerae</td>
						<td><input type="checkbox" name="MSTorques" value="Torques">Torques</td>
						<td><input type="checkbox" name="MSCorona" value="Corona">Corona</td>
				</tr>
				</table>  
				
				<p>
				
					<b>weitere Angaben:</b><br>
					<textarea name="MSAllgemeineKulturgeschichteText" rows="3" cols="40"></textarea>
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
						<td><input type="button" value="eingeben" onclick="saveSelection('obj_culthistory');history.back();"></td>
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
END ac_edit_obj_culthistory.tpl
================================================= -->
