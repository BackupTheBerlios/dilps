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
<!-- --------------------------------------------
BEGIN edit_element_loc.tpl
--------------------------------------------- -->
<html xmlns="http://www.w3.org/1999/xhtml" style="width: 100%; height: 100%;">
{if $config.utf8 eq "true"}
	{config_load file="`$config.skinBase``$config.skin`/`$config.language`/edit_thesaurus.conf.utf8"}
{else}
	{config_load file="`$config.skinBase``$config.skin`/`$config.language`/edit_thesaurus.conf"}
{/if}

<head>
	<meta name="robots" content="index,follow" />
	<meta http-equiv="pragma" content="no-cache" />
	<meta http-equiv="expires" content="0" />
	<meta http-equiv="cache-control" content="no-cache" />
	<meta name="keywords" content="Bilddatenbanksystem, Bilddatenbank, Diathek, digitalisiert" />
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
  <title>. : {#title#|escape:"htmlall"} : .  [[{$query.id}]]</title>
  <script src="dilps.lib.js" type="text/javascript"></script>
  <link rel="stylesheet" type="text/css" href="css.php">
<script language="javascript">
{literal}

function initialize(success, id)
{
    if (success) {
        reloadParent(id);
    }
}
function reloadParent(id)
{
	window.opener.document.forms["Main"].elements["view[detail][id]"].value="";
	window.opener.document.forms["Main"].elements["view[edit][id]"].value=id;
	window.opener.document.forms["Main"].submit();
}

{/literal}
</script>
</head>
<body class="headerstyle" onLoad="initialize({$success}, '{$query.id}');" style="padding:10px;">
<p style="text-align:center; font-size:24px; font-weight: bold;color: #cccccc; text-decoration: none;">{#changethesaurus#|escape:html}</p>

{if $error}
    <p style="text-align:center;background-color:#ff8e8e">{#error#|escape:html}: {$error|escape:html}</p>
{else}
    <p style="text-align:center;background-color:#cadeb2;">{#success#|escape:html}</p>
{/if}

<div style="margin-top:20px;text-align:center">
  <input type="button" name="closebutton" value="{#closewindow#|escape:html}" onClick="window.close();">
</div>
</body>
</html>
<!-- --------------------------------------------
END edit_element_loc.tpl
--------------------------------------------- -->