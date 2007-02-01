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
BEGIN ac_edit_obj.tpl
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
<script type="text/javascript">
  	self.name = 'objwindow';
  	// alert(window.name);
  </script>
</head>

<body class="headerstyle" style="width: 100%; height: 100%; vertical-align: top;">
	{if $query.id ne ""}
		<table class="header" style="width: 90%; margin: auto;"/>
			<tr>
				<td class="heading">{#object#}</td>
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
						<td><a href="{$SCRIPT_NAME}?PHPSESSID={$sessionid}&query[id]={$query.id}&query[element]=obj_culture">Kulturkreis</a></td>
						<td>allgemeine Angaben: "griechisch", "apulisch", etc.</td>
					</tr>
					<tr>
						<td><a href="{$SCRIPT_NAME}?PHPSESSID={$sessionid}&query[id]={$query.id}&query[element]=obj_culthistory">Allgemeine Kulturgeschichte</a></td>
						<td>privates und &ouml;ffentliches Leben, Religion, Kleidung, Berufe, Verkehr, Milit&auml;rwesen	</td>
					
					</tr>
					<tr>
						<td><a href="{$SCRIPT_NAME}?PHPSESSID={$sessionid}&query[id]={$query.id}&query[element]=obj_topography">Topographie/Urbanistik</a></td>
						<td>Gel&auml;ndeangaben und &uuml;bergeordnete Begriffe</td>
					</tr>
					<tr>
						<td><a href="{$SCRIPT_NAME}?PHPSESSID={$sessionid}&query[id]={$query.id}&query[element]=obj_arch">Architektur</a></td>
						<td>Bauordnungen, Bauglieder, Zivilarchitektur, Sakralarchitektur, Grabarchitektur, Milit&auml;rarchitektur</td>
					
					</tr>
					<tr>
						<td><a href="{$SCRIPT_NAME}?PHPSESSID={$sessionid}&query[id]={$query.id}&query[element]=obj_mosaic">Mosaik</a></td>
						<td>technische Aspekte</td>
					</tr>
					<tr>
						<td><a href="{$SCRIPT_NAME}?PHPSESSID={$sessionid}&query[id]={$query.id}&query[element]=obj_painting">Malerei</a></td>
						<td>technische Aspekte</td>
					</tr>
					
					<tr>
						<td><a href="{$SCRIPT_NAME}?PHPSESSID={$sessionid}&query[id]={$query.id}&query[element]=obj_sculpture">Plastik</a></td>
						<td>Rundplastik, Relief, Sarkophage, Bauplastik, Formatangaben, Polychromie</td>
					</tr>
					<tr>
						<td><a href="{$SCRIPT_NAME}?PHPSESSID={$sessionid}&query[id]={$query.id}&query[element]=obj_portrait">Portrait</a></td>
						<td>Benennung, Form</td>
					</tr>
					<tr>
					
						<td><a href="{$SCRIPT_NAME}?PHPSESSID={$sessionid}&query[id]={$query.id}&query[element]=obj_ceramic">Keramik</a></td>
						<td>Gef&auml;&szlig;formen, geographische, stilistische und zeitliche Gruppen</td>
					</tr>
					<tr>
						<td><a href="{$SCRIPT_NAME}?PHPSESSID={$sessionid}&query[id]={$query.id}&query[element]=obj_toreutics">Toreutik</a></td>
						<td>Ger&auml;te und Gef&auml;&szlig;e aus Metall</td>
					
					</tr>
					<tr>
						<td><a href="{$SCRIPT_NAME}?PHPSESSID={$sessionid}&query[id]={$query.id}&query[element]=obj_jewellery">Schmuck</a></td>
						<td>Gewandschmuck und K&ouml;rperschmuck</td>
					</tr>
					<tr>
						<td><a href="{$SCRIPT_NAME}?PHPSESSID={$sessionid}&query[id]={$query.id}&query[element]=obj_glass">Glas</a></td>
						<td>Technik, Dekor und Form</td>
					
					</tr>
					<tr>
						<td><a href="{$SCRIPT_NAME}?PHPSESSID={$sessionid}&query[id]={$query.id}&query[element]=obj_glyptics">Glyptik</a></td>
						<td>Gattungen und Formen</td>
					</tr>
					<tr>
						<td><a href="{$SCRIPT_NAME}?PHPSESSID={$sessionid}&query[id]={$query.id}&query[element]=obj_numismatics">Numismatik</a></td>
						<td></td>
					</tr>
					<tr>
						<td><a href="{$SCRIPT_NAME}?PHPSESSID={$sessionid}&query[id]={$query.id}&query[element]=obj_textiles">Textilien</a></td>
						<td></td>
					</tr>
					<tr>
						<td><a href="{$SCRIPT_NAME}?PHPSESSID={$sessionid}&query[id]={$query.id}&query[element]=obj_misc">andere Objekte</a></td>
						<td></td>
					</tr>
					<tr>
						<td><a href="{$SCRIPT_NAME}?PHPSESSID={$sessionid}&query[id]={$query.id}&query[element]=obj_epigraphy">Epigraphik</a></td>
						<td>Inschriften und Beschriftungen</td>
					</tr>
					<tr>
						<td><a href="{$SCRIPT_NAME}?PHPSESSID={$sessionid}&query[id]={$query.id}&query[element]=obj_methods">Methoden der Arch&auml;ologie</a></td>
						<td>Prospektionsmethoden, Ausgrabung, Fundanalyse und Museum</td>
					</tr>
					<tr>
						<td><a href="{$SCRIPT_NAME}?PHPSESSID={$sessionid}&query[id]={$query.id}&query[element]=obj_reception">Rezeption</a></td>
						<td></td>
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
					<input type="button" value="schlie&szlig;en" onclick="window.close();">
				</td>
			</tr>
		</table>
	{/if}

</body>
</html>

<!-- =================================================
END ac_edit_obj.tpl
================================================= -->
