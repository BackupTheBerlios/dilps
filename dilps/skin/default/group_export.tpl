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

BEGIN group_export.tpl

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
<script src="dilps.lib.js" type="text/javascript"></script>

<script type="text/javascript">
	{literal}
	
	function checkTargetSystem()
	{
		var targetID = "targetsystem";
		var elemSelect = "withviewer";
		var elem;
		var value;

		elem 		= document.forms[0].elements[elemSelect];
		value 		= elem.options[elem.selectedIndex].value;

		if (value == "no") {
			makeInvisible(targetID);
		}
		else {
			makeVisible(targetID);
		}
		return;
	}
	
	function deleteExport(id)
	{
		if (id == '') {
			return false;
		}
		else {
			document.forms[0].elements['export'].value = 0;
			document.forms[0].elements['show'].value = 1;
			document.forms[0].elements['deleteid'].value = id;
			document.forms[0].submit();
			return true;
		}
	}
		
	{/literal}
</script>

</head>

<body class="headerstyle" style="width: 100%; height: 100%; vertical-align: top;">
	<table class="header" style="width: 100%;" />
	
	<form name="Main" action="{$SCRIPT_NAME}" method="POST" enctype="multipart/form-data">
	<input type="hidden" name="PHPSESSID" value="{$sessionid}">
	
		<tr>
			<td class="heading" colspan="3" style="text-align: left;">
				<a class="navsymbol" href="{$SCRIPT_NAME}?PHPSESSID={$sessionid}&groupid={$groupid}&groupname={$groupname}">{#exportgroup#}</a>
				<span style="font-size: 12pt;">
				&nbsp; ( <a class="navsymbol" href="javascript:window.close();">{#closewindow#}</a> )
				</span>
			</td>
		</tr>
		{if ($export neq "1") and ($show neq "1")}
			<tr>
				<td class="queryinputfieldtext" width="40%">
			  		{#group#|escape:htmlall}
				</td>
				<td class="queryinputfield" width="60%">
					{$groupname|escape:html}
				</td>
			</tr>
			<tr>
				<td class="queryinputfieldtext">
			  		{#withsubgroups#}?
				</td>
				<td class="queryinputfield">
					<select class="queryselectfield" name="subgroups">
						<option value="yes">{#yes#}</option>
						<option value="no">{#no#}</option>
					</select>
				</td>
			</tr>
			<tr id="withviewer" style="visibility: visible;">
				<td class="queryinputfieldtext">
			  		{#withviewer#}?
				</td>
				<td class="queryinputfield">
					<select class="queryselectfield" name="withviewer" onchange="javascript:checkTargetSystem();">
						<option value="yes">{#yes#}</option>
						<option value="no">{#no#}</option>
					</select>
				</td>
			</tr>
			<tr id="targetsystem" style="visibility: visible;">
				<td class="queryinputfieldtext">
			  		{#targetsystem#}?
				</td>
				<td class="queryinputfield">
					<select class="queryselectfield" name="targetsystem">
						<option value="win">Windows</option>
						<option value="mac">MacOS</option>
					</select>
				</td>
			</tr>
			<tr id="comment" style="visibility: visible;">
				<td class="queryinputfieldtext">
			  		{#comment#} ({#optional#})
				</td>
				<td class="queryinputfield">
					<input class="queryinputfield" type="text" size="50" name="comment" value='{#nocomment#}' 
						onclick="javascript:document.forms['Main'].elements['comment'].value = ''; return;"
						onblur="javascript:if (document.forms['Main'].elements['comment'].value == '') document.forms['Main'].elements['comment'].value = '{#nocomment#}'; return;"
					/>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					&nbsp;
				</td>
			</tr>
			<tr>
				<td class="queryinputfieldtext">
					<input type="submit" name="continue" value="{#continue#|escape:html}">
					<input type="hidden" name="export" value="1">
					<input type="hidden" name="show" value="1">
					<input type="hidden" name="groupid" value="{$groupid}">
					<input type="hidden" name="groupname" value="{$groupname}">
				</td>
				<td>
					&nbsp;
				</td>
			</tr>
		{else}
			<tr>
				<td colspan="2">
					<input type="hidden" name="export" value="1">
					<input type="hidden" name="show" value="1">
					<input type="hidden" name="deleteid" value="">
					&nbsp;
				</td>
			</tr>
			<tr>
				<td colspan="2">
					{if $export eq "1"}
						&nbsp;
						<!--
						Funktion: Export <br />
						ID: {$groupid} <br />
						Name: {$groupname} <br />
						Comment: {$comment} <br />
						With Viewer: {$withviewer} <br />
						Subgroups: {$subgroups} <br />
						Target System: {$targetsystem} <br />
						-->
					
						{group_export id=$groupid name=$groupname subgroups=$subgroups withviewer=$withviewer targetsystem=$targetsystem comment=$comment result=result sql=sql}
	
						<!-- display localized information on action success -->
						{if $result eq "E_WRITE_XML"}
							{#E_WRITE_XML#}
						{elseif $result eq "E_COPY_IMAGE"}
							{#E_COPY_IMAGE#}
						{elseif $result eq "E_ACCESS_DB"}
							{#E_ACCESS_DB#}
						{elseif $result eq "E_CREATE_DIRECTORY"}
							{#E_CREATE_DIRECTORY#}
						{elseif $result eq "E_CREATE_ZIP"}
							{#E_CREATE_ZIP#}
						{elseif $result eq "E_COPY_VIEWER"}
							{#E_COPY_VIEWER#}
						{elseif $result eq "R_EXPORT_SUCCESSFUL"}
							{#R_EXPORT_SUCCESSFUL#}
						{/if}
						<br /> <br />
						<!-- {$sql} -->
					{else}
						&nbsp;
					{/if}
					
					{if $deleteid neq ""}
						{group_export_delete userid=$user.login deleteid=$deleteid result=result sql=sql}
					{/if}
					
				</td>
			</tr>
			<tr>
				<td colspan="2">
				
					{if $show eq "1"}
					
						{group_export_list userid=$user.login result=result sql=sql}
		
						<!-- display localized error in cases of db-problems -->
						{if $result eq "E_ACCESS_DB"}
							&nbsp;
							{#E_ACCESS_DB#}
							<!-- {$sql} -->
						{else}
							{if count($result) neq 0}
								<table class="query" cellpadding="0" cellspacing="0" style="width: 100%; padding: 1px; text-align: left;">
								<tr>
									<td class="queryinputfieldtext" style="width: 35%;">
										{#group#}
									</td>
									<td class="queryinputfieldtext" style="width: 35%;">
										{#comment#}
									</td>
									<td class="queryinputfieldtext" style="width: 30%;">
										{#exportdate#}
									</td>
								</tr>
								{foreach from=$result item=export}
									<tr>
										<td>
											{$export.groupname|escape:htmlall}
										</td>
										<td>
											{$export.comment|escape:htmlall}
										</td>
										<td>
											{$export.creationtime|date_format:"%d.%m.%Y / %H:%M:%S"}
										</td>
									</tr>
									<tr>
										<td colspan="3" style="padding: 4px;">
											<button type="button" name="delete" class="actionbutton" onclick="javascript:deleteExport('{$export.id}');" title="{#delete#}">{#delete#}</button>
											&nbsp;
											<button type="button" name="download" class="actionbutton" onclick="javascript:location.href='{$export.url}';" title="{#download#}">{#download#}</button>
										</td>
									</tr>
								{/foreach}
								</table>
								
							{/if}
							
						{/if}
						
					{/if}
				</td>
			</tr>
		{/if}
		</form>
	</table>
</body>
</html>

<!-- --------------------------------------------

END group_export.tpl

--------------------------------------------- -->

