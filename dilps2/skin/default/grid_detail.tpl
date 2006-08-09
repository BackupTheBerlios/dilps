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
BEGIN grid_detail.tpl
============================================ -->
{include file="`$config.skinBase``$config.skin`/head.tpl"}


<body class="main" {if $config.soapresults }onload="updateRemoteCollectionFields('{$sessionid}','{$query.queryid}')"{/if}>

<form name="Main" action="{$SCRIPT_NAME}" method="POST">
<input type="hidden" name="view[type]" value="grid_detail">
<input type="hidden" name="view[detail][id]" value="{$view.detail.id}">
<input type="hidden" name="view[edit][id]" value="{$view.edit.id}">
<input type="hidden" name="query[remoteCollection]" value="{$query.remoteCollection}">

<div id="query">
   {if $query.querytype eq 'advanced'}
        <div id="query_advanced">
      {include file="`$config.skinBase``$config.skin`/query_advanced.tpl"}
        </div>
        <div id="query_right">
      {include file="`$config.skinBase``$config.skin`/query_right.tpl"}
        </div>
   {else}
    <div id="query_easy">
      {include file="`$config.skinBase``$config.skin`/query_easy.tpl"}
    </div> 
    <div id="query_right">
      {include file="`$config.skinBase``$config.skin`/query_right.tpl"}
    </div> 
   {/if}
</div> 

{if $newlogin neq '1'}
	<div class="maincontent">
	
    <div id="grid_result">
		  {include file="`$config.skinBase``$config.skin`/result_grid.tpl" viewFunc="showDetail"}
    </div>
		
			{if $view.edit.id ne ""}
      <div id="detail_edit">
				{include file="`$config.skinBase``$config.skin`/edit_detail.tpl" id=$view.edit.id}
			</div>
        {else}
      <div id="detail_result">
				{include file="`$config.skinBase``$config.skin`/result_detail.tpl" id=$view.detail.id}
			</div>
        {/if}
		</div>
	</div>
{/if}

</form>
</body>
</html>
<!-- ============================================
END grid_detail.tpl
============================================ -->
