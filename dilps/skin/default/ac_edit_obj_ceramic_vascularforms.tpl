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
BEGIN ac_edit_obj_ceramic_vascularforms.tpl
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
	
	{query_ext_element type="archaeology" element="obj_ceramic_vascularforms" fieldnames="fieldnames" values="values" sql="sql" query=$query}
	
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
			<td class="heading">Gef&auml;&szlig;formen</td>
		</tr>
		<tr>
			<td style="height: 20px;">
				&nbsp;
			</td>
		</tr>
		<tr>
			<td>
				<ul>	<input type="checkbox" name="MSAlabastron" value="Alabastron, Alabastra">Alabastron<br>
					<input type="checkbox" name="MSAmphore" value="Amphore, Amphora">Amphore
				<ul>		<input type="checkbox" name="MSBauchamphore" value="Bauchamphore, Bauchamphora">Bauchamphore<br>
						<input type="checkbox" name="MSHalsamphore" value="Halsamphore, Halsamphora">Halsamphore
				<ul>			<input type="checkbox" name="MSPreisamphore" value="Panathen&auml;ische Amphore, Panathen&auml;ische Amphora, Panathen&auml;ische Preisamphore, Panathen&auml;ische Preisamphora">Panathen&auml;ische Amphore<br>
				
							<input type="checkbox" name="MSStrickhenkelamphore" value="Strickhenkelamphore, Strickhenkelamphora">Strickhenkelamphore<br>
							<input type="checkbox" name="MSNolanischeAmphore" value="Nolanische Amphore, Nolanische Amphora">Nolanische Amphore<br>
							<input type="checkbox" name="MSSpitzamphore" value="Spitzamphore, Spitzamphora">Spitzamphore</ul>
						<input type="checkbox" name="MSBandhenkelamphore" value="Bandhenkelamphore, Bandhenkelamphora">Bandhenkelamphore<br>
				<ul>			<input type="checkbox" name="MSNikosthenischeAmphora" value="Nikosthenische Amphora, Nikosthenische Amphore">Nikosthenische Amphore<br></ul>
						<input type="checkbox" name="MSSchulterhenkelamphore" value="Schulterhenkelamphore, Schulterhenkelamphora">Schulterhenkelamphore<br>
				
						<input type="checkbox" name="MSReliefamphore" value="Reliefamphore, Reliefamphora">Reliefamphore<br>
						<input type="checkbox" name="MSTransportamphore" value="Transportamphore, Transportamphora">Transportamphore</ul>
					<input type="checkbox" name="MSAmphoriskos" value="Amphoriskos, Amphoriskoi">Amphoriskos<br>
					<input type="checkbox" name="MSAmpulla" value="Ampulla, Pilgerfl&auml;schchen">Ampulla (Pilgerfl&auml;schchen)<br>
				
					<input type="checkbox" name="MSAryballos" value="Aryballos, Aryballoi">Aryballos<br>
				
					<input type="checkbox" name="MSAskos" value="Askos, Askoi">Askos<br>
				<ul>		<input type="checkbox" name="MSRingaskos" value="Ringaskos, Ringaskoi">Ringaskos</ul>
				
					<input type="checkbox" name="MSBecher" value="Becher">Becher
				<ul>		<input type="checkbox" name="MSMegarischerBecher" value="Megarischer Becher, Megarische Becher">Megarischer Becher<br>
						<input type="checkbox" name="MSFaltenbecher" value="Faltenbecher">Faltenbecher</ul>
					<input type="checkbox" name="MSBecken" value="Becken">Becken<br>
				
					<input type="checkbox" name="MSB&uuml;gelkanne" value="B&uuml;gelkanne">B&uuml;gelkanne<br>
					<input type="checkbox" name="MSDeckel" value="Deckel">Deckel<br>
					<input type="checkbox" name="MSDinos" value="Dinos, Dinoi">Dinos<br>
					<input type="checkbox" name="MSFigurengef&auml;&szlig;" value="Figurengef&auml;&szlig;">Figurengef&auml;&szlig;<br>
				
					<input type="checkbox" name="MSFlasche" value="Flasche">Flasche
				<ul>		<input type="checkbox" name="MSLagynos" value="Lagynos, Lagynoi">Lagynos</ul>
				
					<input type="checkbox" name="MSGuttus" value="Guttus, Gutti">Guttus<br>
					<input type="checkbox" name="MSHydria" value="Hydria">Hydria<br>
				<ul>		<input type="checkbox" name="MSKalpis" value="Kalpis">Kalpis<br>
						<input type="checkbox" name="MSCaeretaner Hydria" value="Caeretaner Hydria">Caeretaner Hydria</ul>
				
					<input type="checkbox" name="MSKanne" value="Kanne">Kanne
				<ul>		<input type="checkbox" name="MSPlatschk&auml;nnchen" value="Platschk&auml;nnchen">Platschk&auml;nnchen<br>
				
						<input type="checkbox" name="MSOinochoe" value="Oinochoe">Oinochoe<br>
							<input type="checkbox" name="MSChous" value="Chous">Chous<br>
							<input type="checkbox" name="MSChoenk&auml;nnchen" value="Choenk&auml;nnchen">Choenk&auml;nnchen<br>
						<input type="checkbox" name="MSOlpe" value="Olpe">Olpe</ul>
					<input type="checkbox" name="MSKantharos" value="Kantharos, Kantharoi">Kantharos<br>
					<input type="checkbox" name="MSKelch" value="Kelch">Kelch<br>
				
					<input type="checkbox" name="MSKessel" value="Kessel">Kessel<br>
				
					<input type="checkbox" name="MSKrater" value="Krater">Krater
				<ul>		<input type="checkbox" name="MSGlockenkrater" value="Glockenkrater">Glockenkrater<br>
						<input type="checkbox" name="MSKelchkrater" value="Kelchkrater">Kelchkrater<br>
						<input type="checkbox" name="MSKolonettenkrater" value="Kolonettenkrater">Kolonettenkrater<br>
						<input type="checkbox" name="MSVolutenkrater" value="Volutenkrater">Volutenkrater<br>
				
						<input type="checkbox" name="MSLakonischerKrater" value="Lakonischer Krater">Lakonischer Krater</ul>
					<input type="checkbox" name="MSKyathos" value="Kyatho, Kyathoi">Kyathos<br>
				
					<input type="checkbox" name="MSLampe" value="Lampe">Lampe<br>
					<input type="checkbox" name="MSLebesGamikos" value="Lebes Gamikos">Lebes Gamikos<br>
					<input type="checkbox" name="MSLekanis	" value="Lekanis, Lekaniden">Lekanis<br>
					<input type="checkbox" name="MSLekythos" value="Lekythos, Lekythoi">Lekythos
				
				<ul>		<input type="checkbox" name="MSDeianeira-Lekythos" value="Deianeira-Lekythos">Deianeira-Lekythos<br>
						<input type="checkbox" name="MSSchulterlekythos" value="Schulterlekythos">Schulterlekythos<br>
						<input type="checkbox" name="MSBauchlekythos" value="Bauchlekythos">Bauchlekythos<br>
						<input type="checkbox" name="MSEichellekythos" value="Eichellekythos, Eichel-Lekythos">Eichellekythos<br>
						<input type="checkbox" name="MSRelieflekythos" value="Relieflekythos, Relieflekythoi">Relieflekythos</ul>
					<input type="checkbox" name="MSLouthrophore" value="Louthrophore, Louthrophoros">Louthrophore<br>
				
					<input type="checkbox" name="MSLydion" value="Lydion">Lydion<br>
					<input type="checkbox" name="MSMastos" value="Mastos, Mastoi">Mastos<br>
				
					<input type="checkbox" name="MSNapf" value="Napf">Napf<br>
				<ul>		<input type="checkbox" name="MSEinhenkler" value="Einhenkler">Einhenkler</ul>
					<input type="checkbox" name="MSOlla" value="Olla">Olla<br>
					<input type="checkbox" name="MSPelike" value="Pelike">Pelike
				
				<ul>		<input type="checkbox" name="MSKertscherPelike" value="Kertscher Pelike">Kertscher Pelike</ul>
					<input type="checkbox" name="MSPinax2" value="Pinax, Pinakes">Pinax<br>
					<input type="checkbox" name="MSPithos" value="Pithos, Pithoi">Pithos<br>
				<ul>		<input type="checkbox" name="MSReliefpithos" value="Reliefpithos, Reliefpithoi">Reliefpithos</ul>
					<input type="checkbox" name="MSPlatte" value="Platte">Platte<br>
					<input type="checkbox" name="MSPsykter" value="Psykter">Psykter<br>
				
					<input type="checkbox" name="MSPyxis" value="Pyxis, Pyxiden">Pyxis
				<ul>		<input type="checkbox" name="MSPferdepyxis" value="Pferdepyxis, Pferdepyxiden">Pferdepyxis<br>
						<input type="checkbox" name="MSNikosthenischePyxis" value="Nikosthenische Pyxis, Nikosthenische Pyxiden">Nikosthenische Pyxis</ul>
					<input type="checkbox" name="MSRhyton" value="Rhyton, Rhyta">Rhyton<br>
					<input type="checkbox" name="MSSchale" value="Schale">Schale
				<ul>		<input type="checkbox" name="MSKotyle" value="Kotyle">Kotyle<br>
						<input type="checkbox" name="MSKylix" value="Kylix">Kylix<br>
				
						<input type="checkbox" name="MSPhiale/Omphalosschale" value="Phiale, Omphalosschale">Phiale/Omphalosschale<br>
						<input type="checkbox" name="MSKnopfhenkelschale" value="Knopfhenkelschale">Knopfhenkelschale<br>
						<input type="checkbox" name="MSTypA" value="Schale, Typ A">Schale, Typ A<br>
						<input type="checkbox" name="MSTypB" value="Schale, Typ B">Schale, Typ B<br>
						<input type="checkbox" name="MSTypC" value="Schale, Typ C">Schale, Typ C<br>
						<input type="checkbox" name="MSAugenschale" value="Augenschale">Augenschale<br>
				
				<ul>			<input type="checkbox" name="MSChalkidischeAugenschale" value="Chalkidische Augenschale">Chalkidische Augenschale<br>
							<input type="checkbox" name="MSOstgriechischeAugenschale" value="Ostgriechische Augenschale">Ostgriechische Augenschale</ul>
						<input type="checkbox" name="MSM&auml;anderschale" value="M&auml;anderschale">M&auml;anderschale<br>
						<input type="checkbox" name="MSRosettenschale" value="Rosettenschale">Rosettenschale<br>
						<input type="checkbox" name="MSSiana-Schale" value="Siana-Schale">Siana-Schale<br>
						<input type="checkbox" name="MSKomastenschale" value="Komastenschale">Komastenschale<br>
				
						<input type="checkbox" name="MSKleinmeisterschale" value="Kleinmeisterschale">Kleinmeisterschale<br>
				<ul>			<input type="checkbox" name="MSGordion-Schale" value="Gordion-Schale">Gordion-Schale<br>
							<input type="checkbox" name="MSRandschale" value="Randschale">Randschale<br>
							<input type="checkbox" name="MSBandschale" value="Bandschale">Bandschale<br>
							<input type="checkbox" name="MSDroop-Schale" value="Droop-Schale">Droop-Schale<br>
							<input type="checkbox" name="MSKassel-Schale" value="Kassel-Schale">Kassel-Schale</ul>
				
						<input type="checkbox" name="MSBl&uuml;tenbandschale" value="Bl&uuml;tenbandschale">Bl&uuml;tenbandschale<br>
						<input type="checkbox" name="MSKnickrandschale" value="Knickrandschale">Knickrandschale<br>
						<input type="checkbox" name="MSKnickwandschale" value="Knickwandschale">Knickwandschale<br>
						<input type="checkbox" name="MSEchinusschale" value="Echinusschale">Echinusschale<br>
						<input type="checkbox" name="MSSegmentschale" value="Segmentschale">Segmentschale<br>
						<input type="checkbox" name="MSRingfu&szlig;schale" value="Ringfu&szlig;schale">Ringfu&szlig;schale</ul>
				
					<input type="checkbox" name="MSSchalenskyphos" value="Schalenskyphos, Schalenskyphoi">Schalenskyphos<br>
					<input type="checkbox" name="MSSch&uuml;ssel" value="Sch&uuml;ssel">Sch&uuml;ssel<br>
					<input type="checkbox" name="MSSkyphos" value="Skyphos, Skyphoi">Skyphos<br>
				<ul>		<input type="checkbox" name="MSGlaux" value="Glaux">Glaux</ul>
					<input type="checkbox" name="MSStamnos" value="Stamnos, Stamnoi">Stamnos<br>
					<input type="checkbox" name="MSTeller" value="Teller">Teller<br>
				
				<ul>		<input type="checkbox" name="MSFischteller" value="Fischteller">Fischteller<br>
						<input type="checkbox" name="MSGestielterTeller" value="Gestielter Teller">Gestielter Teller</ul>
					<input type="checkbox" name="MSThymiaterion" value="Thymiaterion, Thymiatria">Thymiaterion<br>
					<input type="checkbox" name="MSTrozzella" value="Trozzella">Trozzella<br>
					<input type="checkbox" name="MSUnguentarium" value="Unguentarium, Unguentaria">Unguentarium<p></ul>
				
					<b>Form:</b><br>
				
					<textarea name="MSKeramikFormText" rows="1" cols="40"></textarea><br>
					<i>Auch abstrakte Formbenennungen wie z.B. "Dragendorff 33" oder "Hayes 72" sind m&ouml;glich,<br>
					wenn ein weiterer Oberbegriff wie "Transportamphore" hinzukommt.</i>
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
						<td><input type="button" value="eingeben" onclick="saveSelection('obj_ceramic_vascularforms');history.back();"></td>
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
END ac_edit_obj_ceramic_vascularforms.tpl
================================================= -->
