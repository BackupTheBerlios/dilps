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

<body class="headerstyle" style="width: 100%; height: 100%;">

<form action="{$SCRIPT_NAME}" name="Main" method="post" style="width: 100%; height: 100%; padding: 0px;">

	<input type="hidden" name="PHPSESSID" value="{$sessionid}" />

	<table class="header" style="width: 930px; height: 150px; padding-left: 10px;">
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
			<td style="text-align: left; width: 320px;">
				<table cellpadding="0" cellspacing="0" style="width: 100%;" />
					<tr>
						<td class="field_name" style="padding: 2px;"><strong>{#source#|escape:htmlall}</strong></td>
					</tr>
					<tr>
						<td class="queryinputfield">
							<table cellpadding="0" cellspacing="0" style="width: 100%; text-align: right;" />
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
										
										<input class="queryinputfield" type="hidden" name="source[page]" value="{$source.page|escape:html}">
									</td>
									<td style="width: 20px; text-align: left; vertical-align: middle;">
										{if $source.groupid}
											<button type="button" class="actionbutton2" onclick="clearsource();" title="{#nogroup#|escape:htmall}"><img src="clear.png" style="width: 12px; height: 12px;" /></button>			
										{else}
											&nbsp;
										{/if}
									</td>
									<td style="width: auto;">
										&nbsp;
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</td>
			<td style="width: auto; text-align: center;">
				<table cellpadding="0" cellspacing="0" />
					<tr>
						<td class="field_name" style="padding: 2px; text-align: left;"><strong>{#action#|escape:htmlall}</strong></td>
					</tr>
					<tr>
						<td class="queryinputfield">
							<select name="action" class="queryselectfield" onchange="checkParameter();" style="width: 300px; text-align: center;">
								<option value="nothing" style="text-align: center;">
									{#selectgroup#}
								</option>
								<option value="movegrouptogroup" style="text-align: center;">
									{#movegrouptogroup#}
								</option>
								<option value="movegrouptogroup" style="text-align: center;">
									{#movecontenttogroup#}
								</option>
								<option value="movegrouptogroup" style="text-align: center;">
									{#moveselectiontogroup#}
								</option>
							</select>
						</td>
					</tr>
				</table>
			</td>
			<td style="text-align: right; width: 320px;">
				<table cellpadding="0" cellspacing="0" style="width: 100%;" />
					<tr>
						<td class="field_name" style="padding: 2px;"><strong>{#target#|escape:htmlall}</strong></td>
					</tr>
					<tr>
						<td class="queryinputfield" style="text-align: right;">
							<table cellpadding="0" cellspacing="0" style="width: 100%; text-align: right;" />
								<tr>
									<td style="width: auto;">
										&nbsp;
									</td>
									<td style="width: 20px; text-align: left; vertical-align: middle;">
										{if $target.groupid neq ""}
											<button type="button" class="actionbutton2" onclick="cleartarget();" title="{#nogroup#|escape:htmall}"><img src="clear.png" style="width: 12px; height: 12px;" /></button>
										{else}
											&nbsp;
										{/if}
									</td>
									<td style="width: 260px; text-align: right;">
										{if $target.groupid neq ""}
											<input class="queryinputfield" type="text" name="target[group]" readonly="readonly" value="{$target.group|escape:html}" onclick="editGroupSelection('{$sessionid}','target','{$target.grouplastpath}','{$target.groupid}');" style="width: 250px;">
										{else}
											<input class="queryinputfield" type="text" name="target[group]" readonly="readonly" value=" ({#selecthere#|escape:htmlall}) " onclick="editGroupSelection('{$sessionid}','target','{$target.grouplastpath}','{$target.groupid}');" style="width: 250px;">
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
	
	<table style="width: 930px; padding-left: 10px;">
		<tr>
			<td style="text-align: center; width: 100%;">
				{if $source.groupid neq ""}
					{group_content_list var=groupcontent numpages=numpages groupid=$source.groupid page=$source.page limit=15 sql=sql}
					<!-- {$sql} -->
					
					{if count($groupcontent) > 0}
						<table cellpadding="0" cellspacing="0" style="border: 1px solid black; text-align: left;">
							<tr>
								<th style="width: 120px; padding-left: 5px;">
									ID
								</th>
								<th style="width: 390px; padding-left: 5px;">
									{#name#}
								</th>
								<th style="width: 390px; padding-left: 5px;">
									{#title#}
								</th>
							</tr>
						{foreach from=$groupcontent key=itemno item=values}
							<tr>
								<td>
									<input type="checkbox" name="{$values.collectionid}-{$values.imageid}" />
									<strong>{$values.collectionid}:{$values.imageid}</strong>
								</td>					   	
								<td>
									{if $values.name1 ne "" or $values.name2 ne ""}
										{if $values.name2 ne "" and $values.name1 ne ""}
											{assign var="combname" value="`$values.name1`; `$values.name2`"}
										{else}
											{assign var="combname" value="`$values.name1``$values.name2`"}
										{/if}
										<span title='{$combname|escape:htmlall}'>{$combname|truncate:35|escape:htmlall}</span>
									{else}
										&nbsp;
									{/if}
								</td>
								<td>
									{if $values.title ne ""}
										{$values.title|replace:"-":"- "|truncate:35|escape:htmlall}		
									{else}
										&nbsp;
									{/if}	
								</td>
							</tr>
						{/foreach}
						</table>
					{else}
						&nbsp;
					{/if}
				{else}
					&nbsp;
				{/if}
			</td>
		</tr>
		<tr>
			<td colspan="3">
				&nbsp;
			</td>
		</tr>
		<tr>
			<td>
				{if $source.groupid neq ""}
					<table cellpadding="0" cellspacing="0" style="border: 1px solid black; text-align: left;">
						<tr>
							<td style="width: 120px; padding-left: 5px;">
								<strong>{#page#}</strong>
							</td>
							<td style="width: 390px; padding-left: 5px;">
								{php}
									$lastpage  = $this->_tpl_vars['numpages']; 
									$curpage = $this->_tpl_vars['source']['page'];
									$out = '';
									$pfirstpage = false;
									$pLastpage  = false;
									
									
									for($i=$curpage-1;$i>($curpage-5) && $i>0; $i--) {
									 $out = '<a class="navigationlink" href="javascript:groupsChangePage('.$i.')">'.$i.' </a>'.$out; 
									 if ($i==1) $pfirstpage = true;
									 if ($i==$lastpage) $pLastpage  = true;
									}
									
									
									
									for($i=$curpage;$i<($curpage+5) && $i<=$lastpage && $curpage>=1; $i++) {
									 if ($i==$curpage) $out.='<b>';
									 $out .= '<a class="navigationlink" href="javascript:groupsChangePage('.$i.')">'.$i.' </a>'; 
									 if ($i==$curpage) $out.='</b>';
									 if ($i==1) $pfirstpage = true;
									 if ($i==$lastpage) $pLastpage  = true;
									}
									
									
									if (!$pfirstpage) 
									if (($curpage-4) > 2)
									 $out = '<a class="navigationlink" href="javascript:groupsChangePage(1)">1</a> ... '.$out;
									else
									 $out = '<a class="navigationlink" href="javascript:groupsChangePage(1)">1 </a>'.$out;
									
									if ((!$pLastpage) && ($lastpage >= 2))
									if (($curpage+4) != ($lastpage-1))
									   $out .= '... <a class="navigationlink" href="javascript:groupsChangePage('.$lastpage.')">'.$lastpage.'</a>';
									else
									   $out .= ' <a class="navigationlink" href="javascript:groupsChangePage('.$lastpage.')">'.$lastpage.'</a>';
									
									
									$out = " < ".$out." > ";
									
									echo $out;
								{/php}
							</td>
							<td style="width: 390px; padding-left: 5px;">
								&nbsp;
							</td>
						</tr>
					</table>
				{else}
					&nbsp;
				{/if}
			</td>
		</tr>
		
	</table>
</form>

</body>
</html>

<!-- END group_edit.tpl -->

