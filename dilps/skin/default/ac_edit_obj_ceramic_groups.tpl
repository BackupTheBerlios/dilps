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
BEGIN ac_edit_obj_ceramic_groups.tpl
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
	
	{query_ext_element type="archaeology" element="obj_ceramic_groups" fieldnames="fieldnames" values="values" sql="sql" query=$query}
	
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
			<td class="heading">Geographische, stilistische und zeitliche Gruppen</td>
		</tr>
		<tr>
			<td style="height: 20px;">
				&nbsp;
			</td>
		</tr>
		<tr>
			<td>
					<input type="checkbox" name="MShelladischeKeramik" value="helladische Keramik"><b>helladische Keramik</b><p>
					
					<input type="checkbox" name="MSminoischeKeramik" value="minoische Keramik"><b>minoische Keramik</b><p>
					
					<input type="checkbox" name="MSmykenische Keramik" value="mykenische Keramik"><b>mykenische Keramik</b><p>
				
				<hr><br>
				
					<b>Griechische bemalte Keramik</b><br>
				
				<p>
					<i>Wenn keine konkrete Keramik-Gruppe vorgegeben ist, bitte zun&auml;chst eine geografische Zuordnung w&auml;hlen (z.B. attisch, apulisch, ...) und dann eine zeitlich/technische Einordnung (z.B. geometrisch, schwarzfigurig, ...) vornehmen.</i><p>
				
					<input type="checkbox" name="MSattisch" value="attische Keramik">attisch
				
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSproto-attisch" value="proto-attische Keramik">proto-attisch</td>
					<td><input type="checkbox" name="MSkertscher Vasen" value="kertscher Vasen, attisch rotfigurig">kertscher Vasen</td>
				
					<td><input type="checkbox" name="MSWestabhangware" value="Westabhangware, West-Slopeware, attische Keramik">Westabhangware</td>
				</tr>
				</table>  	
					<input type="checkbox" name="MSargivisch" value="argivische Keramik">argivisch<br>
					<input type="checkbox" name="MSb&ouml;otisch" value="b&ouml;otische Keramik">b&ouml;otisch<br>
					<input type="checkbox" name="MSeub&ouml;isch" value="eub&ouml;ische Keramik">eub&ouml;isch<p>
					<input type="checkbox" name="MSkorinthisch" value="korinthische Keramik">korinthisch
				
				
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSproto-korinthisch" value="proto-korinthische Keramik">proto-korinthisch</td>
					<td><input type="checkbox" name="MSfr&uuml;hkorinthisch" value="fr&uuml;hkorinthische Keramik">fr&uuml;hkorinthisch</td>
					<td><input type="checkbox" name="MSmittelkorinthisch" value="mittelkorinthische Keramik">mittelkorinthisch</td>
					<td><input type="checkbox" name="MSsp&auml;tkorinthisch" value="sp&auml;tkorinthische Keramik">sp&auml;tkorinthisch</td>
				</tr>
				
				</table>
					<input type="checkbox" name="MSlakonisch" value="lakonische Keramik">lakonisch
				<p>
					<b>Gro&szlig;griechische Keramik</b><p>
					<input type="checkbox" name="MSapulisch" value="apulische Keramik">apulisch<br>
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSGnathiaKeramik" value="Gnathia-Keramik, Gnathia-Ware">Gnathia-Keramik</td>
					<td><input type="checkbox" name="MSXenon-Gattung" value="Xenon-Gattung">Xenon-Gattung</td>
				
				</tr>
				</table>  
					<input type="checkbox" name="MScalenisch" value="calenische Keramik">calenisch<br>
					<input type="checkbox" name="MScampanisch" value="campanische Keramik">campanisch<br>
					<input type="checkbox" name="MSlukanisch" value="lukanische Keramik">lukanisch<br>
					<input type="checkbox" name="MSpaestanisch" value="paestanische Keramik">paestanisch<br>
					<input type="checkbox" name="MSsizilisch" value="sizilische Keramik">sizilisch<br>
					<input type="checkbox" name="MSwestgriechisch" value="westgriechische Keramik">westgriechisch<p>
				
					<b>Inselgriechisch Keramik</b>
				
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSchiotisch" value="chiotische Keramik">chiotisch</td>
					<td><input type="checkbox" name="MSkretisch" value="kretische Keramik">kretisch</td>
					<td><input type="checkbox" name="MSkykladisch" value="kykladische Keramik">kykladisch</td>
					<td><input type="checkbox" name="MSmelisch" value="melische Keramik">melisch</td>
				
					<td><input type="checkbox" name="MSparisch" value="parische Keramik">parisch</td>
				</tr>
				</table>  
				
					<input type="checkbox" name="" value="Linearer Inselstil">Linearer Inselstil
				<p>
					
					<b>Ostgriechische und westanatolische Keramik</b>
				
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MS&auml;olisch" value="&auml;olische Keramik">&auml;olisch</td>
					<td><input type="checkbox" name="MSostionisch" value="ostionische Keramik">ostionisch</td>
				
					<td><input type="checkbox" name="MSdorisch" value="MSdorische Keramik">dorisch</td>
				</tr>
				<tr>
					<td><input type="checkbox" name="MSephesisch" value="ephesische Keramik">ephesisch</td>
					<td><input type="checkbox" name="MSmilesisch" value="milesische Keramik">milesisch</td>
					<td><input type="checkbox" name="MSklazomenisch" value="klazomenische Keramik">klazomenisch</td>
				</tr>
				<tr>
					<td><input type="checkbox" name="MSkarisch" value="karische Keramik">karisch</td>
				
					<td><input type="checkbox" name="MSlydisch" value="lydische Keramik">lydisch</td>
				</tr>
				</table>  
					<input type="checkbox" name="MSWildziegen-Stil" value="Wildziegen-Stil, wild-goat-style">Wildziegen-Stil<br>
					<input type="checkbox" name="MSFikellura" value="Fikellura">Fikellura<p>
				
					<b>Andere Herkunftsorte</b>
				
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
				
					<td><input type="checkbox" name="MSzyprisch" value="zyprische Keramik, kyprische Keramik">zyprisch</td>
					<td><input type="checkbox" name="MSnabat&auml;isch" value="nabat&auml;isch">nabat&auml;isch</td>
				</tr>
				</table>  
				
					<b>Unklare geographische Zuordnung</b>
				
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSchalkidisch" value="chalkidische Keramik">chalkidisch</td>
				
					<td><input type="checkbox" name="MSnordionisch" value="nordionische Keramik">nordionisch</td>
					<td><input type="checkbox" name="MSpontisch" value="pontische Keramik">pontisch</td>
				</tr>
				</table>  
				
				<br>
				<hr>
				<br>
					<b>Etruskische und italische Keramik</b>
				
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
				
					<td><input type="checkbox" name="MSImpastokeramik" value="Impastokeramik">Impastokeramik</td>
					<td><input type="checkbox" name="MSBucchero" value="Bucchero Keramik">Bucchero</td>
				</tr>
				</table>  
				
					<u>Bemalte Keramik:</u><p>
					<input type="checkbox" name="MSitalo-geometrisch" value="italo-geometrische Keramik">italo-geometrisch<br>
					<input type="checkbox" name="MSitalo-korinthisch" value="italo-korinthische Keramik">italo-korinthisch<br>
					<input type="checkbox" name="MSfaliskisch" value="faliskische Keramik, etruskisch rotfigurig">faliskisch<br>
				
					<input type="checkbox" name="MScanosinisch" value="canosinische Keramik, polychrom">canosinisch<br>
					<input type="checkbox" name="MSdaunisch" value="daunische Keramik">daunisch
				
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSpeuketisch" value="peuketische Keramik">peuketisch</td>
					<td><input type="checkbox" name="MSmessapisch" value="messapische Keramik">messapisch</td>
				</tr>
				</table>  
				
				<hr><br>
				
					<b>Stilistische, zeitliche und technische Aspekte</b>
				<p>
					<i>Bei Bedarf sind Mehrfachnennungen kein Problem.</i><p>
				
					<u>Bemalte Keramik:</u><br>
				
					<input type="checkbox" name="MSprotogeometrisch2" value="protogeometrische Keramik">protogeometrisch<br>
					<input type="checkbox" name="MSgeometrisch2" value="geometrische Keramik">geometrisch<br>
				
					<input type="checkbox" name="MSsubgeometrisch2" value="subgeometrische Keramik">subgeometrisch<br>
					<input type="checkbox" name="MSorientalisierend" value="orientalisierende Keramik">orientalisierend<br>
					<input type="checkbox" name="MSschwarzfigurig" value="schwarzfigurige Keramik">schwarzfigurig<br>
					<input type="checkbox" name="MSrotfigurig" value="rotfigurige Keramik">rotfigurig<br>
					<input type="checkbox" name="MSSix-Technik" value="Six-Technik">Six-Technik<br>
					<input type="checkbox" name="Westabhang-Technik" value="Westabhang-Technik">Westabhang-Technik<br>
				
					<input type="checkbox" name="MSpolychrom2" value="polychrome Keramik">polychrom<p>
				
					<input type="checkbox" name="MSGlanztonware" value="Glanztonware, Glanztonkeramik, Firnisware">Glanztonware
				
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSStempeldekor" value="Stempeldekor, Stempelware">Stempeldekor</td>
					<td><input type="checkbox" name="MSR&auml;dchendekor" value="R&auml;dchendekor">R&auml;dchendekor</td>
				</tr>
				</table>  
				
					<input type="checkbox" name="MSReliefkeramik" value="Reliefkeramik">Reliefkeramik
				
				<ul>		<input type="checkbox" name="MSApplikenware" value="Applikenware">Applikenware<br>
						<input type="checkbox" name="MSFormsch&uuml;sselkeramik" value="Formsch&uuml;sselkeramik">Formsch&uuml;sselkeramik<br>
						<input type="checkbox" name="MSBarbotine-Technik" value="Barbotine-Technik">Barbotine-Technik</ul>
				
					<input type="checkbox" name="MSroteWaren" value="rote Waren, Red-Slip-Wares">rote Waren/Red-Slip-Wares<br>
				<ul>		<input type="checkbox" name="MShellenistischeroteWare" value="hellenistische rote Ware, hellenistische rote Keramik">hellenistische rote Ware<br>
				
						<input type="checkbox" name="MSTerraSigillata" value="Terra Sigillata, TS">Terra Sigillata
				<ul>			<input type="checkbox" name="MSArretina" value="Arretina, arretinische Terra Sigillata">Arretina<br>
				<ul>				<input type="checkbox" name="MSgallischeTerraSigillata" value="gallische Terra Sigillata">gallische Terra Sigillata<br></ul>
							<u>&ouml;stliche Sigillaten:</u><br>
							<input type="checkbox" name="MSESA" value="ESA, Eastern-Sigillata A">ESA<br>
							<input type="checkbox" name="MSESB" value="ESB, Eastern-Sigillata B">ESB<br>
				
							<input type="checkbox" name="MSESC" value="ESC, Eastern-Sigillata C">ESC</ul>
				
					<input type="checkbox" name="MSAfrican Red-Slip" value="African Red-Slip">African Red-Slip<br></ul>
				
					<input type="checkbox" name="MSTerraNigra" value="Terra Nigra">Terra Nigra<br>
				
					<input type="checkbox" name="MSGlasurware" value="Glasurware, glasierte Ware, glasierte Keramik">Glasurware<br>
				<p>
					<b>andere Gruppen und n&auml;here Angaben:</b><br>
				
					<textarea name="MSKeramikGruppenText" rows="2" cols="40"></textarea>
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
						<td><input type="button" value="eingeben" onclick="saveSelection('obj_ceramic_groups');history.back();"></td>
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
END ac_edit_obj_ceramic_groups.tpl
================================================= -->
