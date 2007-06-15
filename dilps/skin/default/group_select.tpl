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

<!-- 	BEGIN group_select.tpl	-->

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

	<title>. : {#groupselection#|escape:"htmlall"} : .</title>
	<script src="dilps.lib.js" type="text/javascript"></script>
	<link rel="stylesheet" type="text/css" href="css.php" />
	<style type="text/css">
	{include file="`$config.skin`/dilps.css"}
	</style>

	{if $target eq "group"}
		<script src="include/group/group.inc.js" type="text/javascript"></script>
	{elseif $target eq "mygroup"}
		<script src="include/group/mygroup.inc.js" type="text/javascript"></script>
	{elseif $target eq "source"}
		<script src="include/group/source.inc.js" type="text/javascript"></script>
	{elseif $target eq "target"}
		<script src="include/group/target.inc.js" type="text/javascript"></script>
	{else}
		<script src="include/group/img_group.inc.js" type="text/javascript"></script>
	{/if}

	<script type="text/javascript">
	{literal}
	
	function restoreHint(currentlevel, currentid)
	{
		var curElemSelect;
		var curElem;
		var curValue;
		var curValueParts;
		
		var nextElemID;
		var nextElemSelect;
		var nextElem;
		
		var hintElemLev2;
		var hintElemLev3;
		{/literal}
		
		hintElemLev2	= new Option('--{#level2#}--', '-1', false, true);
		hintElemLev3	= new Option('--{#level3#}--', '-1', false, true);
		
		{literal}
		
		curElemSelect = "gid-"+currentid+"-groups";
		curElem = document.forms[0].elements[curElemSelect];
		
		curValue 		= curElem.options[curElem.selectedIndex].value;
		curValueParts  	= extractData(curValue);
		nextElemID 		= curValueParts[0];
		
		if (nextElemID != null)
		{
			nextElemSelect = "gid-"+nextElemID+"-groups";
			nextElem = document.forms[0].elements[nextElemSelect];
			
			if (nextElem != null)
			{
				// check for hint element - if not present, (re-)insert it
				if (nextElem.options[nextElem.length - 1].value != -1)
				{
					if (currentlevel == '0')
					{
						nextElem.options[nextElem.length] = hintElemLev2;
					}
					else
					{
						nextElem.options[nextElem.length] = hintElemLev3;
					}
				}
				
				return true;
				
			}
		}
		
		return false;
	}
	
	function checkAndSubmit()
	{
		// check user input and trigger confirm dialog for delete and clear
		
		var target 			= document.forms[0].elements["target"].value;
		var action 			= document.forms[0].elements["action"].value;
		
		var currentid;
		if (document.forms[0].elements["currentid"] != null) {
			currentid = document.forms[0].elements["currentid"].value;
		}
		else {
			currentid = 0;
		}
		
		var currentname;
		if (document.forms[0].elements["currentname"] != null) {
			currentname = document.forms[0].elements["currentname"].value;
		}
		else {
			currentname = '';
		}
		
		var currentowner;
		if (document.forms[0].elements["currentowner"] != null) {
			currentowner = document.forms[0].elements["currentowner"].value;
		}
		else {
			currentowner = 'public';
		}
				
		var parameter;

		if (document.forms[0].elements["parameter"] != null) {
			parameter = document.forms[0].elements["parameter"].value;
		}
		else {
			parameter = '';
		}
		
		var currentlevel;
		if (document.forms[0].elements["currentlevel"] != null) {
			currentlevel = document.forms[0].elements["currentlevel"].value;
		}
		else {
			currentlevel = '';
		}
		
		var currentlastpath;

		if (document.forms[0].elements['lastpath'] != null) {
			currentlastpath = document.forms[0].elements['lastpath'].value;
		}
		else {
			currentlastpath = '';
		}
		
		
		
		// abort, if important values mysteriously disappeared
		if (action == '' || currentid == '') {
			return false;
		}
		
		if (action == 'selectandclose' || action == 'doselect')
		{
			switch (target) {
			  case "img_group_1":
				copy1(currentid, currentname, currentowner);
			    break;
			  case "img_group_2":
				copy2(currentid, currentname, currentowner);
			    break;
			  case "img_group_3":
				copy3(currentid, currentname, currentowner);
			    break;
			  default:
				copy(currentid, currentname, currentowner, currentlastpath);
			    break;
			}
			
			if (action == 'selectandclose')
			{
				window.close();
			}
			return true;
		}
		
		if (action == 'addsubgroup' || action == 'addgroup' || action == 'rename')
		{
			if (action == 'addgroup')
			{
				document.forms[0].elements["currentid"].value = 0;
				// pseudo-name, is not used
				document.forms[0].elements["currentname"].value = 'root';
			}
			
			if (parameter != '')
			{
				var search = /((\w.+)\s*\-*).+/;
				var testillegal = search.test(parameter);
				if (testillegal == false)
				{
					{/literal}
					var confirmstring = "{#invalidname#}";
					alert(confirmstring);
					{literal}
					return false;
				}
				else {
					
					switch (target) {
					  case "img_group_1":
						conditionalcopy1(currentid, parameter, currentowner);
					    break;
					  case "img_group_2":
						conditionalcopy2(currentid, parameter, currentowner);
					    break;
					  case "img_group_3":
						conditionalcopy3(currentid, parameter, currentowner);
					    break;
					  default:
						conditionalcopy(currentid, parameter, currentowner, currentlastpath);
					    break;
					}
					
					document.forms[0].submit();
					return true;
				}
			}
			else
			{
				{/literal}
				var confirmstring = "{#pleaseentergroupname#}";
				alert(confirmstring);
				{literal}
				return false;
			}
		}
		
		if (action == 'del' || action == 'clear')
		{
			if (action == 'del')
			{
				{/literal}
					var confirmstring = "{#deletegroup#}";
				{literal}
			}
			else if (action == 'clear') {
				{/literal}
					var confirmstring = "{#cleargroup#}";
				{literal}
			}
			var agree = confirm(confirmstring + ": " + currentname + "?");
	
			if(agree) {
				
				if (action == 'del')
				{
					// update path - the element and every element right of it is marked with -1
					// this is necessary, because we don't know whether there's a subelement left
					var Indexes = loadPath();
					
					
					
					for (i = currentlevel; i < 3; i++) {
						Indexes[i] = -1;
					}
					
					savePath(Indexes);
				}
				
				switch (target) {
				  case "img_group_1":
					conditionalclearopener1();
				    break;
				  case "img_group_2":
					conditionalclearopener2();
				    break;
				  case "img_group_3":
					conditionalclearopener3();
				    break;
				  default:
					conditionalclearopener();
				    break;
				}
				
				document.forms[0].submit();
				return true;
			}
			else {
				return false;
			}	
		}
		
		return false;		
	}
	
	function getActions(userid,iseditor)
	{
		// populate the action list with additional actions (depending on user's rights)
		var actionListElement 	= document.forms[0].elements["action"];
		var currentGroupOwner 	= document.forms[0].elements["currentowner"].value;
		var target 				= document.forms[0].elements["target"].value;

		// clear list from old entries
		while (actionListElement.length > 0) {
			actionListElement.options[actionListElement.length - 1] = null;
		}
		
		// insert new entries
		{/literal}
		selectandclose	= new Option('{#selectandclose#}', 'selectandclose', false, true);
		doselect 		= new Option('{#doselect#}', 'doselect', false, false);
		
		rename	 		= new Option('{#rename#}', 'rename', false, false);
		clear	 		= new Option('{#clear#}', 'clear', false, false);
		del				= new Option('{#delete#}', 'del', false, false);
		addsubgroup		= new Option('{#addsubgroup#}', 'addsubgroup', false, false);
		
		{literal}
		
		// always add the possibility to select - our standard action is select and close
		actionListElement.options[actionListElement.length] = selectandclose;
		actionListElement.options[actionListElement.length] = doselect;
		
		
		if ((userid == currentGroupOwner || iseditor > 0) && (target != 'group'))
		{
			actionListElement.options[actionListElement.length] = clear;
			actionListElement.options[actionListElement.length] = rename;			
			actionListElement.options[actionListElement.length] = del;
			actionListElement.options[actionListElement.length] = addsubgroup;
			
			if (iseditor > 0)
			{
			  {/literal}
			   addgroup		= new Option('{#addgroup#}', 'addgroup', false, false);
			   {literal}
			   actionListElement.options[actionListElement.length] = addgroup;
			}
		}
		
		checkParameter();
		
		return true;
	}
	
	{/literal}
	</script>
</head>

<body class="main" style="width: 100%; height: 100%;" {if $lastpath neq ''}onload="restoreSelection('{$currentid}','{$lastpath}','{$user.login}','{$user.editgroups}');"{/if}>

<form action="{$SCRIPT_NAME}" method="post" onsubmit="return checkAndSubmit();" style="width: 100%; height: 100%;">
	<input type="hidden" name="PHPSESSID" value="{$sessionid}" />
	<input type="hidden" name="target" value="{$target}" />
	
	<input type="hidden" name="lastpath" value="{$lastpath}" />

	<table class="header" style="width: 100%; height: 100%;" />
		<tr>
			<td class="heading" colspan="2" style="text-align: left;">
				<a class="navsymbol" href="{$SCRIPT_NAME}?PHPSESSID={$sessionid}&target={$target}">{#groupselection#}</a>
				<span style="font-size: 12pt;">
				&nbsp; ( <a class="navsymbol" href="javascript:window.close();">{#closewindow#}</a> )
				</span>
			</td>
		</tr>
		<tr>
			<td>
				{if $action ne ""}
					<!--
					Funktion: {$action} <br />
					ID: {$currentid} <br />
					Name: {$currentname} <br />
					Owner: {$currentowner} <br />
					Parameter: {$parameter} <br />
					-->
					
					{group_change action=$action id=$currentid name=$currentname owner=$currentowner parameter=$parameter result=result sql=sql}
					
					<!-- display localized information on action success -->
					&nbsp;
					{$smarty.config.$result}
					<br />
					<br />
					
					<!-- {$sql} -->
				{else}
					&nbsp;
				{/if}
			</td>
		</tr>
		<tr>
			<td style="width: 100%; height: 100%; vertical-align: top;">
				<div id='groups' style='position: relative; top: 0px; left: 5px;'>
					{group_list var=groups sql=sql user=$user.login show=$user.usegroups}
					<!-- {$sql} -->
					
					<div id="gid-0" style="width: 250px; position: absolute; left: 0px; top: 0px;">
						<select name="gid-0-groups" class="queryselectfield" style="width: 200px; text-align: center;">
						{if count($groups) neq 0}
							{foreach from=$groups item=l1}
								<option value="{$l1.id}:{$l1.name}:{$l1.owner}" style="text-align: center;" onclick="switchToAndSelect(0,0);getActions('{$user.login}','{$user.editgroups}');restoreHint(0,0);">
									{$l1.name|truncate:50|wordwrap:30:"<br/>\n":true}
								</option>
							{/foreach}
						{/if}
						<option value="-1" selected="selected"  style="text-align: center;">
							--{#level1#}--
						</option>
						</select>
					</div>
					
					{if count($groups) neq 0}
						{foreach from=$groups item=l1}
							{if count($l1.subgroups) neq 0}
								<div id="gid-{$l1.id}" style="width: 250px; position: absolute; left: 250px; top: 0px; visibility: hidden;">
									<select name="gid-{$l1.id}-groups" class="queryselectfield" style="width: 200px; text-align: center;">
										{foreach from=$l1.subgroups item=l2}
											<option value="{$l2.id}:{$l2.name}:{$l2.owner}"  style="text-align: center;" onclick="switchToAndSelect(1,{$l1.id});getActions('{$user.login}','{$user.editgroups}');restoreHint(1,{$l1.id});">
												{$l2.name|truncate:50|wordwrap:30:"<br/>\n":true}
											</option>
										{/foreach}
										<option value="-1" selected="selected"  style="text-align: center;">
											--{#level2#}--
										</option>
									</select>
								</div>					
							{/if}
						{/foreach}
					{/if}
					
					{if count($groups) neq 0}
						{foreach from=$groups item=l1}
							{if count($l1.subgroups) neq 0}
								{foreach from=$l1.subgroups item=l2}
									{if count($l2.subgroups) neq 0}
										<div id="gid-{$l2.id}" style="width: 250px; position: absolute; left: 500px; top: 0px; visibility: hidden;">
											<select name="gid-{$l2.id}-groups" class="queryselectfield" style="width: 200px; text-align: center;">
												{foreach from=$l2.subgroups item=l3}
													<option value="{$l3.id}:{$l3.name}:{$l3.owner}"  style="text-align: center;" onclick="switchToAndSelect(2,{$l2.id});getActions('{$user.login}','{$user.editgroups}');restoreHint(2,{$l2.id});">
														{$l3.name|truncate:50|wordwrap:30:"<br/>\n":true}
													</option>
												{/foreach}
												<option value="-1" selected="selected"  style="text-align: center;">
												--{#level3#}--
												</option>
											</select>
										</div>
									{/if}
								{/foreach}
							{/if}
						{/foreach}
					{/if}
					
					<div id="current" style="width: 250px; position: absolute; left: 0px; top: 50px;">
						<table class="query" cellpadding="0" cellspacing="0">
							<tr>
								<td class="fieldname">
									<strong>{#currentselection#}</strong>
								</td>
							</tr>
							<tr>
								<td class="queryinputfield">
									<input class="queryinputinactive" type="text"  name="currentname" style="width: 200px;" readonly="readonly"/>
									<input class="queryinputfield" type="hidden"  name="currentid" />
									<input class="queryinputfield" type="hidden"  name="currentlevel" />
									<input class="queryinputfield" type="hidden"  name="currentowner" />
								</td>
							</tr>					
						</table>
					</div>
					<div id="action" style="width: 250px; position: absolute; left: 250px; top: 50px;">
						<table class="query" cellpadding="0" cellspacing="0">
							<tr>
								<td class="fieldname">
									<strong>{#action#}</strong>
								</td>
							</tr>
							<tr>
								<td class="queryselectfield">
									<select name="action" class="queryselectfield" onchange="checkParameter();" style="width: 200px; text-align: center;">
										<option value="nothing" style="text-align: center;">
											{#selectgroup#}
										</option>
									</select>
								</td>
							</tr>					
						</table>	
					</div>
					<div id="parameter" style="width: 250px; position: absolute; left: 500px; top: 50px; visibility: hidden;">
						<table class="query" cellpadding="0" cellspacing="0">
							<tr>
								<td class="fieldname">
									<strong>{#input#}</strong>
								</td>
							</tr>
							<tr>
								<td class="queryinputfield">
									<input class="queryinputfield" type="text"  name="parameter" style="width: 200px;"/>
								</td>
							</tr>					
						</table>
					</div>	
					
					<div id="commit" style="width: 250px; position: absolute; left: 0px; top: 130px; visibility: hidden;">
						<input type="submit" name="commit" value="{#commitaction#}" />
					</div>
				</div>
			</td>
		</tr>
		<tr>
			<td> &nbsp; </td>
		</tr>
	</table>
</form>

</body>
</html>

<!-- END group_select.tpl	-->