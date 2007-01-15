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
BEGIN archaeology_edit.tpl
--------------------------------------------- -->

		<tr>
		   <td class="result_detail_data_head">{#denomination#|escape:htmlall}</td>
		   <td colspan="2" class="result_detail_data_data">
		   		<input type="text" name="edit[title]" size="60" style="width: 400px;" value="{$row.title|escape:html}">
		   	</td>
		</tr>
		<tr>
			<td class="result_detail_data_head">{#category#|escape:htmlall}</td>
			<td colspan="2" class="result_detail_data_data">
				<table cellpadding="0" cellspacing="0" style="margin:0px; padding: 0px; vertical-align: top;">
            		<tr>
            			<td>
            				<textarea class="inactive" name="edit[category]" cols="47" rows="2" style="width: 400px; height: 40px;" readonly="readonly" >{$row.category|escape:html}</textarea> 
            			</td>
            			<td style="vertical-align: top;">
            				<input type="hidden" name="edit[category_fn]" size="60" value="{$row.category_fn|escape:html}">
							&nbsp;[<a onClick="editArchElement( '{$sessionid}', '{$id}', 'category', document.Main.elements );">{#enter#}</a>]
            			</td>
            		</tr>
            	</table>
		   	</td>
		</tr>
		<tr>
			<td class="result_detail_data_head">{#object#|escape:htmlall}</td>
			<td colspan="2" class="result_detail_data_data">
				<input type="hidden" name="edit[object_fn]" size="60" value="{$row.object_fn|escape:html}">
				<input type="text" name="edit[object]" size="60" style="width: 400px;" value="{$row.object|escape:html}">
			</td>
		</tr>
		<tr>
		    <td class="result_detail_data_head">
		    	{#artistname#|escape:htmlall}
		    </td>
            <td colspan="2" class="result_detail_data_data">
            	<table cellpadding="0" cellspacing="0" style="margin:0px; padding: 0px; vertical-align: top;">
            		<tr>
            			<td>
            				<input class="inactive" type="text" name="edit[name1text]" size="60" style="width: 400px;" value="{$row.name1text|escape:html}" style="width: 400px;" readonly="readonly"><br />
							<input type="hidden" name="edit[name1id]" value="{$row.name1id|escape:html}">
							<input type="hidden" name="edit[name2text]" value="{$row.name2text|escape:html}">
							<input type="hidden" name="edit[name2id]" value="{$row.name2id|escape:html}">
            			</td>
            			<td style="vertical-align: top;">
            				&nbsp;[<a onClick="editNameElement( '{$sessionid}', '{$id}', 'name_single', document.Main.elements );">{#enter#}</a>]
            			</td>
            		</tr>
            	</table>
            </td>
		</tr>
		<tr>
			<td class="result_detail_data_head">{#iconography#|escape:htmlall}</td>
		   	<td colspan="2" class="result_detail_data_data">
		   		<table cellpadding="0" cellspacing="0" style="margin:0px; padding: 0px; vertical-align: top;">
            		<tr>
            			<td>
            				<textarea class="inactive" name="edit[iconography]" cols="47" rows="2" readonly="readonly" style="width: 400px; height: 40px;" >{$row.iconography|escape:html}</textarea>
            			</td>
            			<td style="vertical-align: top;">
            				<input type="hidden" name="edit[iconography_fn]" size="60" value="{$row.iconography_fn|escape:htmlall}">
		   					&nbsp;[<a onClick="editArchElement( '{$sessionid}', '{$id}', 'iconography', document.Main.elements );">{#enter#}</a>]
            			</td>
            		</tr>
            	</table>
			</td>
		</tr>
		<tr>
			<td class="result_detail_data_head">{#date#|escape:htmlall}</td>
			<td colspan="2" class="result_detail_data_data">
				<table cellpadding="0" cellspacing="0" style="margin:0px; padding: 0px; vertical-align: top;">
            		<tr>
            			<td>
            				<textarea class="inactive" name="edit[dating_ext]" cols="47" rows="2" readonly="readonly" style="width: 400px; height: 40px;" >{$row.dating_ext|escape:html}</textarea>
            			</td>
            			<td style="vertical-align: top;">
            				<input type="hidden" name="edit[dating]" size="60" value="{$row.dating|escape:html}" style="width: 400px;">
							<input type="hidden" name="edit[dating_ext_fn]" size="60" value="{$row.dating_ext_fn|escape:html}">
							&nbsp;[<a onClick="editArchElement( '{$sessionid}', '{$id}', 'dating_ext', document.Main.elements );">{#enter#}</a>]
            			</td>
            		</tr>
            	</table>
		   	</td>
		</tr>
		<tr>
			<td class="result_detail_data_head">{#material#|escape:htmlall}</td>
			<td colspan="2" class="result_detail_data_data">
				<table cellpadding="0" cellspacing="0" style="margin:0px; padding: 0px; vertical-align: top;">
            		<tr>
            			<td>
            				<textarea class="inactive" name="edit[material_ext]" cols="47" rows="2" readonly="readonly" style="width: 400px; height: 40px;" >{$row.material_ext|escape:html}</textarea>
            			</td>
            			<td style="vertical-align: top;">
            				<input type="hidden" name="edit[material_ext_fn]" size="60" value="{$row.material_ext_fn|escape:html}">
							&nbsp;[<a onClick="editArchElement( '{$sessionid}', '{$id}', 'material_ext', document.Main.elements );">{#enter#}</a>]
            			</td>
            		</tr>
            	</table>
			</td>
		</tr>
		<tr>
		   <td class="result_detail_data_head">{#technics#|escape:htmlall}</td>
		   <td colspan="2" class="result_detail_data_data"><input type="text" name="edit[technique]" size="60" value="{$row.technique|escape:html}" style="width: 400px;" ></td>
		</tr>
		<tr>
		   <td class="result_detail_data_head">{#format#|escape:htmlall}</td>
		   <td colspan="2" class="result_detail_data_data"><input type="text" name="edit[format]" size="60" value="{$row.format|escape:html}" style="width: 400px;" ></td>
		</tr>
		<tr>
		    <td class="result_detail_data_head">
		    	{#city#|escape:htmlall}
		    </td>
            <td colspan="2" rowspan="2" class="result_detail_data_data">
            	<table cellpadding="0" cellspacing="0" style="margin:0px; padding: 0px; vertical-align: top;">
            		<tr>
            			<td>
            				<input class="inactive" type="text" name="edit[city]" size="60" value="{$row.city|escape:html}" style="width: 400px;" readonly="readonly"><br />
						   	<input class="inactive" type="text" name="edit[institution]" size="60" value="{$row.institution|escape:html}" style="width: 400px;" readonly="readonly">
            			</td>
            			<td style="vertical-align: top;">
            				&nbsp;[<a onClick="editElement( '{$sessionid}', '{$id}', 'loc', '{$row.name|escape:htmlall}' );">{#enter#}</a>]
            			</td>
            		</tr>
            	</table>
            </td>
		</tr>
		<tr>
			<td class="result_detail_data_head">
		    	{#institution#|escape:htmlall}
		    </td>
		</tr>
		<tr>
		   <td class="result_detail_data_head">{#src#|escape:htmlall}</td>
		   <td colspan="2" class="result_detail_data_data"><input type="text" name="edit[literature]" size="60" style="width: 400px;" value="{$row.literature|escape:html}"></td>
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
		   <td colspan="2" class="result_detail_data_data"><input type="text" name="edit[isbn]" size="16" style="width: 150px;"  value="{$row.isbn|escape:html}"></td>
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
		   <td colspan="2" class="result_detail_data_data"><input type="text" name="edit[metacreator]" size="60" value="{$row.metacreator|escape:html}" style="width: 400px;" readonly="readonly"></td>
		</tr>
		<tr>
		   <td class="result_detail_data_head">{#metaeditor#|escape:htmlall}</td>
		   <td colspan="2" class="result_detail_data_data"><input type="text" name="edit[metaeditor]" size="60" value="{$row.metaeditor|escape:html}" style="width: 400px;" readonly="readonly"></td>
		</tr>
		<tr>
		   <td class="result_detail_data_head">{#imagerights#|escape:htmlall}</td>
		   <td colspan="2" class="result_detail_data_data"><input type="text" name="edit[imagerights]" size="60" maxlength="250" value="{$row.imagerights|escape:html}" style="width: 400px;"></td>
		</tr>
		<tr>
		   <td class="result_detail_data_head">{#commentary#|escape:htmlall}</td>
		   <td colspan="2" class="result_detail_data_data"><textarea name="edit[commentary]" cols="45" rows="5" style="width: 400px; height: 80px;" >{$row.commentary|escape:html}</textarea></td>
		</tr>
		<tr>
		   <td class="result_detail_data_head"><input type="hidden" name="edit[currentuser]" value="{$user.login|escape:html}"></td>
		   <td colspan="2" class="result_detail_data_data"><input type="button" name="edit[save]" value="{#save#|escape:htmlall}" onClick="saveImage();"></td>
		</tr>

<!-- --------------------------------------------
END archaeology_edit.tpl
--------------------------------------------- -->
