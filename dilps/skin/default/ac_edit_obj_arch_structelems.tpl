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
BEGIN ac_edit_obj_arch_structelems.tpl
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
	
	{query_ext_element type="archaeology" element="obj_arch_structelems" fieldnames="fieldnames" values="values" sql="sql" query=$query}
	
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
			<td class="heading">Bauordnung/Bauglieder/Bautechnik</td>
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
					<td><input type="checkbox" name="MS&auml;olisch" value="&auml;olisch, &auml;olische Bauordnung">&auml;olisch</td>
					<td><input type="checkbox" name="MSdorisch" value="dorisch, dorische Bauordnung">dorisch</td>
					<td><input type="checkbox" name="MSionisch" value="ionisch, ionische Bauordnung">ionisch</td>
					<td><input type="checkbox" name="MSkorinthisch" value="korinthisch, korinthische Bauordnung">korinthisch</td>
					<td><input type="checkbox" name="MSkomposit" value="komposit, komposite Bauordnung">komposit</td>
				
					<td><input type="checkbox" name="MStuskanisch" value="tuskanisch, tuskisch, tuskanische Bauordnung, tuskische Bauordnung">tuskanisch</td>
				</tr>
				</table>  
				<hr>
					<b><u>Bauglieder/Bautechnik</u></b><p>
				
					<input type="checkbox" name="MSTerrassenmauer" value="Terrassenmauer, St&uuml;tzmauer">Terrassenmauer/St&uuml;tzmauer<br>
				<hr>
					<input type="checkbox" name="MSFundament" value="Fundament">Fundament<br>
				
					<input type="checkbox" name="MSPodium" value="Podium">Podium
				<hr>
					<input type="checkbox" name="MSBoden" value="Boden"><b>Boden</b><br>
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSPaviment" value="Paviment">Paviment</td>
					<td><input type="checkbox" name="MSOpussigninum" value="Opus signinum">Opus signinum</td>
					<td><input type="checkbox" name="MSMosaik2" value="Mosaik">Mosaik (genauere Bezeichnung dort angeben)</td>
				
				</tr>
				</table>  
				<hr>
					<input type="checkbox" name="MSMauer" value="Mauer, Wand"><b>Mauer/Wand</b><p>
				
					<u>Mauertechnik:</u><br>
					<input type="checkbox" name="MSBruchsteinmauer" value="Bruchsteinmauerwerk">Bruchsteinmauerwerk<br>
					<input type="checkbox" name="MSPolygonalesMauerwerk" value="Polygonales Mauerwerk, Polygonalmauer">Polygonales Mauerwerk<br>
					<input type="checkbox" name="MSQuadermauer" value="Quadermauerwerk">Quadermauerwerk<br>
				
						<input type="checkbox" name="MSIsodomesMauerwerk" value="Isodomes Mauerwerk">Isodomes Mauerwerk<br>
						<input type="checkbox" name="MSPseudo-isodomes Mauerwerk" value="Pseudo-isodomes Mauerwerk">Pseudo-isodomes Mauerwerk<br>
				
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSKlammer" value="Klammer, Verklammerung">Klammer/Verklammerung</td>
					<td><input type="checkbox" name="MSKlammerloch" value="Klammerloch">Klammerloch</td>
					<td><input type="checkbox" name="MSBleivergu&szlig;" value="Bleivergu&szlig;">Bleivergu&szlig;</td>
				
					<td><input type="checkbox" name="MSStemmloch" value="Stemmloch">Stemmloch</td>
				</tr>
				</table>  
					<input type="checkbox" name="MSZiegel" value="Ziegelmauerwerk">Ziegelmauerwerk<br>
					<input type="checkbox" name="MSLehmziegel" value="Lehmziegelmauerwerk">Lehmziegelmauerwerk<br>
					<input type="checkbox" name="MSFachwerk" value="Fachwerk">Fachwerk<p>
					
					<u>r&ouml;mische Bezeichnungen:</u><br>
				
					<input type="checkbox" name="MSOpusquadratum" value="Opus quadratum, Quadermauerwerk">Opus quadratum (Quadermauerwerk)<br>
					<input type="checkbox" name="MSOpusrusticum" value="Opus rusticum, Quadermauerwerk">Opus rusticum (ungegl&auml;ttetes Quadermauerwerk)<br>
					<input type="checkbox" name="MSOpuscaementitium" value="Opus caementitium">Opus caementitium
				
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSOpusincertum" value="Opus incertum, Opus caementitium">Opus incertum</td>
					<td><input type="checkbox" name="MSOpusquasireticulatum" value="Opus quasireticulatum, Opus caementitium">Opus quasireticulatum</td>
				
					<td><input type="checkbox" name="MSOpusreticulatum" value="Opus reticulatum, Opus caementitium">Opus reticulatum</td>
					<td><input type="checkbox" name="MSOpusmixtum" value="Opus mixtum, Opus caementitium">Opus mixtum</td>
				</tr>
				</table>  
				
					<input type="checkbox" name="MSOpustestaceum" value="Opus testaceum, Ziegelmauerwerk">Opus testaceum (Ziegelmauerwerk)
				
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSZiegelstempel" value="Ziegelstempel">Ziegelstempel</td>
				</tr>
				</table>  
				<br>
				
					<u>spezielle Bauformen:</u><br>
					<input type="checkbox" name="MSApsis2" value="Apsis, Apsiden">Apsis<br>
					<input type="checkbox" name="MSFassade" value="Fassade">Fassade<br>
					<input type="checkbox" name="MSSockel" value="Sockel">Sockel<br>
					<input type="checkbox" name="MSOrthostat" value="Orthostat, Orthostaten">Orthostat<br>
					<input type="checkbox" name="MSVerkleidung" value="Verkleidung">Verkleidung
						<ul><input type="checkbox" name="MSMarmorinkrustation" value="Marmorinkrustation">Marmorinkrustation</ul>
				
				
				<hr>
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MST&uuml;r" value="T&uuml;r, Tor">T&uuml;r/Tor</td>
					<td><input type="checkbox" name="MSFenster" value="Fenster">Fenster</td>
				</tr>
				<tr>
					<td><input type="checkbox" name="MSSturz" value="Sturz">Sturz</td>
				
					<td><input type="checkbox" name="MSLaibung" value="Laibung">Laibung</td>
					<td><input type="checkbox" name="MSSchwelle" value="Schwelle">Schwelle</td>
				</tr>
				</table>  
				<hr>
					<input type="checkbox" name="MSSt&uuml;tze" value="St&uuml;tze"><b>St&uuml;tze/Auflage</b><br>
				
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSAnte" value="Ante">Ante</td>
				
					<td><input type="checkbox" name="MSKaryatide" value="Karyatide">Karyatide</td>
					<td><input type="checkbox" name="MSPfeiler" value="Pfeiler">Pfeiler</td>
					<td><input type="checkbox" name="MSS&auml;ule" value="S&auml;ule">S&auml;ule</td>
				</tr>
				</table>  
					<u>Teile:</u>
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSPlinthe" value="Plinthe">Plinthe</td>
				
				</tr>
				<tr>
					<td><input type="checkbox" name="MSBasis" value="Basis"><u>Basis</u></td>
					<td><input type="checkbox" name="" value="">Torus</td>
					<td><input type="checkbox" name="" value="">Trochilus</td>
				</tr>
				<tr>
					<td><input type="checkbox" name="MSSchaft" value="Schaft"><u>Schaft</u></td>
					<td><input type="checkbox" name="" value="">kanneliert</td>
				
					<td><input type="checkbox" name="" value="">unkanneliert</td>
				</tr>
				<tr>
					<td><input type="checkbox" name="MSKapitell" value="Kapitell"><u>Kapitell</u></td>
					<td><input type="checkbox" name="MSAbakus" value="Abakus, Abakusplatte">Abakus</td>
					<td><input type="checkbox" name="MSEchinus" value="Echinus">Echinus</td>
					</tr>
				<tr>
				
					<td></td>
					<td><u>dorisch</u></td>
					<td><input type="checkbox" name="MSAnuli" value="Anuli">Anuli</td>
					<td><input type="checkbox" name="MSHypotrachelion" value="Hypotrachelion">Hypotrachelion</td>	
				</tr>
				<tr>
					<td></td>
					<td><u>ionisch</u></td>
				
					<td><input type="checkbox" name="MSCanalis" value="Canalis">Canalis</td>
					<td><input type="checkbox" name="MSVolute" value="Volute, ionisches Kapitell">Volute</td>
					<td><input type="checkbox" name="MSEckvolute" value="Eckvolute">Eckvolute</td>
					<td><input type="checkbox" name="MSZwickelpalmette" value="Zwickelpalmette">Zwickelpalmette</td>
					<td><input type="checkbox" name="MSAstragalKapitell" value="Astragal, ionisches Kapitell">Astragal</td>
					<td><input type="checkbox" name="MSKymaKapitell" value="Kyma, Kymation, ionisches Kapitell">Kyma</td>
				
				</tr>
				<tr>
					<td></td>
					<td><u>korinthisch</u></td>
					<td><input type="checkbox" name="" value="">Abakusbl&uuml;te</td>
					<td><input type="checkbox" name="" value="">Akanthusblatt</td>
					<td><input type="checkbox" name="" value="">Helices</td>
				
					<td><input type="checkbox" name="" value="">Caules</td>
				</tr>
				
				
				</table>  
				
					<input type="checkbox" name="MSK&auml;mpfer" value="K&auml;mpfer">K&auml;mpfer<br>
				<hr>
					<input type="checkbox" name="MSGeb&auml;lk" value="Geb&auml;lk"><b>Geb&auml;lk</b>
				
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				
				<tr>
					<td><input type="checkbox" name="MSAttika" value="Attika">Attika</td>
					<td><input type="checkbox" name="MSArchitrav" value="Architrav">Architrav</td>
					<td><input type="checkbox" name="MSFries" value="Fries">Fries</td>
					<td><input type="checkbox" name="MSGesims" value="Gesims">Gesims</td>
					<td><input type="checkbox" name="MSGiebel" value="Giebel">Giebel</td>
				</tr>
				
				<tr>
					<td><input type="checkbox" name="MSMetope" value="Metope">Metope</td>
					<td><input type="checkbox" name="Soffitte" value="Soffitte">Soffitte</td>
					<td><input type="checkbox" name="MSTriglyphe" value="Triglyphe">Triglyphe</td>
					<td><input type="checkbox" name="MSZahnschnitt" value="Zahnschnitt">Zahnschnitt</td>
				</tr>
				</table>  
				<hr>
					<input type="checkbox" name="MSDecke" value="Decken"><b>Decke</b>
				
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSKassettendecke" value="Kassettendecken">Kassettendecke</td>
					<td><input type="checkbox" name="MSGew&ouml;lbe" value="Gew&ouml;lbe">Gew&ouml;lbe</td>
					<td><input type="checkbox" name="MSKuppel" value="Kuppeln">Kuppel</td>
				</tr>
				<tr>
					<td></td>
				
					<td><input type="checkbox" name="MSKreuzgratgew&ouml;lbe" value="Kreuzgratgew&ouml;lbe">Kreuzgratgew&ouml;lbe</td>
					<td><input type="checkbox" name="MSSchirmkuppel" value="Schirmkuppeln">Schirmkuppel</td>
				</tr>
				<tr>
					<td></td>
					<td><input type="checkbox" name="MSTonr&ouml;hrengew&ouml;lbe" value="Tonr&ouml;hrengew&ouml;lbe">Tonr&ouml;hrengew&ouml;lbe</td>
				</tr>
				
				</table>  
				<hr>
					<input type="checkbox" name="MSDach" value="Dach"><b>Dach</b>
				
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSDachziegel" value="Dachziegel">Dachziegel</td>
					<td><input type="checkbox" name="MSAntefix" value="Antefix">Antefix</td>
					<td><input type="checkbox" name="MSAkroter" value="Akroter">Akroter</td>
				
					<td><input type="checkbox" name="MSSima" value="Sima">Sima</td>
				</tr>
				<tr>
					<td><input type="checkbox" name="MSKalypter" value="Kalypter">Kalypter</td>
					<td></td>
					<td><input type="checkbox" name="MSMittelakroter" value="Mittelakroter">Mittelakroter</td>
					<td><input type="checkbox" name="MSWasserspeier" value="Wasserspeier">Wasserspeier</td>
				</tr>
				
				<tr>
					<td><input type="checkbox" name="MSStroter" value="Stroter">Stroter</td>
					<td></td>
					<td><input type="checkbox" name="MSEckakroter" value="Eckakroter">Eckakroter</td>
					<td><input type="checkbox" name="MSL&ouml;wenkopfwasserspeier" value="L&ouml;wenkopfwasserspeier">L&ouml;wenkopfwasserspeier</td>
				</tr>
				</table>  
				<hr>
					<input type="checkbox" name="MSHeizung" value="Heizung"><b>Heizung</b><br>
				
						<ul><input type="checkbox" name="MSHypokaust" value="Hypokaust, Hypocaustum">Hypocaustum<br></ul>
				
				<p>
					<b>weitere Bezeichnungen:</b><br>
					<textarea name="MSBaugliederText" rows="2" cols="40">Architektur, </textarea>
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
						<td><input type="button" value="eingeben" onclick="saveSelection('obj_arch_structelems');history.back();"></td>
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
END ac_edit_obj_arch_structelems.tpl
================================================= -->
