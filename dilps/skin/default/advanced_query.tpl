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
BEGIN advanced_query.tpl
--------------------------------------------- -->
{config_load file="`$config.skinBase``$config.skin`/`$config.language`/easy_query.conf"}
{type_list var=types sql=sql}
<!-- type_list: {$sql} -->
{collection_list var=collections sql=sql}
<!-- collection_list: {$sql} -->
{column_metainfo var=column_operators}
<!--{$debug}-->

<script type="text/javascript">
	function rotateimage(cid, imageid)
	{literal}
	{
		{/literal}
		var confirmstring = "{#rotateimagewithid#}";		
		var agree=confirm(confirmstring+": "+cid+":"+imageid+" ?");	
		
		{literal}
		if (agree)
		{
			document.forms["Main"].elements["action[target]"].value = 'image';
			document.forms["Main"].elements["action[function]"].value = 'rotate';
			document.forms["Main"].elements["action[cid]"].value = cid;
			document.forms["Main"].elements["action[imageid]"].value = imageid;			
			document.forms["Main"].submit();			
		}
		
	}
	{/literal}
	
	function deleteimage(cid, imageid)
	{literal}
	{
		{/literal}			
		var confirmstring = "{#deleteimagewithid#}";		
		var agree=confirm(confirmstring+": "+cid+":"+imageid+" ?");			
		
		if (agree)
		{literal}
		{
			{/literal}
			
			document.forms["Main"].elements["action[target]"].value = 'image';
			document.forms["Main"].elements["action[function]"].value = 'delete';
			document.forms["Main"].elements["action[cid]"].value = cid;
			document.forms["Main"].elements["action[imageid]"].value = imageid;			
			document.forms["Main"].submit();
			{literal}
		}
	}
	{/literal}
</script>

<script language="javascript">
operator_lists = new Array();
var normal = new Array();
var extended = new Array();
var equals = new Array();
var like = new Array();
var none = new Array();
normal["like"] = "{#like#}";
normal["equals"] = "{#equals#}";
extended["like"] = "{#like#}";
extended["equals"] = "{#equals#}";
extended["soundslike"] = "{#soundslike#}";
like["like"] = "{#like#}";
equals["equals"] = "{#equals#}";
operator_lists["normal"] = normal;
operator_lists["extended"] = extended;
operator_lists["like"] = like;
operator_lists["equals"] = equals;
operator_lists["none"] = none;
column_operators = new Array();
{foreach from=$column_operators key=column item=op}
column_operators["{$column}"] = "{$op.operators}";
{/foreach}
</script>
<input type="hidden" name="PHPSESSID" value="{$sessionid}">
<input type="hidden" name="query[querytype]" value="advanced">
<input type="hidden" name="query[fromquerytype]" value="advanced">
<input type="hidden" name="query[transforming_field]" value="">
<input type="hidden" name="query[delete_phrase]" value="">

