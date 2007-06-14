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
BEGIN default_edit.tpl
--------------------------------------------- -->
		<tr>
		   <td class="result_detail_data_head">{#title#|escape:htmlall}</td>
		   <td colspan="2" class="result_detail_data_data"><input type="text" name="edit[title]" size="60" style="width: 300px;" value="{$row.title|escape:html}"></td>
		</tr>
		<tr>
			<td class="result_detail_data_head">{#name#|escape:htmlall}</td>
			<td colspan="2" class="result_detail_data_data">
				<table cellpadding="0" cellspacing="0" style="margin:0px; padding: 0px; vertical-align: middle;">
          <tr>
      		  <td>
        		  <input class="inactive" type="text" name="edit[name1text]" size="60" style="width: 300px;" value="{$row.name1text|escape:html}" style="width: 300px;" readonly="readonly"><br />
            	<input type="hidden" name="edit[name1id]" value="{$row.name1id|escape:html}">
        		</td>
        	  <td>
        		  &nbsp;[<a onClick="editNameElement( '{$sessionid}', '{$id}', 'name', document.Main.elements );">{#enter#}</a>]
          	  {if ($user.admin) and $row.name1id}
        			   &nbsp; / &nbsp;[<a onClick="editThesaurus( '{$sessionid}', '{$id}', 'name', '{$row.name1id}', '1');">{#thesaurus#}</a>]
        		  {/if}
            </td>
      		</tr>
        </table>
		  </td>
		</tr>
		
		<tr>
			<td class="result_detail_data_head">{#name2#|escape:htmlall}</td>
			<td colspan="2" class="result_detail_data_data">
				<table cellpadding="0" cellspacing="0" style="margin:0px; padding: 0px; vertical-align: middle;">
          <tr>
      		  <td>
        		  <input class="inactive" type="text" name="edit[name2text]" size="60" style="width: 300px;" value="{$row.name2text|escape:html}" style="width: 300px;" readonly="readonly">
      		    <input type="hidden" name="edit[name2id]" value="{$row.name2id|escape:html}">
        		</td>
        	  <td>
        		  &nbsp;[<a onClick="editNameElement( '{$sessionid}', '{$id}', 'name', document.Main.elements );">{#enter#}</a>]
              {if ($user.admin) and $row.name2id}
      		      &nbsp; / &nbsp;[<a onClick="editThesaurus( '{$sessionid}', '{$id}', 'name', '{$row.name2id}', '2', '{$id}');">{#thesaurus#}</a>]
      		    {/if}
            </td>
      		</tr>
        </table>
		  </td>
		</tr>
		<tr>
			<td class="result_detail_data_head">
		    	{#name2#|escape:htmlall}
		    </td>
		</tr>
		<tr>
		   <td class="result_detail_data_head">{#addition#|escape:htmlall}</td>
		   <td colspan="2" class="result_detail_data_data"><input type="text" name="edit[addition]" size="60" style="width: 300px;" value="{$row.addition|escape:html}"></td>
		</tr>
		<tr>
		   <td class="result_detail_data_head">{#date#|escape:htmlall}</td>
		   <td colspan="2" class="result_detail_data_data"><input type="text" name="edit[dating]" size="60" style="width: 300px;" value="{$row.dating|escape:html}"></td>
		</tr>
		<tr>
		   <td class="result_detail_data_head">{#material#|escape:htmlall}</td>
		   <td colspan="2" class="result_detail_data_data"><input type="text" name="edit[material]" size="60" style="width: 300px;" value="{$row.material|escape:html}"></td>
		</tr>
		<tr>
		   <td class="result_detail_data_head">{#technics#|escape:htmlall}</td>
		   <td colspan="2" class="result_detail_data_data"><input type="text" name="edit[technique]" size="60" style="width: 300px;" value="{$row.technique|escape:html}"></td>
		</tr>
		<tr>
		   <td class="result_detail_data_head">{#format#|escape:htmlall}</td>
		   <td colspan="2" class="result_detail_data_data"><input type="text" name="edit[format]" size="60" style="width: 300px;" value="{$row.format|escape:html}"></td>
		</tr>

		<tr>
			<td class="result_detail_data_head">{#city#|escape:htmlall}</td>
			<td colspan="2" class="result_detail_data_data">
				<table cellpadding="0" cellspacing="0" style="margin:0px; padding: 0px; vertical-align: middle;">
      		<tr>
      			<td>
      				<input class="inactive" type="text" name="edit[city]" size="60" value="{$row.city|escape:html}" style="width: 300px;" readonly="readonly"><br />
      			</td>
      			<td style="vertical-align: top;">
      				&nbsp;[<a onClick="editElement( '{$sessionid}', '{$id}', 'loc', '{$row.name|escape:htmlall}' );">{#enter#}</a>]
              {if $user.admin and $row.institution}
                &nbsp; / &nbsp;[<a onClick="editThesaurus( '{$sessionid}', '{$id}', 'location', '{$row.locationid}', '{$id}');">{#thesaurus#}</a>]
    			    {/if}
      			</td>
      		</tr>
      	</table>
		  </td>
		</tr>
		
		<tr>
			<td class="result_detail_data_head">{#institution#|escape:htmlall}</td>
			<td colspan="2" class="result_detail_data_data">
				<table cellpadding="0" cellspacing="0" style="margin:0px; padding: 0px; vertical-align: middle;">
      		<tr>
      			<td>
			   	    <input class="inactive" type="text" name="edit[institution]" size="60" value="{$row.institution|escape:html}" style="width: 300px;" readonly="readonly">
      			</td>
      			<td style="vertical-align: top;">
      				&nbsp;[<a onClick="editElement( '{$sessionid}', '{$id}', 'loc', '{$row.name|escape:htmlall}' );">{#enter#}</a>]
              {if $user.admin and $row.institution}
    			      &nbsp; / &nbsp;[<a onClick="editThesaurus( '{$sessionid}', '{$id}', 'institution', '{$row.id}');">{#thesaurus#}</a>]
    			    {/if}
      			</td>
      		</tr>
      	</table>
		  </td>
		</tr>
		
		<tr>
		   <td class="result_detail_data_head">{#src#|escape:htmlall}</td>
		   <td colspan="2" class="result_detail_data_data"><input type="text" name="edit[literature]" size="60" style="width: 300px;" value="{if $edit.loadtype eq "isbn"}{$isbninfo.title|escape:html}{else}{$row.literature|escape:html}{/if}"></td>
		</tr>
		<tr>
		   <td class="result_detail_data_head">{#page#|escape:htmlall}</td>
		   <td colspan="2" class="result_detail_data_data"><input type="text" name="edit[page]" size="6" style="width: 75px;" value="{$row.page|escape:html}"></td>
		</tr>
		<tr>
		   <td class="result_detail_data_head">{#figure#|escape:htmlall}</td>
		   <td colspan="2" class="result_detail_data_data"><input type="text" name="edit[figure]" size="6" style="width: 75px;"  value="{$row.figure|escape:html}"></td>
		</tr>
		<tr>
		   <td class="result_detail_data_head">{#plate#|escape:htmlall}</td>
		   <td colspan="2" class="result_detail_data_data"><input type="text" name="edit[table]" size="6" style="width: 75px;"  value="{$row.table|escape:html}"></td>
		</tr>
		<tr>
		   <td class="result_detail_data_head">{#isbn#|escape:htmlall}</td>
		   <td colspan="2" class="result_detail_data_data"><input type="text" name="edit[isbn]" size="16" style="width: 150px;" value="{if $edit.loadtype eq "isbn"}{$smarty.post.edit.isbn|escape:html}{else}{$row.isbn|escape:html}{/if}">
		      <!-- 
            ISBN-finder is not compatible with PHP5
		        <input type="button" name="find[isbn]" value="{#search#|escape:htmlall}" onClick="findISBN();">
		      -->
		   </td>
		</tr>
		<tr>
		   <td class="result_detail_data_head">{#exportedto#|escape:htmlall}</td>
		   <td colspan="2" class="result_detail_data_data">
            <input type="checkbox" name="edit[export][prometheus]" value="true" {if $row.exp_prometheus}checked="checked"{/if}>{#prometheus#|escape:html}<br />
            <input type="checkbox" name="edit[export][sid]" value="true" {if $row.exp_sid}checked="checked"{/if}>{#sid#|escape:html}<br />
            <input type="checkbox" name="edit[export][unimedia]" value="true" {if $row.exp_unimedia}checked="checked"{/if}>{#unimedia#|escape:html}<br />
		   </td>
		</tr>
		<tr>
		   <td class="result_detail_data_head">{#metacreator#|escape:htmlall}</td>
		   <td colspan="2" class="result_detail_data_data"><input type="text" name="edit[metacreator]" size="60" style="width: 300px;" value="{$row.metacreator|escape:html}" readonly="readonly"></td>
		</tr>
		<tr>
		   <td class="result_detail_data_head">{#metaeditor#|escape:htmlall}</td>
		   <td colspan="2" class="result_detail_data_data"><input type="text" name="edit[metaeditor]" size="60" style="width: 300px;" value="{$row.metaeditor|escape:html}" readonly="readonly"></td>
		</tr>
		<tr>
		   <td class="result_detail_data_head">{#imagerights#|escape:htmlall}</td>
		   <td colspan="2" class="result_detail_data_data"><input type="text" name="edit[imagerights]" size="60" style="width: 300px;" maxlength="250" value="{$row.imagerights|escape:html}"></td>
		</tr>
		<tr>
		   <td class="result_detail_data_head">{#commentary#|escape:htmlall}</td>
		   <td colspan="2" class="result_detail_data_data"><textarea name="edit[commentary]" cols="45" rows="5" style="width: 300px; height: 80px;" >{$row.commentary|escape:html}</textarea></td>
		</tr>
		<tr>
   		   <td class="result_detail_data_head"><input type="hidden" name="edit[currentuser]" value="{$user.login|escape:html}"></td>
		   <td colspan="2" class="result_detail_data_data">
		   	<input type="button" class="button" name="edit[save]" value="{#save#|escape:htmlall}" onClick="saveImage();">
		   	&nbsp;
		   	<input type="button" class="button" name="edit[cancel]" value="{#cancel#|escape:htmlall}" onClick="showDetail('{$sessionid}','{$result.id}','{$query.remoteCollection}');"></td>
		</tr>

<!-- --------------------------------------------
END default_edit.tpl
--------------------------------------------- -->
