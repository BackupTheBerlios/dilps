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
BEGIN edit_element_name.tpl
--------------------------------------------- -->
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
  <title>. : {#title#|escape:"htmlall"} : .  [[{$query.id}]]</title>
  <script src="dilps.lib.js" type="text/javascript"></script>
  <link rel="stylesheet" type="text/css" href="css.php">

<script language="javascript">
{literal}

function setNameInParent()
{
    setNameIds();

    window.opener.document.forms["Main"].elements["edit[name1text]"].value = document.Main.elements["query[name1text]"].value;
    window.opener.document.forms["Main"].elements["edit[name2text]"].value = document.Main.elements["query[name2text]"].value;

    window.opener.document.forms["Main"].elements["edit[name1id]"].value = document.Main.elements["query[name1id]"].value;
    window.opener.document.forms["Main"].elements["edit[name2id]"].value = document.Main.elements["query[name2id]"].value;

    close();
}

function setNameIds()
{
    name1id = document.Main.elements["query[name1id]"].value;
    name2id = document.Main.elements["query[name2id]"].value;
    name1text = document.Main.elements["query[name1text]"].value;
    name2text = document.Main.elements["query[name2text]"].value;

    if (changed[0]) {
        if (names[name1id] != name1text) {
            if (names[name1id] == "") {
                value = "0";
            } else {
                value = "new";
            }
            document.Main.elements["query[name1id]"].value = value;
        }
    }
    if (changed[1]) {
        if (names[name2id] != name2text) {
            if (names[name2id] == "") {
                value = "0";
            } else {
                value = "new";
            }
            document.Main.elements["query[name2id]"].value = value;
        }
    }
}

function setFocus()
{
	document.Main.elements["query[artist]"].focus();
}

function nameSelected() {
    document.Main.elements["query[action]"].value = "searchaltnames";
    setNameIds();
    document.Main.submit();
}

function setName(prefix) {
    if (document.Main.elements["query[artist]"].value != '') {
        artistid = document.Main.elements["query[artist]"].value;
        querynametext = "query[" + prefix + "text]";
        querynameid = "query[" + prefix + "id]";
        document.Main.elements[querynametext].value = names[artistid];
        document.Main.elements[querynameid].value = artistid;
    }
}

function searchName(prefix) {
    if (document.Main.elements["query[searchartist]"].value != '') {
        document.Main.elements["query[artist]"].value = '';
        setNameIds();
        document.Main.submit();
    }
}

names = new Array();
oldValues = new Array();
changed = [false, false];
{/literal}
oldValues[0] = "{$query.name1text}";
oldValues[1] = "{$query.name2text}";
{literal}

function memoriseValue(element,position)
{
	var docelem = document.Main.elements[element];
	
	if (docelem != null) {
		// alert('gefunden - '+docelem.value+'!');
		oldValues[position] = docelem.value;
	}
}

function compareValue(element,position)
{
	var docelem = document.Main.elements[element];
	
	if (docelem != null) 
	{
		if (oldValues[position] != docelem.value) {
			// alert('gefunden - alt: '+oldValues[position]+', neu:'+docelem.value+'!');
			return true;
		}
		else {
			return false;
		}
	}
}

{/literal}

</script>
</head>
<body class="main" onLoad="setFocus();">
<form name="Main" action="{$SCRIPT_NAME}" method="POST">
<input type="hidden" name="PHPSESSID" value="{$sessionid}">
<input type="hidden" name="query[action]" value="searchartist">
<input type="hidden" name="query[id]" value="{$query.id|escape:html}">
<input type="hidden" name="query[element]" value="{$query.element|escape:html}">

{if $query.id ne ""}
{artist_list var="result" sql="sql" query=$query}
<!-- {$sql} -->

<script language="javascript">
{if $result ne ""}
	{foreach from=$result item=row}
	names["{$row.id}"] = "{$row.name}";
	{/foreach}
{else}
	names[0] = "";
{/if}
</script>

<table border="0">
<tr>
   <td style="vertical-align: bottom;">
		<b>{#artistname#|escape:htmlall}</b><br>
		<input type="text" name="query[searchartist]" value="{$query.searchartist|escape:html}" tabindex="1" style="width: 400px;">
		<button type="button" class="actionbutton" name="search" title="{#search#|escape:html}" onclick="searchName();" tabindex="2">{#search#|escape:html}</button>
	</td>
	<td>
	   <img src="blank.gif" width="10" height="1">
	</td>
</tr>
</table>

<table border="0">
<tr>
	<td style="vertical-align: bottom;">
		<b>{#name#|escape:htmlall}</b><br>
		<select name="query[artist]" size="20" onChange="nameSelected();" tabindex="3" style="width: 400px;">
			<option value=""{if $query.artist eq ""} selected{/if}>---------------------------------------------------------------------------</option>

			{foreach from=$result item=row}
			{if $row.name ne ""}
			<option value="{$row.id}"{if $query.artist eq $row.id} selected{/if}>{$row.name|escape:htmlall}</option>
			{/if}
			{/foreach}
		</select>
	</td>
</tr>
<tr>
	<td>
		&nbsp;
	</td>
</tr>
<tr>
	<td style="vertical-align: bottom;">
	   {if $query.artist ne ""}
	   {artist_altnames_list var="result" sql="sql" query=$query }
	   {if $result != false}
 	    <p>
		<b>{#aka#|escape:htmlall}:</b><br />
        <table class="result_list_data" width="100%">
        {foreach from=$result item="row"}
        <tr>
           <td class="result_list_data_data">{if $row.name != ''}{$row.name|escape:htmlall}{/if}</td>
        </tr>
        {/foreach}
        </table>
	    </p>
	   {/if}
	   {/if}
	</td>
</tr>
<tr>
	<td>
		&nbsp;
	</td>
</tr>
<tr>
	<td>
		<input type="text" name="query[name1text]" value="{$query.name1text|escape:htmlall}" onfocus="memoriseValue('query[name1text]',0);" onblur="changed[0] = compareValue('query[name1text]',0);" onchange="changed[0] = true;" size="50" tabindex="5" style="width: 400px;">
		<input type="hidden" name="query[name1id]" value="{$query.name1id|escape:htmlall}">
		<button type="button" class="actionbutton" onclick="setName('name1')" title="{#name#|escape:htmlall} {#set#|escape:htmlall}" tabindex="4">{#name#|escape:htmlall} {#set#|escape:htmlall}</button>
		
		<input type="text" name="query[name2text]" value="{$query.name2text|escape:htmlall}" onfocus="memoriseValue('query[name2text]',0);" onblur="changed[1] = compareValue('query[name2text]',1);" onchange="changed[1] = true;" size="50" tabindex="5" style="width: 400px;">
		<input type="hidden" name="query[name2id]" value="{$query.name2id|escape:htmlall}">
		<button type="button" class="actionbutton" onclick="setName('name2')" title="{#name2#|escape:htmlall} {#set#|escape:htmlall}" tabindex="6">{#name2#|escape:htmlall} {#set#|escape:htmlall}</button>
	</td>
</tr>
<tr>
	<td>
		&nbsp;
	</td>
</tr>
<tr>
	<td>
	    <input type="button" class="button" name="setit" value="{#acceptit#|escape:html}" onClick="setNameInParent();" tabindex="8">
	    <input type="button" class="button" name="cancel" value="{#cancel#|escape:html}" onClick="window.close(); " tabindex="9">
	</td>
</tr>
<!--<tr>
	<td colspan="2">
	   <img src="blank.gif" width="1" height="3">
	</td>
</tr>-->
</table>



{/if}
</form>
</body>
</html>
<!-- --------------------------------------------
END edit_element_name.tpl
--------------------------------------------- -->
