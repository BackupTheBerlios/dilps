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
<!-- ============================================
BEGIN result_grid.tpl
============================================ -->
{if $config.utf8 eq "true"}
	{config_load file="`$config.skinBase``$config.skin`/`$config.language`/result.conf.utf8"}
{else}
	{config_load file="`$config.skinBase``$config.skin`/`$config.language`/result.conf"}
{/if}

<script type="text/javascript">
	{literal}
	function changemygroup(buttonid, imageid) 
	{
		// imageid is a combined id here (=> collectionid:imageid)
		
		// do we add or delete?
		var mode;
		
		// change the button
		if (document.getElementById(buttonid) != null)
		{				
			{/literal}
			if (document.getElementById(buttonid).value == "+")
			{literal}
			{
				{/literal}
				mode = 'add';
				document.getElementById(buttonid).value = "-";				
				document.getElementById(buttonid).title = "{#delfrommygroup#}";
				{literal}
			}
			else
			{
				{/literal}
				mode = 'del';
				document.getElementById(buttonid).value = "+";
				document.getElementById(buttonid).title = "{#addtomygroup#}";
				{literal}
			}
		}
		
		// test, if button has been clicked before
		var resid = 'mygroup[' + imageid + ']';
		
		if (document.getElementById(resid) != null)
		{
			document.getElementById(resid).value = mode;
		}
		else
		{			
			// create new hidden input field with resid as name
			var groupElem 				= document.createElement('input');
			groupElem.name 			= resid
			groupElem.value 			= mode;
			groupElem.type				= 'hidden';
			groupElem.className	= 'queryinputfield';
			groupElem.setAttribute('id',resid);
			
			// attach it to the groupchanges block			
			document.getElementById('mygroupchanges').appendChild(groupElem);
		}
		return;	
	}
	{/literal}
</script>

{query var=result sql=sql}
{if $result.result_type eq "collections"}
    {include file="`$config.skinBase``$config.skin`/result_grid_collections.tpl" result=$result}
{else}
<td class="result_grid_nav_top" id="navigation" style="text-align: center"
{if $view.detail.id ne "" or $view.edit.id ne ""}
colspan="2"
{/if}
>
{if $query.showoverviewlink}<div style="float:right"><a class="collection_navsymbol" href="javascript:queryAllCollections()">{#collectionoverview#|escape:html}</a></div>{/if}
<div class="outer">
{#page#|escape:html}
 {include file="`$config.skinBase``$config.skin`/browse.tpl"}
</div>
</td>
</tr>
<tr>
<td style="width: 50%;" valign="top">
<table class="result_list" width="100%" cellspacing="0" cellpadding="0">
<tr>
   <td class="result_grid_nav_left">
   <div class="outer">
    {include file="`$config.skinBase``$config.skin`/select.tpl"}
  </div>
  </td>
</tr>
   <td>
	   <table class="result_grid_data" width="100%">
		{math assign="colwidth" equation="100 / num" num="`$query.cols`"}
		{section name=rows start=0 step=1 loop=$query.rows}
		{assign var="r" value=$smarty.section.rows.index}
	   <tr>
		   {section name=cols start=0 step=1 loop=$query.cols}
			{math assign="id" equation="r * c + cl" r="$r" c=$query.cols cl=$smarty.section.cols.index}
		   <td width="{$colwidth}%" class="result_list_data_img">
				{assign var="row" value=$result.rs[$id]}
			   {if $row.imageid ne ""}
		          {assign var="tpl" value=$template[$row.type]}
			      {include file="`$config.skinBase``$config.skin`/`$tpl.grid`" row=$row viewFunc=$viewFunc query=$query result=$result}
				{else}
				&nbsp;
				{/if}
			</td>
			{/section}
	   </tr>
	  {/section}
	</table>
   </td>
</tr>
</table>
{/if}
{/query}
<!-- ============================================
END result_grid.tpl
============================================ -->
