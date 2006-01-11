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
BEGIN default_grid.tpl
--------------------------------------------- -->
<table border="0" cellspacing="0" width="100%">
<tr>
   <td rowspan="2"><img src="/icons/blank.gif" width="1" height="91"></td>
   <td><img src="/icons/blank.gif" width="121" height="1"></td>
</tr>
<tr><td style="text-align: center"><a href="javascript:{$viewFunc}('{$sessionid}','{$row.collectionid}:{$row.imageid}');"><img src="image.php?PHPSESSID={$sessionid}&id={$row.collectionid}:{$row.imageid}&resolution=120x90" border="0"></a></td></tr>
<tr>
   <td colspan="2" class="result_list_data_data" style="text-align: center">
   <b>{$row.name1|escape:htmlall}
   {if $row.name2 ne ""}<br/>
   {$row.name2|escape:htmlall}{/if}</b>
   <br>
   {$row.title|replace:"-":"- "|truncate:50|escape:htmlall}
   </td>
</tr>
<tr>
	<td colspan="2" class="result_list_data_data" style="text-align: center">
		{if $query.mygroupid neq ""}	
			{mygroup_isin var=ingroup sql=sql cid=$row.collectionid groupid=$query.mygroupid imageid=$row.imageid}
			{if $ingroup eq 'no'}
				<a href="javascript:changemygroup('add','{$row.collectionid}','{$query.mygroupid}','{$row.imageid}');" 
					class="navigationlink">
					<strong>{#addtomygroup#}</strong>
				</a>			
			{else}			
				<a href="javascript:changemygroup('delete','{$row.collectionid}','{$query.mygroupid}','{$row.imageid}');" 
					class="navigationlink"><strong>{#delfrommygroup#}</strong>
				</a>
			{/if}
			<!-- {$sql} -->
			
			<br /><br />
		{/if}		
		
		{if $user.editor}
			<a href="javascript:rotateimage('{$row.collectionid}','{$row.imageid}');" 
				class="navigationlink">
				<em>{#rotate#}</em>
			</a>
		{/if}
		<br />
		{if $user.admin}
		  	<a href="javascript:deleteimage('{$row.collectionid}','{$row.imageid}');" 
				class="navigationlink">
				<em>{#delete#}</em>
			</a>
		{/if}
		<br />
   </td>
</tr>
</table>
<!-- --------------------------------------------
END default_grid.tpl
--------------------------------------------- -->
				