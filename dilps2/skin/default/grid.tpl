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
BEGIN grid.tpl
--------------------------------------------- -->
{include file="`$config.skinBase``$config.skin`/head.tpl"}

<body class="main" {if $config.soapresults }onload="updateRemoteCollectionFields('{$sessionid}','{$query.queryid}')"{/if}>
<table width="100%" cellpadding="0" cellspacing="0">
<tr>
<td>
<form name="Main" action="{$SCRIPT_NAME}" method="POST">
<input type="hidden" name="view[type]" value="grid">
<input type="hidden" name="view[detail][id]" value="{$view.detail.id}">
<input type="hidden" name="view[edit][id]" value="{$view.edit.id}">
<input type="hidden" name="query[remoteCollection]" value="{$query.remoteCollection}">
<input type="hidden" name="query[remote]" value="">
<table class="header" width="100%">
<tr>
   <td>
   {if $query.querytype eq 'advanced'}
      {include file="`$config.skinBase``$config.skin`/advanced_query.tpl"}
   {else}
      {include file="`$config.skinBase``$config.skin`/easy_query.tpl"}
   {/if}
   </td>
</tr>
</table>
<table class="maincontent" border="0" width="100%" cellpadding="0" cellspacing="0">
<tr>
      {include file="`$config.skinBase``$config.skin`/result_grid.tpl" viewFunc="viewDetail"}
</td>
</tr>
</table>
</form>
</td>
</tr>
</table>
</body>
</html>
<!-- --------------------------------------------
END grid.tpl
--------------------------------------------- -->