<table class="query" cellspacing="0" cellpadding="0" width="100%">
<tr>
	<td width="70%">
	<!-- left side of query -->
		<table class="query" cellspacing="1" cellpadding="0">
			<tr>
				<td>
				{foreach from=$query.querypiece key=qpindex item=qp name=qploop}
					{if $qpindex eq 0}
						<table class="querypiece">
							<tr>
							   <td class="queryinputfieldtext">
							      {#collection#}
							   </td>
							   <td>
							      <select class="queryselectfield" name="query[querypiece][0][val][0]">
									   <option value="-1">{#all_collections#|escape:htmlall}</option>
										{foreach from=$collections item=row name=collectionloop}
										<option value="{$row.collectionid}"{if $query.querypiece[0].val[0] eq "" and $config.defaultcollection eq $row.collectionid} selected{elseif $query.querypiece[0].val[0] eq $row.collectionid} selected{/if}>{$row.name|escape:htmlall}</option>
										{/foreach}
								  </select>
							      <input type="hidden" name="query[querypiece][0][field][0]" value="collectionid" />
							      <input type="hidden" name="query[querypiece][0][connector][0]" value="and" />
							      <input type="hidden" name="query[querypiece][0][operator][0]" value="equals" />
							      <input type="hidden" name="query[querypiece][0][not][0]" value="0" />
							      <input type="hidden" name="query[querypiece][0][operator_list][0]" value="equals" />

							   </td>

							</tr>
						</table>
					{else}
						<table class="querypiece">
							{foreach from=$qp.field key=key item=ignore name=phraseloop}
								<tr>
								   <input type="hidden" name="query[querypiece][{$qpindex}][operator_list][{$key}]" value="{$qp.operator_list[$key]}" />
								   <td align="left">
								      <select  class="queryselectfield" name="query[querypiece][{$qpindex}][field][{$key}]" onChange="UpdateSelectList('query[querypiece][{$qpindex}][operator][{$key}]', 'query[querypiece][{$qpindex}][operator_list][{$key}]', this, this.form);">
											{foreach from=$column_operators key=column item=ignored}
											<option value="{$column}"{if $qp.field[$key] eq $column} selected{/if}>{$smarty.config.$column|escape:htmlall}</option>
											{/foreach}
									  </select>
								   </td>
								   <td align="left">
								      <input type="hidden" name="query[querypiece][{$qpindex}][not][{$key}]" value="{if $qp.not[$key] == 1 or $qp.not[$key] eq 'on'}1{else}0{/if}" />
								      <input type="checkbox" class="queryinputfield" name="query[querypiece][{$qpindex}][not][{$key}]box" onchange="queryCheckbox(this.form, 'query[querypiece][{$qpindex}][not][{$key}]', 'query[querypiece][{$qpindex}][not][{$key}]box');" {if $qp.not[$key] == 1  or $qp.not[$key] eq 'on'}checked="checked" {/if}/>
								   </td>
								   <td align="left">
								   {if $qp.operator_list[$key] eq 'normal'}
								      <select  class="queryselectfield" name="query[querypiece][{$qpindex}][operator][{$key}]" >
											<option value="like" {if $qp.operator[$key] eq "like"} selected="selected"{/if}>{#like#}</option>
											<option value="equals" {if $qp.operator[$key] eq "equals"} selected="selected"{/if}>{#equals#}</option>
									  </select>
								   {elseif $qp.operator_list[$key] eq 'extended'}
								      <select  class="queryselectfield" name="query[querypiece][{$qpindex}][operator][{$key}]" >
											<option value="like" {if $qp.operator[$key] eq "like"} selected="selected"{/if}>{#like#}</option>
											<option value="equals" {if $qp.operator[$key] eq "equals"} selected="selected"{/if}>{#equals#}</option>
											<option value="soundslike" {if $qp.operator[$key] eq "soundslike"} selected="selected"{/if}>{#soundslike#}</option>
									  </select>
								   {elseif $qp.operator_list[$key] eq 'like'}
								      <select  class="queryselectfield" name="query[querypiece][{$qpindex}][operator][{$key}]" >
											<option value="like" {if $qp.operator[$key] eq "like"} selected="selected"{/if}>{#like#}</option>
									  </select>
								   {elseif $qp.operator_list[$key] eq 'equals'}
								      <select  class="queryselectfield" name="query[querypiece][{$qpindex}][operator][{$key}]" >
											<option value="equals" {if $qp.operator[$key] eq "equals"} selected="selected"{/if}>{#equals#}</option>
									  </select>
								   {else}
								      <select  class="queryselectfield" name="query[querypiece][{$qpindex}][operator][{$key}]" >
											<option value="-1">&nbsp;&nbsp;&nbsp;&nbsp;</option>
											<option value="-1">&nbsp;&nbsp;&nbsp;&nbsp;</option>
											<option value="-1">&nbsp;&nbsp;&nbsp;&nbsp;</option>
											<option value="-1">&nbsp;&nbsp;&nbsp;&nbsp;</option>
											<option value="-1">&nbsp;&nbsp;&nbsp;&nbsp;</option>
											<option value="-1">&nbsp;&nbsp;&nbsp;&nbsp;</option>
									  </select>
								   {/if}
								   </td>
								   <td align="left">
								   {if $qp.field[$key] eq "type"}
								      <select  class="queryselectfield" name="query[querypiece][{$qpindex}][val][{$key}]">
								        <option value="-1" {if $qp.val[$key] eq "-"}selected{/if}>{#all2#|escape:htmlall}</option>
								    	{foreach from=$types item=type name=typeloop}
								    	<option value="{$type.name}"{if $qp.val[$key] eq $type.name} selected{/if}>{$type.print_name|escape:htmlall}</option>
								    	{/foreach}
								      </select>
								   {else}
								      <input class="queryinputfield" type="text" name="query[querypiece][{$qpindex}][val][{$key}]" size="15" value="{$qp.val[$key]|escape:html}">
								   {/if}
								   </td>
								   <td align="left">
								      <input type="radio" name="query[querypiece][{$qpindex}][connector][{$key}]" value="and" {if $qp.connector[$key] eq "and"}checked="checked"{/if}
								        {if $smarty.foreach.phraseloop.last} onclick="submit()"{/if} />{#queryand#}
								      <input type="radio" name="query[querypiece][{$qpindex}][connector][{$key}]" value="or" {if $qp.connector[$key] eq "or"}checked="checked"{/if}
								        {if $smarty.foreach.phraseloop.last} onclick="submit()"{/if} />{#queryor#}
								      <input type="button" name="delete[{$qpindex}][{$key}]" value="X" onclick="setAndSubmit(this.form, 'query[delete_phrase]', '{$qpindex}:{$key}')" />
								   </td>
								</tr>
							{/foreach}
							{math assign="lastphraseindex" equation="num - 1" num="`$smarty.foreach.phraseloop.total`"}
						</table>
					{/if}
					{if $smarty.foreach.phraseloop.total > 1 or $qpindex < $lastqpindex or $qpindex == 0}
					<tr>
						<td>
						<input type="radio" name="query[querypiece][{$qpindex}][piece_connector]" value="and" {if $qp.piece_connector eq "and"}checked="checked"{/if} {if $smarty.foreach.qploop.last} onclick="submit()"{/if} />{#queryand#}
						<input type="radio" name="query[querypiece][{$qpindex}][piece_connector]" value="or" {if $qp.piece_connector eq "or"}checked="checked"{/if} {if $smarty.foreach.qploop.last} onclick="submit()"{/if} />{#queryor#}
						</td>
					</tr>
					{/if}
					{math assign="lastqpindex" equation="num - 1" num="`$smarty.foreach.qploop.total`"}
				{/foreach}
				</td>
			</tr>
			<tr>
				<td>
					<input type="radio" name="query[imagestatusconnector]" value="and" checked="checked"/>{#queryand#}
				</td>
			</tr>
			<tr>
				<td>
					<table class="querypiece">
						<tr>
							<td class="queryinputfieldtext">
					  			{#imagestatus#|escape:htmlall}
							</td>
							<td class="queryinputfield">
							<select class="queryselectfield" name="query[imagestatus]" onchange="submit()">
								{if $user.admin or $user.editor}
									<option value="all" {if $query.imagestatus eq "all"}selected="selected"{/if}>{#images_all#}</option>
									<option value="new" {if $query.imagestatus eq "new"}selected="selected"{/if}>{#images_new#}</option>
									<option value="edited" {if $query.imagestatus eq "edited"}selected="selected"{/if}>{#images_edited#}</option>
								{/if}
								<option value="reviewed" {if $query.imagestatus eq "reviewed"}selected="selected"{/if}>{#images_reviewed#}</option>
							</select>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td>
					<input type="radio" name="query[groupconnector]" value="and" checked="checked"/>{#queryand#}
				</td>
			</tr>
			<tr>
				<td>
					<table class="querypiece">
						<tr>
							<td class="queryinputfieldtext">
						  		{#group#|escape:htmlall}
								</td>
								<td class="queryinputfield">
								{if $query.group eq ""}
									<input class="queryinputfield" type="text" name="query[group]" size="30" readonly="readonly" value=" ({#all2#}) " onclick="javascript:window.open('group_select.php?target=group','groupselection1','width=800,height=300,left=10,top=250,dependent=yes');">
								{else}
									<input class="queryinputfield" type="text" name="query[group]" size="30" readonly="readonly" value="{$query.group|escape:html}" onclick="javascript:window.open('group_select.php?target=group','groupselection1','width=800,height=300,left=10,top=250,dependent=yes');">
								{/if}
								<input class="queryinputfield" type="hidden" name="query[groupid]" value="{$query.groupid|escape:html}">
								<input class="queryinputfield" type="hidden" name="query[grouplevel]" value="{$query.grouplevel|escape:html}">
								<input type="button" onClick="cleargroup();" name="nogroup" value="{#all2#|escape:html}">
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td>
				&nbsp;
				</td>
			</tr>
			<tr>
			   <td class="queryinputfieldtext" align="left">
			      <input type="button" onClick="editDetail('', 'advanced'); return true;" name="submitquery" value="{#search#|escape:html}">
			      <input type="button" onClick="changeQueryType('simple');" name="changequerytype" value="{#simplesearch#|escape:html}">
			   </td>
			</tr>
		</table>
	<!-- left side of query - end -->
	</td>
	{include file="`$config.skinBase``$config.skin`/query_right.tpl"}
	</tr>
</table>


<!-- --------------------------------------------
END advanced_query.tpl
--------------------------------------------- -->
