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


<!-- 	BEGIN group_edit.tpl	-->

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" style="width: 100%; height: 100%;">
{if $config.utf8 eq "true"}
	{config_load file="`$config.skinBase``$config.skin`/`$config.language`/edit_group.conf.utf8"}
{else}
	{config_load file="`$config.skinBase``$config.skin`/`$config.language`/edit_group.conf"}
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

	<meta http-equiv="Content-Script-Type" content="text/javascript" />
	<meta http-equiv="Content-Style-Type" content="text/css" />
	<meta name="author" content="juergen enge, thorsten wuebbena, sebastian doeweling">
	<meta name="date" content="2003-01-23" />
	<link rel="shortcut icon" href="favicon.ico" />
	<title>. : {#groupmanagement#|escape:"htmlall"} : .</title>

	<script src="dilps.lib.js" type="text/javascript"></script>
	<script type="text/javascript">
	  var warningmessage = "{#deletecontentispermanent#}";
	</script>
	<link rel="stylesheet" type="text/css" href="css.php" />

	<style type="text/css">
	{literal}
		td{
			vertical-align: top;
		}
	{/literal}
	</style>
</head>

<body class="headerstyle">

<form action="{$SCRIPT_NAME}" name="Main" method="post" style="padding: 0px; margin-top: 10px;">

	<input type="hidden" name="PHPSESSID" value="{$sessionid}" />

	<table class="header" style="padding-left: 10px;">
		<tr>
			<td colspan="3" class="heading" style="text-align: left;">
				<a class="navsymbol" href="{$SCRIPT_NAME}?PHPSESSID={$sessionid}">{#groupmanagement#}</a>
				<span style="font-size: 12pt;">
					&nbsp; ( <a class="navsymbol" href="javascript:window.close();">{#closewindow#}</a> )
				</span>
			</td>
		</tr>
		<tr>
			<td colspan="3" style="text-align: left;">
			   &nbsp;
			</td>
		</tr>
		<tr>
			<td colspan="3" style="text-align: left;">
			   <strong>{#select_action#}</strong>
			</td>
		</tr>
		<tr>
			<td colspan="3" class="queryinputfield">
			   {groupactions_list var=groupactions user=$user.login edit=$user.editgroups admin=$user.admin}
				
				 <select name="action" id="action" class="queryselectfield" 
           onChange="document.forms['Main'].submit();" style="width: 300px; text-align: center;">
          {foreach from=$groupactions item=groupaction}
            {assign var="printname" value=$groupaction.printname}
            <option value="{$groupaction.name}:{$groupaction.arguments}" {if $groupaction.name eq $action}selected="selected"{/if}>
                {$smarty.config.$printname}
            </option>
          {/foreach}
        </select>
			</td>
		</tr>
		<tr>
			<td colspan="3" style="text-align: left;">
			   {if $actioncommited gt 0}
			     <br />
  			   {group_manage action=$commitedaction sourceid=$source.groupid targetid=$target.groupid result=result sql=sql}
  			   <!-- {$sql} -->
  					
  					<!-- display localized information on action success -->
  					&nbsp;
  					{$smarty.config.$result}
  					<br />
					{else}
			       &nbsp;
	        {/if}
			</td>
		</tr>
		<tr>
			<td style="text-align: left; width: 300px; visibility: {if $arguments lt 1}hidden{else}visible{/if}">
				<table cellpadding="0" cellspacing="0" style="width: 100%;">
					<tr>
						<td class="field_name" style="padding: 2px;">
						   <strong>
						   {if $arguments lt 2}{#group#|escape:htmlall}{else}{#source#|escape:htmlall}{/if}
					     </strong>
					   </td>
					</tr>
					<tr>
						<td style="width: 260px; text-align: left;">
							{if $source.groupid neq ""}
								<input class="queryinputfield" type="text" name="source[group]" readonly="readonly" value="{$source.group|escape:html}" onclick="editGroupSelection('{$sessionid}','source','{$source.grouplastpath}','{$source.groupid}');" style="width: 250px;">
							{else}
								<input class="queryinputfield" type="text" name="source[group]" readonly="readonly" value=" ({#selecthere#|escape:htmlall}) " onclick="editGroupSelection('{$sessionid}','source','{$source.grouplastpath}','{$source.groupid}');" style="width: 250px;">
							{/if}
			
							<input class="queryinputfield" type="hidden" name="source[groupid]" value="{$source.groupid|escape:html}">
							<input class="queryinputfield" type="hidden" name="source[groupowner]" value="{$source.groupowner|escape:html}">
							<input class="queryinputfield" type="hidden" name="source[grouplastpath]" value="{$source.grouplastpath|escape:html}">
						</td>
						<td style="width: auto; text-align: left; vertical-align: middle;">
							{if $source.groupid}
								<button type="button" class="actionbutton2" onclick="clearsource();" title="{#nogroup#|escape:htmall}"><img src="clear.png" style="width: 12px; height: 12px;" /></button>			
							{else}
								&nbsp;
							{/if}
						</td>
					</tr>
				</table>
			</td>
			<td style="width: auto; text-align: center;">
			   &nbsp;
			</td>
			<td style="text-align: right; width: 300px; visibility: {if $arguments lt 2}hidden{else}visible{/if}">
				<table cellpadding="0" cellspacing="0" style="width: 100%;" />
					<tr>
						<td class="field_name" style="padding: 2px;"><strong>{#target#|escape:htmlall}</strong></td>
					</tr>
					<tr>
						<td style="width: 260px; text-align: right;">
							{if $target.groupid neq ""}
								<input class="queryinputfield" type="text" name="target[group]" readonly="readonly" value="{$target.group|escape:html}" onclick="editGroupSelection('{$sessionid}','target','{$target.grouplastpath}','{$target.groupid}');" style="width: 250px; text-align: right;">
							{else}
								<input class="queryinputfield" type="text" name="target[group]" readonly="readonly" value=" ({#selecthere#|escape:htmlall}) " onclick="editGroupSelection('{$sessionid}','target','{$target.grouplastpath}','{$target.groupid}');" style="width: 250px; text-align: right;">
							{/if}
			
							<input class="queryinputfield" type="hidden" name="target[groupid]" value="{$target.groupid|escape:html}">
							<input class="queryinputfield" type="hidden" name="target[groupowner]" value="{$target.groupowner|escape:html}">
							<input class="queryinputfield" type="hidden" name="target[grouplastpath]" value="{$target.grouplastpath|escape:html}">
							
						</td>
						<td style="width: auto; text-align: center; vertical-align: middle;">
							{if $target.groupid neq ""}
								<button type="button" class="actionbutton2" onclick="cleartarget();" title="{#nogroup#|escape:htmall}"><img src="clear.png" style="width: 12px; height: 12px;" /></button>
							{else}
								&nbsp;
							{/if}
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td colspan="3" style="text-align: left;">
			   &nbsp;
			</td>
		</tr>
		<tr>
			<td colspan="3" style="text-align: left;">
        {if $enougharguments gt 0}
          <input type="button" name="commitbutton" value="{#commitaction#|escape:html}" onClick="document.forms['Main'].elements['actioncommited'].value = 1; if ('{$action}' == 'deleteContent') doit = confirm(warningmessage); if (doit) document.forms['Main'].submit(); ">
          &nbsp;
          <input type="button" name="cancelbutton" value="{#closewindow#|escape:html}" onClick="opener.document.forms['Main'].submit();window.close();">
        {else}
          <input type="button" name="cancelbutton" value="{#closewindow#|escape:html}" onClick="opener.document.forms['Main'].submit();window.close();">
        {/if}
        <input type="hidden" name="actioncommited" value="0">
			</td>
		</tr>
		
	</table>
	
</form>

</body>
</html>

<!-- END group_edit.tpl -->

