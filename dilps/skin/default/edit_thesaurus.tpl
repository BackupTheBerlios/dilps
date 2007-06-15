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
function setLocation()
{
   if( document.Main.city.value != "" ) {
	   window.opener.document.forms["Main"].elements["edit[city]"].value=document.Main.city.value;
	   window.opener.document.forms["Main"].elements["edit[locationid]"].value="new";
   } else {
	   window.opener.document.forms["Main"].elements["edit[city]"].value=locations[document.Main.elements["query[city]"].value];
	   window.opener.document.forms["Main"].elements["edit[locationid]"].value=document.Main.elements["query[city]"].value;
	}
	if( document.Main.institution.value != "" )
	   window.opener.document.forms["Main"].elements["edit[institution]"].value=document.Main.institution.value;
	else
	   window.opener.document.forms["Main"].elements["edit[institution]"].value=document.Main.elements["query[institution]"].value;
	close();
}

function setFocus()
{
    if (document.Main && document.Main.elements["query[newvalue]"]) {
        document.Main.elements["query[newvalue]"].focus();    
    }
}

function deleteThesaurusEntry()
{
    document.Main.elements["query[editaction]"].value = 'delete';
    submitChange();    
}
function updateThesaurusEntry()
{
    document.Main.elements["query[editaction]"].value = 'update';
    submitChange();    
}
function submitChange() 
{
    document.forms["Main"].submit();
}
{/literal}
</script>
</head>
<body class="headerstyle" onLoad="setFocus();" style="padding:10px; text-align: center;">
<p style="text-align:center; font-size:24px; font-weight: bold;color: #cccccc; text-decoration: none;">{#changethesaurus#|escape:html}</p>

{if $error}
    <p style="text-align:center;background-color:#ff8e8e">{#error#|escape:html}: {$error|escape:html}</p>
    <div style="margin-top:20px;text-align:center">
        <input type="button" name="closebutton" value="{#closewindow#|escape:html}" onClick="window.close();">
    </div>
{else}
    <form name="Main" action="{$SCRIPT_NAME}" method="POST">
    <input type="hidden" name="PHPSESSID" value="{$sessionid}">
    <input type="hidden" name="query[id]" value="{$query.id|escape:html}">
    <input type="hidden" name="query[editaction]" value="none">
    <input type="hidden" name="query[elementid]" value="{$query.elementid|escape:html}">
    <input type="hidden" name="query[element]" value="{$query.element|escape:html}">
    <input type="hidden" name="query[elementindex]" value="{$query.elementindex|escape:html}">
    <p style="background-color:#fffab0; font-weight:bold; padding:10px;">
        {if $query.element == 'institution'}
            {#warningtextinstitution#|escape:html}
        {else}        
            {#warningtext#|escape:html}
        {/if}
    </p>

    {if $query.element == 'name'}
        <table>
            <thead>
            <th>{#name#|escape:html}</th>
            </thead>
            <tr>
                <td class="result_detail_data_data">
                    <table>
                    <tr>
                        <td class="result_detail_data_header">{#current#|escape:html}: </td>
                        <td class="result_detail_data_data" style="border: 0px;"><input class="inactive" type="text" name="current[value]" value="{$row.name}" size="30" readonly="readonly"></td>
                    </tr>
                    <tr>
                        <td class="result_detail_data_header">{#new#|escape:html}: </td>
                        <td class="result_detail_data_data" style="border: 0px;"><input type="text" name="query[newvalue]" value="{$row.name|escape:html}" size="30"></td>
                    </tr>
                    </table>
                </td>
                <td style="vertical-align=center;padding-left:10px">
                    <div class="result_detail_data_data"><input type="button" name="updatebutton" value="{#applybutton#|escape:html}" onClick="updateThesaurusEntry('{$row.id}');"></div>
                </td>
            </tr>
            <tr>
                <td style="height:15px"></td>
                <td></td>
            </tr>
            <tr>
                <td class="result_detail_data_data">
                    <table>
                    <tr>
                        <td class="result_detail_data_header">{#deletetext#|escape:html}</td>
                    </tr>
                    </table>
                </td>
                <td style="vertical-align=center;padding-left:10px"><input type="button" name="deletebutton" value="{#deletebutton#|escape:html}" onClick="deleteThesaurusEntry('{$row.id}');"></td>
            </tr>
            <tr>
                <td colspan="2" style="height:40px;padding-top:25px;text-align:center;vertical-align:bottom">
                    <input type="button" name="cancelbutton" value="{#cancelbutton#|escape:html}" onClick="window.close();">
                </td>
            </tr>
        </table>
    {elseif $query.element == 'location'}
        <table>
            <thead>
            <th>{#city#|escape:html}</th>
            </thead>
            <tr>
                <td class="result_detail_data_data">
                    <table>
                    <tr>
                        <td class="result_detail_data_header">{#current#|escape:html}: </td>
                        <td class="result_detail_data_data" style="border: 0px;">
                          <input class="inactive" type="text" name="current[value]" 
                            value="{$row.location}{if $row.hierarchy} ({$row.hierarchy}){/if}" size="30" readonly="readonly">
                        </td>
                    </tr>
                    <tr>
                        <td class="result_detail_data_header">{#new#|escape:html}: </td>
                        <td class="result_detail_data_data" style="border: 0px;">
                            <input type="text" name="query[newvalue]" value="{$row.location|escape:html}" size="30">
                            {if $options}
                                  <br/>{#details#|escape:html}:&nbsp;
                                  <select name="query[newvalueid]">
                                  {foreach from=$options.locations item=location}
    		         		            <option value="{$location.id}">{$location.hierarchy}</option>
    		         		      {/foreach}    		         		            
    		         		      </select>                            
                            {/if}
                        </td>
                    </tr>
                    </table>
                </td>
                <td style="vertical-align=center;padding-left:10px">
                    <div class="result_detail_data_data"><input type="button" name="updatebutton" value="{#applybutton#|escape:html}" onClick="updateThesaurusEntry('location','{$row.id}');"></div>
                </td>
            </tr>
            <tr>
                <td style="height:15px"></td>
                <td></td>
            </tr>
            <tr>
                <td class="result_detail_data_data">
                    <table>
                    <tr>
                        <td class="result_detail_data_header">{#deletetext#|escape:html}</td>
                    </tr>
                    </table>
                </td>
                <td style="vertical-align=center;padding-left:10px"><input type="button" name="deletebutton" value="{#deletebutton#|escape:html}" onClick="deleteThesaurusEntry('{$row.id}');"></td>
            </tr>
            <tr>
                <td colspan="2" style="height:40px;padding-top:25px;text-align:center;vertical-align:bottom">
                    <input type="button" name="cancelbutton" value="{#cancelbutton#|escape:html}" onClick="window.close();">
                </td>
            </tr>
        </table>
    {elseif $query.element == 'institution'}
        <table>
            <thead>
            <th>{#institution#|escape:html} ({$row.location})</th>
            </thead>
            <tr>
                <td class="result_detail_data_data">
                    <table>
                    <tr>
                        <td class="result_detail_data_header">{#current#|escape:html}: </td>
                        <td class="result_detail_data_data" style="border: 0px;"><input class="inactive" type="text" name="current[value]" value="{$row.institution}" size="30" readonly="readonly"></td>
                    </tr>
                    <tr>
                        <td class="result_detail_data_header">{#new#|escape:html}: </td>
                        <td class="result_detail_data_data" style="border: 0px;"><input type="text" name="query[newvalue]" value="{$row.institution|escape:html}" size="30"></td>
                    </tr>
                    </table>
                </td>
                <td style="vertical-align=center;padding-left:10px">
                    <div class="result_detail_data_data"><input type="button" name="updatebutton" value="{#applybutton#|escape:html}" onClick="updateThesaurusEntry('{$row.id}');"></div>
                </td>
            </tr>
            <tr>
                <td style="height:15px"></td>
                <td></td>
            </tr>
            <tr>
                <td class="result_detail_data_data">
                    <table>
                    <tr>
                        <td class="result_detail_data_header">{#deletetext#|escape:html}</td>
                    </tr>
                    </table>
                </td>
                <td style="vertical-align=center;padding-left:10px"><input type="button" name="deletebutton" value="{#deletebutton#|escape:html}" onClick="deleteThesaurusEntry('{$row.id}');"></td>
            </tr>
            <tr>
                <td colspan="2" style="height:40px;padding-top:25px;text-align:center;vertical-align:bottom">
                    <input type="button" name="cancelbutton" value="{#cancelbutton#|escape:html}" onClick="window.close();">
                </td>
            </tr>
        </table>
    {/if}
    
    </form>
{/if}
</body>
</html>
<!-- --------------------------------------------
END edit_element_loc.tpl
--------------------------------------------- -->