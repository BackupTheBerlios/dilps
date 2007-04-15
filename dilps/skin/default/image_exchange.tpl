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
BEGIN image_exchange.tpl
================================================= -->
{if $config.utf8 eq "true"}
	{config_load file="`$config.skinBase``$config.skin`/`$config.language`/easy_query.conf.utf8"}
{else}
	{config_load file="`$config.skinBase``$config.skin`/`$config.language`/easy_query.conf"}
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
</head>
<body class="main" style="width: 100%; height: 100%;">
	<form name="Main" action="{$SCRIPT_NAME}" method="POST" enctype="multipart/form-data">
	<input type="hidden" name="PHPSESSID" value="{$sessionid}">

	<table class="header" style="width: 100%; height: 100%; vertical-align: top;">
	{if $query.process eq "" or $query.process lt "2"}
		<tr>
			<td class="queryinputfieldtext">
		  		{#sourcefile#}
			</td>
			<td class="queryinputfield">
				<input class="queryinputfield" type="file" name="query[sourcedirectory]" value="{$query.directory|escape:html}" size="40">
				<input type="hidden" name="query[completedir]" value="0">
			</td>
		</tr>
		<tr>
		   	<td class="queryinputfieldtext">
		    	{#targetdirectory#}
		   	</td>
		   	<td>
				<select class="queryselectfield" name="query[baseid]">
					<option value="{$baseid}">{if $host neq "local" and $host neq ""}{$host}{else}localhost{/if} :: {$base}</option>
				</select>
			</td>
		</tr>
		<tr>
			<td class="field_name">
				&nbsp;
			</td>
			<td>
				<input type="hidden" name="query[id]" value="{$collectionid}:{$imageid}">
				<input type="hidden" name="query[process]" value="2">
				<input type="submit" name="query[new]" value="{#exchangeimage#|escape:html}">
			</td>
		</tr>
	{/if}

	<tr>
		<td>
		&nbsp;
		</td>
	</tr>
	</table>
</form>
</body>
</html>
<!-- --------------------------------------------
END image_exchangetpl
--------------------------------------------- -->
