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
BEGIN ac_edit_obj_arch.tpl
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
<script type="text/javascript">
  	self.name = 'objwindow';
  	// alert(window.name);
  </script>
</head>

<body class="headerstyle" style="width: 100%; height: 100%; vertical-align: top;">
	{if $query.id ne ""}
		<table class="header" style="width: 90%; margin: auto;"/>
			<tr>
				<td class="heading">{#architecture#}</td>
			</tr>
			<tr>
				<td style="height: 20px;">
					&nbsp;
				</td>
			</tr>
			<tr>
				<td>
						<a href="{$SCRIPT_NAME}?PHPSESSID={$sessionid}&query[id]={$query.id}&query[element]=obj_arch_structelems">Bauordnung / Bauglieder</a> (Fundament, Mauer, Dach)<p>
					<hr>
					
						<u>Zivilarchitektur</u><br>
					
					<ul>	<a href="{$SCRIPT_NAME}?PHPSESSID={$sessionid}&query[id]={$query.id}&query[element]=obj_arch_tenement">Wohnhaus</a> (Haus, Villa, Palast)<p>
						<a href="{$SCRIPT_NAME}?PHPSESSID={$sessionid}&query[id]={$query.id}&query[element]=obj_arch_funcbuild">Politische Funktionsbauten</a> (Versammlungen, Gerichte, Hallen)
						<p>
						<a href="{$SCRIPT_NAME}?PHPSESSID={$sessionid}&query[id]={$query.id}&query[element]=obj_arch_amusement">Sport und Unterhaltung</a> (Gymnasion, Zirkus, Theater) / Thermen</a>
						<p>
					
						<a href="{$SCRIPT_NAME}?PHPSESSID={$sessionid}&query[id]={$query.id}&query[element]=obj_arch_economy">Wirtschaft, Transport und Verkehr (M&auml;rkte, Stra&szlig;en, H&auml;fen) / <br />
							Versorgung und Entsorgung (Wasserleitungen und Kan&auml;le)</a>
						<p>
					</ul>
					
						<a href="{$SCRIPT_NAME}?PHPSESSID={$sessionid}&query[id]={$query.id}&query[element]=obj_arch_sacral">Sakralarchitektur</a> (Heiligt&uuml;mer, Tempel, Kirchen, Synagogen)<p>
						<a href="{$SCRIPT_NAME}?PHPSESSID={$sessionid}&query[id]={$query.id}&query[element]=obj_arch_sepulchre">Ehrenmonumente (B&ouml;gen, S&auml;ulenmonumente) / <br />
							Grabarchitektur (Kammergr&auml;ber, Grabh&uuml;gel, Katakomben) </a>
						<p>
						<a href="{$SCRIPT_NAME}?PHPSESSID={$sessionid}&query[id]={$query.id}&query[element]=obj_arch_military">Wehrarchitektur/Milit&auml;rarchitektur</a> (Befestigungen, Milit&auml;rlager, Wacht&uuml;rme)<p>
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
					<input type="button" value="zur&uuml;ck" onclick="history.back();">
				</td>
			</tr>
		</table>
	{/if}

</body>
</html>

<!-- =================================================
END ac_edit_obj_arch.tpl
================================================= -->
