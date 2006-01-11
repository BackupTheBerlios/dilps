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
BEGIN default_list_short.tpl
--------------------------------------------- -->
   <tr>
	   <td class="result_list_data_img">
	      <table border="0" cellspacing="0" cellpadding="0">
	      <tr>
	         <td><img src="/icons/blank.gif" width="1" height="90"></td>
	         <td width="100%" style="text-align: center; vertical-align: middle;"><a onClick="showDetail('{$row.collectionid}:{$row.imageid}');"><img src="image.php?PHPSESSID={$sessionid}&id={$row.collectionid}:{$row.imageid}&resolution=120x90" border="0"></a></td>
	      </tr>
	      </table>
	   </td>
	   <td class="result_list_data_data"><b>{$row.name1|escape:htmlall}{if $row.name2 ne ""} {#and#} {$row.name2|escape:htmlall}{/if}</b><br>
		                                  {$row.title|escape:htmlall}{if $row.dating ne ""} ({$row.dating|escape:htmlall}){/if}{if $row.addition ne ""}<br>{$row.addition|escape:htmlall}{/if}</td>
   </tr>
<!-- --------------------------------------------
END default_list_short.tpl
--------------------------------------------- -->
				