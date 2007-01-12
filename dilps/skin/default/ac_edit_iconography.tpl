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
BEGIN ac_edit_iconography.tpl
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

<script type="text/javascript">
{literal}

	function replaceNL(s) {
		// replace newlines and tabs with whitespaces
		r = "";
		
		for (i=0; i < s.length; i++) {
			if (s.charAt(i) != '\n' && s.charAt(i) != '\r' && s.charAt(i) != '\t') {
				r += s.charAt(i);
			}
			else {
				r += ' ';
			}
			
		}
		return r;
	}
	
	function restoreState(js_fieldnames, js_values)
	{
		for (var i=0; i < js_fieldnames.length; i++)
		{
			var element = document.forms["Main"].elements[js_fieldnames[i]];
			if (element != null && js_values[i] != '')
			{
				if (element.type == 'textarea')
				{
					element.value = js_values[i];
				}

				if (element.type == 'checkbox')
				{
					element.checked = true;
				}
			}
		}
	}
	

	function saveSelection(elementName)
	{
		var elements = document.forms["Main"].elements;
		
		var elnum = elements.length;
		
		// alert(elnum);
		
		var sel_names = new Array();
		var sel_values = new Array();
		
		for (var i=0; i < elnum; i++)
		{
			var name, type, value, checked;
			
			name = elements[i].name;
			type = elements[i].type;
			value = elements[i].value;
			checked = elements[i].checked;
			
			if ((type == 'textarea' && value != '') || (type == 'checkbox' && checked))
			{
				name_cleaned = replaceNL(name);
				value_cleaned = replaceNL(value);
				
				sel_names.push(name_cleaned);
				sel_values.push(value_cleaned);
			}
		}
		
		// alert("Namen: "+sel_names.length+", Werte: "+sel_values.length);
		
		var sel_names_string = sel_names.join('; ');
		var sel_values_string = sel_values.join('; ');
		
		/*
		for (i=0; i < sel_names.length; i++)
		{
			sel_names_string += sel_names[i]+"; ";
			sel_values_string += sel_values[i]+"; ";
		}
		*/
		
		var fn_index = "edit["+elementName+"_fn]";
   		var val_index = "edit["+elementName+"]";
		
		opener.document.forms["Main"].elements[fn_index].value = sel_names_string;
		opener.document.forms["Main"].elements[val_index].value = sel_values_string;
		
		// alert("sel_names_string: "+sel_names_string);
		// alert("sel_values_string: "+sel_values_string);
		
	}
	
{/literal}
</script>

</head>

