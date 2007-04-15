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
	<link rel="stylesheet" type="text/css" href="css.php" />
	<style type="text/css">
		{include file="`$config.skin`/dilps.css"}
	</style>

	<style type="text/css">
	{literal}
		td{
			vertical-align: top;
		}
	{/literal}
	</style>
</head>

<body class="main" style="width: 100%; height: 100%;">

<form action="{$SCRIPT_NAME}" name="Main" method="post" style="width: 100%; height: 100%;">

	<input type="hidden" name="PHPSESSID" value="{$sessionid}" />

	<table class="header" style="width: 100%; height: 100%; padding: 10px;">
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
			</td>
		</tr>
		<tr>
			<td style="text-align: left;">
				<table class="query" cellpadding="0" cellspacing="0">
					<tr>
						<td class="field_name"><strong>{#source#|escape:htmlall}</strong></td>
					</tr>
					<tr>
						<td class="queryinputfield">
							<table class="query" cellpadding="0" cellspacing="0" style="width: 90%;">
								<tr>
									<td style="width: 90%; text-align: left;">
										{if $query.mygroup eq ""}
											<input class="queryinputfield" type="text" name="source[group]" size="40" readonly="readonly" value=" ({#selecthere#|escape:htmlall}) " onclick="editGroupSelection('{$sessionid}','source','{$source.grouplastpath}','{$source.groupid}');">
										{else}
											<input class="queryinputfield" type="text" name="source[group]" size="40" readonly="readonly" value="{$source.group|escape:html}" onclick="editGroupSelection('{$sessionid}','source','{$source.grouplastpath}','{$source.groupid}');">
										{/if}
						
										<input class="queryinputfield" type="hidden" name="source[groupid]" value="{$source.groupid|escape:html}">
										<input class="queryinputfield" type="hidden" name="source[groupowner]" value="{$source.groupowner|escape:html}">
										<input class="queryinputfield" type="hidden" name="source[grouplastpath]" value="{$source.grouplastpath|escape:html}">
									</td>
									<td style="width: 10%; text-align: right;">
										{if $query.mygroup neq ""}
											<button type="button" class="actionbutton2" onclick="clearsource();" title="{#nogroup#|escape:htmall}"><img src="clear.png" style="width: 12px; height: 12px;" /></button>			
										{else}
											&nbsp;
										{/if}
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</td>
			<td>
				<table class="query" cellpadding="0" cellspacing="0">
					<tr>
						<td class="field_name"><strong>{#action#|escape:htmlall}</strong></td>
					</tr>
					<tr>
						<td class="queryinputfield">
							<select name="action" class="queryselectfield" onchange="checkParameter();" style="width: 200px; text-align: center;">
								<option value="nothing" style="text-align: center;">
									{#selectgroup#}
								</option>
							</select>
						</td>
					</tr>
				</table>
			</td>
			<td style="text-align: left;">
				<table class="query" cellpadding="0" cellspacing="0">
					<tr>
						<td class="field_name"><strong>{#target#|escape:htmlall}</strong></td>
					</tr>
					<tr>
						<td class="queryinputfield">
							<table class="query" cellpadding="0" cellspacing="0" style="width: 90%;">
								<tr>
									<td style="width: 90%; text-align: left;">
										
										{if $query.mygroup eq ""}
											<input class="queryinputfield" type="text" name="target[group]" size="40" readonly="readonly" value=" ({#selecthere#|escape:htmlall}) " onclick="editGroupSelection('{$sessionid}','target','{$target.grouplastpath}','{$target.groupid}');">
										{else}
											<input class="queryinputfield" type="text" name="target[group]" size="40" readonly="readonly" value="{$target.group|escape:html}" onclick="editGroupSelection('{$sessionid}','target','{$target.grouplastpath}','{$target.groupid}');">
										{/if}
						
										<input class="queryinputfield" type="hidden" name="target[groupid]" value="{$target.groupid|escape:html}">
										<input class="queryinputfield" type="hidden" name="target[groupowner]" value="{$target.groupowner|escape:html}">
										<input class="queryinputfield" type="hidden" name="target[grouplastpath]" value="{$target.grouplastpath|escape:html}">
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td colspan="3"> &nbsp; </td>
		</tr>
	</table>
</form>

</body>
</html>

<!-- END group_edit.tpl -->

