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
<meta name="author" content="jrgen enge, thorsten wbbena">
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

		if (value == "0") {
			makeInvisible(targetID);
		}
		else {
			makeVisible(targetID);
		}
		return;
	}
		
	{/literal}
</script>

</head>

<body class="main">

<form name="Main" action="{$SCRIPT_NAME}" method="POST" enctype="multipart/form-data">

	<input type="hidden" name="PHPSESSID" value="{$sessionid}">

	<table class="header" style="width: 100%; height: 100%;" />
		<tr>
			<td class="heading" colspan="3" style="text-align: left;">
				<a class="navsymbol" href="{$SCRIPT_NAME}?PHPSESSID={$sessionid}&collectionid={$collectionid}&groupid={$groupid}&groupname={$groupname}">{#exportgroup#}</a>
				<span style="font-size: 12pt;">
				&nbsp; ( <a class="navsymbol" href="javascript:window.close();">{#closewindow#}</a> )
				</span>
			</td>
		</tr>
		<tr>
			<td class="queryinputfieldtext" width="40%">
		  		{#group#|escape:htmlall}
			</td>
			<td class="queryinputfield" width="40%">
				{$groupname|escape:html}
			</td>
			<td width="20%">
				&nbsp;
			</td>
		</tr>
		{if $export neq 1}
			<tr>
				<td class="queryinputfieldtext">
			  		{#withsubgroups#}?
				</td>
				<td class="queryinputfield">
					<select class="queryselectfield" name="subgroups">
						<option value="1">{#yes#}</option>
						<option value="0">{#no#}</option>
					</select>
				</td>
				<td>
					&nbsp;
				</td>
			</tr>
			<tr id="withviewer" style="visibility: visible;">
				<td class="queryinputfieldtext">
			  		{#withviewer#}?
				</td>
				<td class="queryinputfield">
					<select class="queryselectfield" name="withviewer" onchange="javascript:checkTargetSystem();">
						<option value="1">{#yes#}</option>
						<option value="0">{#no#}</option>
					</select>
				</td>
				<td>
					&nbsp;
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
				<td>
					&nbsp;
				</td>
			</tr>
			<tr>
				<td colspan="3">
					&nbsp;
				</td>
			</tr>
			<tr>
				<td class="queryinputfieldtext">
					<input type="submit" name="continue" value="{#continue#|escape:html}">
					<input type="hidden" name="export" value="1">
					<input type="hidden" name="groupid" value="{$groupid}">
					<input type="hidden" name="groupname" value="{$groupname}">
					<input type="hidden" name="collectionid" value="{$collectionid}">
				</td>
				<td colspan="2">
					&nbsp;
				</td>
			</tr>
		{else}
			<tr>
				<td>
					Are we here yet?
				</td>
			</tr>
	</table>
</form>
</body>
</html>

<!-- --------------------------------------------

END group_export.tpl

--------------------------------------------- -->