<body class="headerstyle" style="width: 100%; height: 100%; vertical-align: top;">
	<form name="Main" action="{$SCRIPT_NAME}" method="POST" enctype="multipart/form-data">
	<input type="hidden" name="PHPSESSID" value="{$sessionid}">

	{if $query.id ne ""}
	
	{archaeology_element element="iconography" fieldnames="fieldnames" values="values" sql="sql" query=$query}
	
	<!-- {$sql} -->
	
	<script language="javascript">
		var rs_fn 	= "{$fieldnames}";
		var rs_val 	= "{$values}";
		
		js_fn 	= rs_fn.split('; ');
		js_val	= rs_val.split('; ');
	</script>

	<table class="header" style="width: 90%; margin: auto;"/>
		<tr>
			<td class="heading">Ikonographie</td>
		</tr>
		<tr>
			<td style="height: 10px;">
				&nbsp;
			</td>
		</tr>
		<tr>
			<td>
				<i>M&ouml;glichst viele <u>sinnvolle</u> Eintr&auml;ge vornehmen!</i><br>
				<i>Bitte die vorgeschlagenen Kategorien verwenden, aber auch immer &uuml;ber n&ouml;tige Erweiterungen nachdenken!</i>
			</td>
		</tr>
		<tr>
			<td style="height: 20px;">
				&nbsp;
			</td>
		</tr>
		<tr>
			<td>
				
				<p>
					<b>Thema:</b><br>
				
					<textarea name="MSIkonographieThemaText" rows="1" cols="40"></textarea>
				
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSMythos" value="Mythos, mythisch, Mythologie, mythologisch">Mythos</td>
					<td><input type="checkbox" name="MShistorische Darstellung" value="historische Darstellung">historische Darstellung</td>
					<td><input type="checkbox" name="MSAlltag" value="Alltag, Alltagsleben">Alltag</td>
				</tr>
				</table>  
				
				<hr>
				
					<b>Benennungen:</b><br>
					<textarea name="MSIkonographieBenennungText" rows="1" cols="40"></textarea>
				
				<p>
					<u>Mensch</u>
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSKind1" value="Mensch, Kind">Kind</td>
				
					<td><input type="checkbox" name="MSFrau" value="Mensch, Frau">Frau</td>
					<td><input type="checkbox" name="MSMann" value="Mensch, Mann">Mann</td>
				</tr>
				</table>
					<u>Mythische Gestalt</u><input type="checkbox" name="MSMythischeFigur" value="Mythische Figur, mythische Gestalt">
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSHeroine" value="Heroine, Halbg&ouml;ttin">Heroine</td>
					<td><input type="checkbox" name="MSHeros" value="Heros, Halbgott">Heros</td>
				
				</tr>
				</table>
					<u>Gottheit</u>
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSG&ouml;ttin" value="G&ouml;ttin, Gottheit">G&ouml;ttin
					<td><input type="checkbox" name="MSGott" value="Gott, Gottheit">Gott</td>
				</tr></td>
				</table>
				
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
				
					<td><input type="checkbox" name="MSPersonifikation" value="Personifikation">Personifikation</td>
					<td><input type="checkbox" name="MSMischwesen" value="Mischwesen">Mischwesen</td>
					<td><input type="checkbox" name="MSTier" value="Tier, Tiere">Tier</td>
					<td><input type="checkbox" name="MSPflanze" value="Pflanze, Pflanzen">Pflanze</td>
					<td><input type="checkbox" name="MSGegenstand" value="Gegenstand, Gegenst&auml;nde, Objekt">Gegenstand, Objekt</td>
				</tr>
				</table>  
				
				<hr>
				
				<b>Geschlecht und Altersstufe</b>
				
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSweiblich" value="weiblich">weiblich</td>
					<td><input type="checkbox" name="MSm&auml;nnlich" value="m&auml;nnlich">m&auml;nnlich</td>
					<td><input type="checkbox" name="MSZwitter" value="Zwitter, zweigeschlechtlich">Zwitter</td>
				
					<td><input type="checkbox" name="MSGeschlechtunklar" value="Geschlecht unklar, unklares Geschlecht">unklar</td>
				</tr>
				<tr>
					<td><input type="checkbox" name="MSKind2" value="M&auml;dchen, Kind, kindlich">M&auml;dchen</td>
					<td><input type="checkbox" name="MSKind3" value="Junge, Kind, kindlich">Junge</td>
				</tr>
				<tr>
					<td><input type="checkbox" name="MSJugendliche" value="jugendlich, Jugendliche">Jugendliche</td>
				
					<td><input type="checkbox" name="MSJugendlicher" value="jugendlich, Jugendlicher">Jugendlicher</td>
				</tr>
				<tr>
					<td><input type="checkbox" name="MSErwachsene" value="erwachsen, Erwachsene, Frau">Erwachsene</td>
					<td><input type="checkbox" name="MSErwachsener" value="erwachsen, Erwachsener, Mann">Erwachsener</td>
				</tr>
				<tr>
					<td><input type="checkbox" name="MSAlte" value="alt, Alte, Greisin">Alte</td>
					<td><input type="checkbox" name="MSAlter" value="alt, Alter, Greis">Alter</td>
				
				</tr>
				</table>
				<hr>
					<b>Darstellungsweise:</b><br>
					<textarea name="MSIkonographieDarstellungsweiseText" rows="1" cols="40"></textarea>
				
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSideal" value="ideal">ideal</td>
					<td><input type="checkbox" name="MSarchaisierend" value="archaisierend, archaistisch">archaisierend/archaistisch</td>
				
				</tr>
				<tr>
					<td><input type="checkbox" name="MSrealistisch" value="realistisch">realistisch</td>
					<td><input type="checkbox" name="MSklassizistisch" value="klassizistisch">klassizistisch</td>
				</tr>
				<tr>
					<td><input type="checkbox" name="MSKarikatur" value="Karikatur, karikaturhaft, karikierend">Karikatur</td>
				</tr>
				</table> 
				<hr>
					<b>K&ouml;rperhaltung/T&auml;tigkeit:</b><br>
				
					<textarea name="MSIkonographieK&ouml;rperhaltungText" rows="1" cols="40"></textarea>
				
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSstehend" value="stehend">stehend</td>
					<td><input type="checkbox" name="MSgehend" value="gehend">gehend</td>
					<td><input type="checkbox" name="MSliegend" value="liegend">liegend</td>
					<td><input type="checkbox" name="MSkniend" value="kniend">kniend</td>
				
					<td><input type="checkbox" name="MSreitend" value="reitend">reitend</td>
				</tr>
				<tr>
					<td><input type="checkbox" name="MSsitzend" value="sitzend">sitzend</td>
					<td><input type="checkbox" name="MSlaufend" value="laufend">laufend</td>
					<td><input type="checkbox" name="MSst&uuml;rzend" value="st&uuml;rzend">st&uuml;rzend</td>
					<td><input type="checkbox" name="MSkauernd" value="kauernd">kauernd</td>
				
					<td><input type="checkbox" name="MStanzend" value="tanzend">tanzend</td>
				</tr>
				</table>  
				<hr>
				
					<b>Dargestellte Gegenst&auml;nde oder Attribute:</b><br>
					<textarea name="MSIkonographieAttributText" rows="1" cols="40"></textarea>
				
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
				
					<td><input type="checkbox" name="MSKerykeion" value="Kerykeion, Heroldsstab">Kerykeion</td>
					<td><input type="checkbox" name="MSF&uuml;llhorn" value="F&uuml;llhorn">F&uuml;llhorn</td>
					<td><input type="checkbox" name="MSBinde" value="Binde">Binde</td>
					<td><input type="checkbox" name="MSBuchrolle" value="Buchrolle">Buchrolle</td>
				</tr>
				</table>  
				
				<u>Bewaffnung:</u>
				
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSPanzer" value="Panzer, gepanzert">Panzer</td>
					<td><input type="checkbox" name="MSHelm" value="Helm">Helm</td>
					<td><input type="checkbox" name="MSSchild" value="Schild">Schild</td>
					<td><input type="checkbox" name="MSLanze" value="Lanze">Lanze</td>
					<td><input type="checkbox" name="MSSpeer" value="Speer">Speer</td>
				
					<td><input type="checkbox" name="MSSchwert" value="Schwert">Schwert</td>
				</tr>
				</table>  
				<hr>
					<b>Kleidung, Schuhwerk, Haar- und Barttracht:</b><br>
					<textarea name="MSIkonographieKleidungText" rows="1" cols="40"></textarea>
				
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSnackt" value="nackt, unbekleidet">nackt</td>
				
					<td><input type="checkbox" name="MSentbl&ouml;&szlig;t" value="entbl&ouml;&szlig;t">entbl&ouml;&szlig;t</td>
					<td><input type="checkbox" name="MSmitnacktemOberk&ouml;rper" value="mit nacktem Oberk&ouml;rper">mit nacktem Oberk&ouml;rper</td>
					<td><input type="checkbox" name="MSbekleidet" value="bekleidet">bekleidet</td>
				</tr>
				</table>  
				
				<b>Kleidung:</b><br>
				
				<u>allgemein:</u>
				
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSObergewand" value="Obergewand">Obergewand</td>
					<td><input type="checkbox" name="MSUntergewand" value="Untergewand">Untergewand</td>
					<td><input type="checkbox" name="MSHose" value="Hose, Hosen">Hose</td>
					<td><input type="checkbox" name="MSMantel" value="Mantel">Mantel</td>
					<td><input type="checkbox" name="MSSchultermantel" value="Schultermantel">Schultermantel</td>
				
				</tr>
				</table>  
				
				<u>griechisch:</u>
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSChiton" value="Chiton">Chiton</td>
					<td><input type="checkbox" name="MSChlamys" value="Chlamys">Chlamys</td>
					<td><input type="checkbox" name="MSHimation" value="Himation">Himation</td>
					<td><input type="checkbox" name="MSPeplos" value="Peplos">Peplos</td>
				
					<td><input type="checkbox" name="MSSchr&auml;gmantel" value="Schr&auml;gmantel">Schr&auml;gmantel</td>
				</tr>
				</table>  
				
				<u>r&ouml;misch:</u>
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSToga" value="Toga">Toga</td>
					<td><input type="checkbox" name="MSTunica" value="Tunica">Tunica</td>
				
					<td><input type="checkbox" name="MSPaludamentum" value="Paludamentum">Paludamentum</td>
					<td><input type="checkbox" name="MSStola" value="Stola">Stola</td>
				</tr>
				</table>  
				
				<u>Besonderheiten:</u>
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MS&Auml;gis" value="&Auml;gis, Aigis">&Auml;gis</td>
					<td><input type="checkbox" name="MSTierfell" value="Tierfell, Fell">Tierfell</td>
				
				</tr>
				</table>  
				
				<b>Schuhwerk:</b><br>
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSbarfu&szlig;" value="barfu&szlig;, barf&uuml;&szlig;ig">barfu&szlig;</td>
					<td><input type="checkbox" name="MSSandale" value="Sandale">Sandale</td>
					<td><input type="checkbox" name="MSStiefel" value="Stiefel">Stiefel</td>
					<td><input type="checkbox" name="MSCalceus" value="Calceus">Calceus</td>
				
					<td><input type="checkbox" name="MSKothurn" value="Kothurn">Kothurn</td>
					<td><input type="checkbox" name="MSFl&uuml;gelschuh" value="Fl&uuml;gelschuh, Fl&uuml;gelschuhe">Fl&uuml;gelschuh</td>
				</tr>
				</table>  
				
				<b>Kopfbedeckung, Haar- und Barttracht:</b><br>
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSBinde" value="Binde">Binde</td>
					<td><input type="checkbox" name="MSKranz" value="Kranz, bekr&auml;nzt">Kranz</td>
				
					<td><input type="checkbox" name="MSDiadem" value="Diadem">Diadem</td>
					<td><input type="checkbox" name="MSMauerkrone" value="Mauerkrone">Mauerkrone</td>
					<td><input type="checkbox" name="MSPolos" value="Polos">Polos</td>
					<td><input type="checkbox" name="MSSchleier" value="Schleier">Schleier</td>
					<td><input type="checkbox" name="MSM&uuml;tze" value="M&uuml;tze">M&uuml;tze</td>
					<td><input type="checkbox" name="MSBaschlik" value="Baschlik">Baschlik</td>
				
				</tr>
				</table> 
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSGlatze" value="kahlk&ouml;pfig, Glatze, glatzk&ouml;pfig">kahlk&ouml;pfig</td>
					<td><input type="checkbox" name="MSMelonenfrisur" value="Melonenfrisur">Melonenfrisur</td>
				</tr>
				<tr>
					<td><input type="checkbox" name="MSkurzhaarig" value="Kurzhaarfrisur, kurzhaarig">kurzhaarig</td>
					<td><input type="checkbox" name="MSLockenper&uuml;cke" value="Lockenper&uuml;cke">Lockenper&uuml;cke</td>
				
				</tr>
				<tr>
					<td><input type="checkbox" name="MSlanghaarig" value="langhaarig, langes Haar">langhaarig</td>
				</tr>
				</table>  
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="MSbartlos" value="bartlos, unb&auml;rtig">bartlos</td>
					<td><input type="checkbox" name="MSb&auml;rtig" value="b&auml;rtig, Bart">b&auml;rtig</td>
					<td><input type="checkbox" name="MSVollbart" value="Vollbart, vollb&auml;rtig">Vollbart</td>
				
					<td><input type="checkbox" name="MSBackenbart" value="Backenbart">Backenbart</td>
				</tr>
				</table>  
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
						<td><input type="button" value="eingeben" onclick="javascript:saveSelection('iconography');window.close();"></td>
						<td><input type="button" value="zur&uuml;cksetzen" onclick="javascript:restoreState(js_fn, js_val);"></td>
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
END ac_edit_iconography.tpl
================================================= -->
