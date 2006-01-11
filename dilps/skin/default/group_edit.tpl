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

{config_load file="`$config.skinBase``$config.skin`/`$config.language`/edit_group.conf"}

<head>
	<meta name="robots" content="index,follow" />
	<meta http-equiv="pragma" content="no-cache" />
	<meta http-equiv="expires" content="0" />
	<meta http-equiv="cache-control" content="no-cache" />
	<meta name="keywords" content="Bilddatenbanksystem, Bilddatenbank, Diathek, digitalisiert" />
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
	<meta http-equiv="Content-Script-Type" content="text/javascript" />
	<meta http-equiv="Content-Style-Type" content="text/css" />
	<meta name="author" content="jürgen enge, thorsten wübbena" />
	<meta name="date" content="2003-01-23" />
	<link rel="shortcut icon" href="favicon.ico" />
	<title>. : {#groupmanagement#|escape:"htmlall"} : .</title>
	<script src="dilps.lib.js" type="text/javascript"></script>
	<link rel="stylesheet" type="text/css" href="css.php" />
	<style type="text/css">
	{include file="`$config.skin`/dilps.css"}
	</style>

	<script src="include/group/group_edit.inc.js" type="text/javascript"></script>

	<script type="text/javascript">
	{literal}

	function changegroup(action, groupid, gowner, gname, actid)
	{
		// alert (action + "-" + groupid + "-" + gowner + "-" + actid);

		document.forms[0].elements["action[function]"].value = action;

		// groupid is either the actual groupid or the parentid
		document.forms[0].elements["action[gid]"].value = groupid;

		// assign owner (may be unchanged)
		document.forms[0].elements["action[gowner]"].value = gowner;

		var groupname;

		if (gname == '')
		{
			groupname = document.forms[0].elements[actid].value
		}
		else
		{
			groupname = gname;
		}

		// can be left empty, if delete is used
		if (action != 'del' && action != 'delr')
		{
			if(groupname != '')
			{
				var search = /((\w.+)\s*\-*).+/;
				var testillegal = search.test(groupname);
				if (testillegal == false)
				{
					{/literal}
					var confirmstring = "{#invalidname#}";
					alert(confirmstring);
					{literal}
				}
				else
				{
					document.forms[0].elements["action[gname]"].value = groupname;
					document.forms[0].submit();
				}
			}
			else
			{
				{/literal}
				var confirmstring = "{#pleaseentergroupname#}";
				alert(confirmstring);
				{literal}

				return;
			}
		}
		else
		{
			if (action == 'del')
			{
				{/literal}
					var confirmstring = "{#deletegroup#}";
				{literal}
			}
			else
			{
				{/literal}
					var confirmstring = "{#deletegroupandsubgroups#}";
				{literal}
			}

			var agree = confirm(confirmstring + ": " + groupname + "?");

			if(agree)
			{
				document.forms[0].submit();
			}
			else
			{
				return;
			}
		}
	}

	function edit (id, owner, name)
	{
		var resid = 'edit-' + id;
		var butid = 'edit-' + id + '-buttons';

		var lastEditID = document.forms[0].elements["lastEdit"].value;

		if (lastEditID != '')
		{
			editcancel(lastEditID);
			document.forms[0].elements["lastEdit"].value = id;
		}
		else
		{
			document.forms[0].elements["lastEdit"].value = id;
		}

		// alert (id + "::" + resid + "::" + butid + "::" + owner + "::" + name);

		var nameBoxText = "<input name='"+resid+"-name' value='"+name+"' size='14' />";
		var confirmBoxText = "<a href=\ class=\"navsymbol\"></a>";

		// create new name element with input box
		var nameBox 		= document.createElement("input");
		nameBox.name 		= resid + "-name";
		nameBox.value 		= name;
		nameBox.size 		= 14;
		nameBox.className 	= "queryinputfield";

		var nameTD			= document.createElement("td");
		nameTD.setAttribute("id",resid);
		nameTD.style.width	= "150px";

		nameTD.appendChild(nameBox);

		// create new button box

		var confirmBox 			= document.createElement("a");
		confirmBox.href			= "javascript:changegroup('edit','"+id+"','"+owner+"','','"+resid+"-name"+"');";
		confirmBox.className	= "navsymbol";

		var confirmText			= "[\u2193]";
		var confirmBoxText		= document.createTextNode(confirmText);
		confirmBox.appendChild(confirmBoxText);

		var spaceText			= " ";
		var spaceBox			= document.createTextNode(spaceText);

		var cancelBox 			= document.createElement("a");
		cancelBox.href			= "javascript:editcancel('"+id+"');";
		cancelBox.className		= "navsymbol";

		var cancelText			= "[x]";
		var cancelBoxText		= document.createTextNode(cancelText);
		cancelBox.appendChild(cancelBoxText);

		var buttonTD			= document.createElement("td");
		buttonTD.setAttribute("id",butid);


		buttonTD.appendChild(confirmBox);
		buttonTD.appendChild(spaceBox);
		buttonTD.appendChild(cancelBox);

		// backup old node and replace with new
		var oldNameNode = document.getElementById(resid).parentNode.replaceChild(nameTD,document.getElementById(resid));
		var backupNameID = 'backup-'+id;
		oldNameNode.setAttribute('id',backupNameID);
		oldNameNode.style.visibility = 'hidden';
		document.getElementById('backup').appendChild(oldNameNode);


		// backup old node and replace with new
		var oldButtonNode = document.getElementById(butid).parentNode.replaceChild(buttonTD,document.getElementById(butid));
		var backupButtonID = 'backup-'+id+'-buttons';
		oldButtonNode.setAttribute('id',backupButtonID);
		oldButtonNode.style.visibility = 'hidden';
		document.getElementById('backup').appendChild(oldButtonNode);

		return;
	}

	function editcancel(id)
	{
		// restore old name node
		var backedNameID = 'backup-'+id;
		var restoredNameNode = document.getElementById(backedNameID).cloneNode(true);
		var restoredNameID = 'edit-'+id;
		restoredNameNode.setAttribute('id',restoredNameID);
		restoredNameNode.style.visibility = 'visible';

		currentNameNode = document.getElementById(restoredNameID);

		currentNameNode.parentNode.replaceChild(restoredNameNode,currentNameNode);

		// restore button node
		var backedButtonID = 'backup-'+id+'-buttons';
		var restoredButtonNode = document.getElementById(backedButtonID).cloneNode(true);
		var restoredButtonID = 'edit-'+id+'-buttons';
		restoredButtonNode.setAttribute('id',restoredButtonID);
		restoredButtonNode.style.visibility = 'visible';

		currentButtonNode = document.getElementById(restoredButtonID);

		currentButtonNode.parentNode.replaceChild(restoredButtonNode,currentButtonNode);

		return;
	}

	function moveTo(divid,yPos)
	{
		if (document.getElementById(divid) != null)
		{
			document.getElementById(divid).style.top = yPos + 'px';
		}
		return;
	}

	function makeVisible(divid) {
		// alert('Vis: '+divid);
		if (document.getElementById(divid) != null)
		{
			document.getElementById(divid).style.visibility = "visible";
		}
		return;
	}

	function makeInvisible(divid) {
		// alert('Invis: '+divid);
		if (document.getElementById(divid) != null)
		{
			document.getElementById(divid).style.visibility = "hidden";
		}
		return;
	}

	function switchTo(l1id,l2id,yPos) {
		// alert ('l1: '+l1id+',l2: '+l2id+',yPos: '+yPos);

		var lastL2 = document.forms[0].elements["lastL2"].value;
		var lastL1 = document.forms[0].elements["lastL1"].value;

		if (l2id != '')
		{
			if (lastL2 != '')
			{
				makeInvisible(lastL2);
			}
			moveTo(l2id,yPos);
			makeVisible(l2id);
			document.forms[0].elements["lastL2"].value = l2id;

			return;
		}
		else if (l1id != '')
		{
			if (lastL2 != '')
			{
				makeInvisible(lastL2);
			}
			if (lastL1 != '')
			{
				makeInvisible(lastL1);
			}
			moveTo(l1id,yPos);
			makeVisible(l1id);
			document.forms[0].elements["lastL1"].value = l1id;
			document.forms[0].elements["lastL2"].value = '';

			return;
		}
	}

	{/literal}
	</script>
</head>
<body class="main" style="width: 100%; height: 100%;">



<form action="{$SCRIPT_NAME}" method="post" style="width: 100%; height: 100%;">
	<input type="hidden" name="PHPSESSID" value="{$sessionid}" />

	<input type="hidden" name="lastL1" value="{$lastL1}" />
	<input type="hidden" name="lastL2" value="{$lastL2}" />

	<input type="hidden" name="lastEdit" value="" />

	<input type="hidden" name="action[function]" value="" />
	<input type="hidden" name="action[gid]" value="" />
	<input type="hidden" name="action[gname]" value="" />
	<input type="hidden" name="action[gowner]" value=""/>

	<table class="header" style="width: 100%; height: 100%">
		<tr>
			<td class="heading" colspan="2" style="text-align: left;">
				<a class="navsymbol" href="{$SCRIPT_NAME}?PHPSESSID={$sessionid}">{#groupmanagement#}</a>
				<span style="font-size: 12pt;">
				&nbsp; ( <a class="navsymbol" href="javascript:window.close();">{#closewindow#}</a> )
				</span>
			</td>
		</tr>
		<tr>
			<td colspan="2" style="text-align: left;">

				{if $action.function neq ""}
					{group_change action=$action.function gid=$action.gid gname=$action.gname gowner=$action.gowner result=result sql=sql}

					<!-- display localized information on action success -->
					{if $action_result eq "E_ADD_FAILED"}
						{#E_ADD_FAILED#}
					{elseif $action_result eq "R_ADD_SUCCESS"}
						{#R_ADD_SUCCESS#}
					{elseif $action_result eq "E_EDIT_FAILED"}
						{#E_EDIT_FAILED#}
					{elseif $action_result eq "R_EDIT_SUCCESS"}
						{#R_EDIT_SUCCESS#}
					{elseif $action_result eq "E_DELETE_FAILED"}
						{#E_DELETE_FAILED#}
					{elseif $action_result eq "R_DELETE_SUCCESS"}
						{#R_DELETE_SUCCESS#}
					{elseif $action_result eq "E_NOT_UNIQUE"}
						{#E_NOT_UNIQUE#}
					{else}
						&nbsp;
					{/if}

					<!-- $sql -->
				{else}
					&nbsp;
				{/if}
			</td>
		</tr>
		<tr>
			<td style="width: 100%; height: 100%; vertical-align: top;">
				<div id='groups' style='position: relative; top: 0px; left: 0px;'>
					{group_list var=groups sql=sql parentid=0}
					<!-- {$sql} -->
					<div id="gid-0" style="width: 250px; position: absolute; left: 0px; top: 0px;">
					<!-- section: gid-0 -->
						{assign var="l1counter" value="0"}

						{foreach from=$groups item=l1}
							<!-- section: gcount-{$l1counter} -->
							<div id="gcount-{$l1counter}" style="width: 250px; position: absolute; left: 0px; top: {$l1counter*20}px;">
								<table>
									<tr>
										<td id="edit-{$l1.id}" style="width: 150px;">
											<a href="javascript:switchTo('gid-{$l1.id}','','{$l1counter*20}')" class="navsymbol" title="{$l1.name}">{$l1.name|truncate:12}</a>
											{assign var="id" value ="gid-`$l1.id`"}
											{if $lastL1 eq $id}
												{assign var="l1Offset" value ="`$l1counter*20`"}
											{/if}
										</td>
										<td id="edit-{$l1.id}-buttons">
											<a href="javascript:edit('{$l1.id}','{$l1.owner}','{$l1.name}');" class="navsymbol">[e]</a>
											<a href="javascript:changegroup('delr','{$l1.id}','{$l1.owner}','{$l1.name}','');" class="navsymbol">[-]</a>
										</td>
									</tr>
								</table>
							</div>
							<div id="gid-{$l1.id}" style="width: 250px; position: absolute; left: 250px; top: 0px; visibility: hidden;">
							<!-- section: gid-{$l1.id} -->
								{assign var="l2counter" value="0"}
								{foreach from=$l1.subgroups item=l2}
									<div id="gcount-{$l1counter}-{$l2counter}" style="width: 250px; position: absolute; left: 0px; top: {$l2counter*20}px;">
										<table>
											<tr>
												<td id="edit-{$l2.id}" style="width: 150px;">
													<a href="javascript:switchTo('gid-{$l1.id}','gid-{$l2.id}','{$l2counter*20}')" class="navsymbol" title="{$l2.name}">{$l2.name|truncate:12}</a>
													{assign var="id" value ="gid-`$l2.id`"}
													{if $lastL2 eq $id}
														{assign var="l2Offset" value ="`$l2counter*20`"}
													{/if}
												</td>
												<td id="edit-{$l2.id}-buttons">
													<a href="javascript:edit('{$l2.id}','{$l2.owner}','{$l2.name}');" class="navsymbol">[e]</a>
													<a href="javascript:changegroup('delr','{$l2.id}','{$l2.owner}','{$l2.name}','');" class="navsymbol">[-]</a>
												</td>
											</tr>
										</table>
									</div>
									<div id="gid-{$l2.id}" style="width: 250px; position: absolute; left: 250px; top: 0px; visibility: hidden;">
									<!-- section: gid-{$l2.id} -->
										{assign var="l3counter" value="0"}
										{foreach from=$l2.subgroups item=l3}
											<div id="gcount-{$l1counter}-{$l2counter}-{$l3counter}" style="width: 350px; position: absolute; left: 0px; top: {$l3counter*20}px;">
												<table>
													<tr>
														<td id="edit-{$l3.id}" style="width: 150px;">
															<span class="navsymbollike" title="{$l3.name}">{$l3.name|truncate:12}</span>
														</td>
														<td  id="edit-{$l3.id}-buttons">
															<a href="javascript:edit('{$l3.id}','{$l3.owner}','{$l3.name}');" class="navsymbol">[e]</a>
															<a href="javascript:changegroup('del','{$l3.id}','{$l3.owner}','{$l3.name}','');" class="navsymbol">[-]</a>
														</td>
													</tr>
												</table>
											</div>
											{assign var="l3counter" value="`$l3counter+1`"}
										{/foreach}
										<div style="width: 350px; position: absolute; left: 0px; top: {$l3counter*20}px;">
											<table>
												<tr>
													<td style="width: 150px;">
														<input class="queryinputfield" type="text"  name="gcount-{$l1counter}-{$l2counter}-{$l3counter}-groupname" size="14" />
													</td>
													<td>
														<a href="javascript:changegroup('add','{$l2.id}','{$user.login}','','gcount-{$l1counter}-{$l2counter}-{$l3counter}-groupname');" class="navsymbol">[+]</a>
													</td>
												</tr>
											</table>
										</div>
									</div>
									{assign var="l2counter" value="`$l2counter+1`"}
								{/foreach}
								<div style="width: 350px; position: absolute; left: 0px; top: {$l2counter*20}px;">
									<table>
										<tr>
											<td style="width: 150px;">
												<input class="queryinputfield" type="text"  name="gcount-{$l1counter}-{$l2counter}-{$l3counter}-groupname" size="14" />
											</td>
											<td>
												<a href="javascript:changegroup('add','{$l1.id}','{$user.login}','','gcount-{$l1counter}-{$l2counter}-{$l3counter}-groupname');" class="navsymbol">[+]</a>
											</td>
										</tr>
									</table>
								</div>
							</div>
							{assign var="l1counter" value="`$l1counter+1`"}
						{/foreach}
						<div style="width: 350px; position: absolute; left: 0px; top: {$l1counter*20}px;">
							<table>
								<tr>
									<td style="width: 150px;">
										<input class="queryinputfield" type="text"  name="gcount-{$l1counter}-{$l2counter}-{$l3counter}-groupname" size="14" />
									</td>
									<td>
										<a href="javascript:changegroup('add','0','{$user.login}','','gcount-{$l1counter}-{$l2counter}-{$l3counter}-groupname');" class="navsymbol">
										[+]
										</a>
									</td>
								</tr>
							</table>
						</div>
					</div>
				</div>
				<div id='backup' style='position: relative; top: 0px; left: 0px; visibility: hidden;'>
				</div>
			</td>
		</tr>
		<tr>
			<td> &nbsp; </td>
		</tr>
	</table>
</form>
{if $lastL1 neq ""}
	<script type="text/javascript">
		switchTo('{$lastL1}','','{$l1Offset}');
	</script>
{/if}
{if $lastL2 neq ""}
	<script type="text/javascript">
		switchTo('{$lastL1}','{$lastL2}','{$l2Offset}');
	</script>
{/if}
</body>
</html>

<!-- END group_select.tpl -->