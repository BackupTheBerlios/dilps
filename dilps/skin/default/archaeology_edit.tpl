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
							&nbsp;[<a onClick="editArchaeologyElement( '{$sessionid}', '{$id}', 'category');">{#enter#}</a>]
            			</td>
            		</tr>
            	</table>
		   	</td>
		</tr>
		<tr>
			<td class="result_detail_data_head">{#object#|escape:htmlall}</td>
			<td colspan="2" class="result_detail_data_data">
				<table cellpadding="0" cellspacing="0" style="margin:0px; padding: 0px; vertical-align: top;">
            		<tr>
            			<td>
            				<table cellpadding="0" cellspacing="0" style="margin:0px; padding: 0px; vertical-align: top; empty-cells: hide;">
            					<tr>
            						<td class="result_detail_data_head2">
            							{#subcategories#|escape:htmlall}
            						</td>
            					</tr>
								<tr>
									<td class="result_detail_data_subhead">
										{#culture#|escape:htmall}
									</td>
								</tr>
								<tr>
									<td style="line-height: 0;">
										<textarea class="inactive" name="edit[obj_culture]" cols="47" rows="2" {if $row.obj_culture neq ""} style="width: 400px; height: 40px;" {else} style="width: 400px; height: 0px; visibility: hidden" {/if} readonly="readonly" >{$row.obj_culture|escape:html}</textarea>
										<input type="hidden" name="edit[obj_culture_fn]" size="40" value="{$row.obj_culture_fn|escape:html}">
									</td>
								</tr>
								<tr>
									<td class="result_detail_data_subhead">
										{#culthistory#|escape:htmall}
									</td>
								</tr>
								<tr>
									<td style="line-height: 0;">
										<textarea class="inactive" name="edit[obj_culthistory]" cols="47" rows="2" {if $row.obj_culthistory neq ""} style="width: 400px; height: 40px;" {else} style="width: 400px; height: 0px; visibility: hidden" {/if} readonly="readonly" >{$row.obj_culthistory|escape:html}</textarea>
										<input type="hidden" name="edit[obj_culthistory_fn]" size="40" value="{$row.obj_culthistory_fn|escape:html}">
									</td>
								</tr>
								<tr>
									<td class="result_detail_data_subhead">
										{#topography#|escape:htmall}
									</td>
								</tr>
								<tr>
									<td style="line-height: 0;">
										<textarea class="inactive" name="edit[obj_topography]" cols="47" rows="2" {if $row.obj_topography neq ""} style="width: 400px; height: 40px;" {else} style="width: 400px; height: 0px; visibility: hidden" {/if} readonly="readonly" >{$row.obj_topography|escape:html}</textarea>
										<input type="hidden" name="edit[obj_topography_fn]" size="40" value="{$row.obj_topography_fn|escape:html}">
									</td>
								</tr>
								<tr>
									<td class="result_detail_data_subhead">
										{#architecture#|escape:htmall}
									</td>
								</tr>
									<tr>
										<td class="result_detail_data_sub_subhead">
											{#structelems#|escape:htmall}
										</td>
									</tr>
									<tr>
										<td style="text-align: right; line-height: 0;">
											<textarea class="inactive" name="edit[obj_arch_structelems]" cols="47" rows="2" {if $row.obj_arch_structelems neq ""} style="width: 380px; height: 40px;" {else} style="width: 380px; height: 0px; visibility: hidden" {/if} readonly="readonly" >{$row.obj_arch_structelems|escape:html}</textarea>
											<input type="hidden" name="edit[obj_arch_structelems_fn]" size="40" value="{$row.obj_arch_structelems_fn|escape:html}">
										</td>
									</tr>
									<tr>
										<td class="result_detail_data_sub_subhead">
											{#tenement#|escape:htmall}
										</td>
									</tr>
									<tr>
										<td style="text-align: right; line-height: 0;">
											<textarea class="inactive" name="edit[obj_arch_tenement]" cols="47" rows="2" {if $row.obj_arch_tenement neq ""} style="width: 380px; height: 40px;" {else} style="width: 380px; height: 0px; visibility: hidden" {/if} readonly="readonly" >{$row.obj_arch_tenement|escape:html}</textarea>
											<input type="hidden" name="edit[obj_arch_tenement_fn]" size="40" value="{$row.obj_arch_tenement_fn|escape:html}">
										</td>
									</tr>
									<tr>
										<td class="result_detail_data_sub_subhead">
											{#funcbuild#|escape:htmall}
										</td>
									</tr>
									<tr>
										<td style="text-align: right; line-height: 0;">
											<textarea class="inactive" name="edit[obj_arch_funcbuild]" cols="47" rows="2" {if $row.obj_arch_funcbuild neq ""} style="width: 380px; height: 40px;" {else} style="width: 380px; height: 0px; visibility: hidden" {/if} readonly="readonly" >{$row.obj_arch_funcbuild|escape:html}</textarea>
											<input type="hidden" name="edit[obj_arch_funcbuild_fn]" size="40" value="{$row.obj_arch_funcbuild_fn|escape:html}">
										</td>
									</tr>
									<tr>
										<td class="result_detail_data_sub_subhead">
											{#amusement#|escape:htmall}
										</td>
									</tr>
									<tr>
										<td style="text-align: right; line-height: 0;">
											<textarea class="inactive" name="edit[obj_arch_amusement]" cols="47" rows="2" {if $row.obj_arch_amusement neq ""} style="width: 380px; height: 40px;" {else} style="width: 380px; height: 0px; visibility: hidden" {/if} readonly="readonly" >{$row.obj_arch_amusement|escape:html}</textarea>
											<input type="hidden" name="edit[obj_arch_amusement_fn]" size="40" value="{$row.obj_arch_amusement_fn|escape:html}">
										</td>
									</tr>
									<tr>
										<td class="result_detail_data_sub_subhead">
											{#economy#|escape:htmall}
										</td>
									</tr>
									<tr>
										<td style="text-align: right; line-height: 0;">
											<textarea class="inactive" name="edit[obj_arch_economy]" cols="47" rows="2" {if $row.obj_arch_economy neq ""} style="width: 380px; height: 40px;" {else} style="width: 380px; height: 0px; visibility: hidden" {/if} readonly="readonly" >{$row.obj_arch_economy|escape:html}</textarea>
											<input type="hidden" name="edit[obj_arch_economy_fn]" size="40" value="{$row.obj_arch_economy_fn|escape:html}">
										</td>
									</tr>
									<tr>
										<td class="result_detail_data_sub_subhead">
											{#sacral#|escape:htmall}
										</td>
									</tr>
									<tr>
										<td style="text-align: right; line-height: 0;">
											<textarea class="inactive" name="edit[obj_arch_sacral]" cols="47" rows="2" {if $row.obj_arch_sacral neq ""} style="width: 380px; height: 40px;" {else} style="width: 380px; height: 0px; visibility: hidden" {/if} readonly="readonly" >{$row.obj_arch_sacral|escape:html}</textarea>
											<input type="hidden" name="edit[obj_arch_sacral_fn]" size="40" value="{$row.obj_arch_sacral_fn|escape:html}">
										</td>
									</tr>
									<tr>
										<td class="result_detail_data_sub_subhead">
											{#sepulchre#|escape:htmall}
										</td>
									</tr>
									<tr>
										<td style="text-align: right; line-height: 0;">
											<textarea class="inactive" name="edit[obj_arch_sepulchre]" cols="47" rows="2" {if $row.obj_arch_sepulchre neq ""} style="width: 380px; height: 40px;" {else} style="width: 380px; height: 0px; visibility: hidden" {/if} readonly="readonly" >{$row.obj_arch_sepulchre|escape:html}</textarea>
											<input type="hidden" name="edit[obj_arch_sepulchre_fn]" size="40" value="{$row.obj_arch_sepulchre_fn|escape:html}">
										</td>
									</tr>
									<tr>
										<td class="result_detail_data_sub_subhead">
											{#military#|escape:htmall}
										</td>
									</tr>
									<tr>
										<td style="text-align: right; line-height: 0;">
											<textarea class="inactive" name="edit[obj_arch_military]" cols="47" rows="2" {if $row.obj_arch_military neq ""} style="width: 380px; height: 40px;" {else} style="width: 380px; height: 0px; visibility: hidden" {/if} readonly="readonly" >{$row.obj_arch_military|escape:html}</textarea>
											<input type="hidden" name="edit[obj_arch_military_fn]" size="40" value="{$row.obj_arch_military_fn|escape:html}">
										</td>
									</tr>
								<tr>
									<td class="result_detail_data_subhead">
										{#mosaic#|escape:htmall}
									</td>
								</tr>
								<tr>
									<td style="line-height: 0;">
										<textarea class="inactive" name="edit[obj_mosaic]" cols="47" rows="2" {if $row.obj_mosaic neq ""} style="width: 400px; height: 40px;" {else} style="width: 400px; height: 0px; visibility: hidden" {/if} readonly="readonly" >{$row.obj_mosaic|escape:html}</textarea>
										<input type="hidden" name="edit[obj_mosaic_fn]" size="40" value="{$row.obj_mosaic_fn|escape:html}">
									</td>
								</tr>
								<tr>
									<td class="result_detail_data_subhead">
										{#painting#|escape:htmall}
									</td>
								</tr>
								<tr>
									<td style="line-height: 0;">
										<textarea class="inactive" name="edit[obj_painting]" cols="47" rows="2" {if $row.obj_painting neq ""} style="width: 400px; height: 40px;" {else} style="width: 400px; height: 0px; visibility: hidden" {/if} readonly="readonly" >{$row.obj_painting|escape:html}</textarea>
										<input type="hidden" name="edit[obj_painting_fn]" size="40" value="{$row.obj_painting_fn|escape:html}">
									</td>
								</tr>
								<tr>
									<td class="result_detail_data_subhead">
										{#sculpture#|escape:htmall}
									</td>
								</tr>
								<tr>
									<td style="line-height: 0;">
										<textarea class="inactive" name="edit[obj_sculpture]" cols="47" rows="2" {if $row.obj_sculpture neq ""} style="width: 400px; height: 40px;" {else} style="width: 400px; height: 0px; visibility: hidden" {/if} readonly="readonly" >{$row.obj_sculpture|escape:html}</textarea>
										<input type="hidden" name="edit[obj_sculpture_fn]" size="40" value="{$row.obj_sculpture_fn|escape:html}">
									</td>
								</tr>
								<tr>
									<td class="result_detail_data_subhead">
										{#portrait#|escape:htmall}
									</td>
								</tr>
								<tr>
									<td style="line-height: 0;">
										<textarea class="inactive" name="edit[obj_portrait]" cols="47" rows="2" {if $row.obj_portrait neq ""} style="width: 400px; height: 40px;" {else} style="width: 400px; height: 0px; visibility: hidden" {/if} readonly="readonly" >{$row.obj_portrait|escape:html}</textarea>
										<input type="hidden" name="edit[obj_portrait_fn]" size="40" value="{$row.obj_portrait_fn|escape:html}">
									</td>
								</tr>
								<tr>
									<td class="result_detail_data_subhead">
										{#ceramic#|escape:htmall}
									</td>
								</tr>
									<tr>
										<td class="result_detail_data_sub_subhead">
											{#vascularforms#|escape:htmall}
										</td>
									</tr>
									<tr>
										<td style="text-align: right; line-height: 0;">
											<textarea class="inactive" name="edit[obj_ceramic_vascularforms]" cols="47" rows="2" {if $row.obj_ceramic_vascularforms neq ""} style="width: 380px; height: 40px;" {else} style="width: 380px; height: 0px; visibility: hidden" {/if} readonly="readonly" >{$row.obj_ceramic_vascularforms|escape:html}</textarea>
											<input type="hidden" name="edit[obj_ceramic_vascularforms_fn]" size="40" value="{$row.obj_ceramic_vascularforms_fn|escape:html}">
										</td>
									</tr>
									<tr>
										<td class="result_detail_data_sub_subhead">
											{#ac_groups#|escape:htmall}
										</td>
									</tr>
									<tr>
										<td style="text-align: right; line-height: 0;">
											<textarea class="inactive" name="edit[obj_ceramic_groups]" cols="47" rows="2" {if $row.obj_ceramic_groups neq ""} style="width: 380px; height: 40px;" {else} style="width: 380px; height: 0px; visibility: hidden" {/if} readonly="readonly" >{$row.obj_ceramic_groups|escape:html}</textarea>
											<input type="hidden" name="edit[obj_ceramic_groups_fn]" size="40" value="{$row.obj_ceramic_groups_fn|escape:html}">
										</td>
									</tr>
								<tr>
									<td class="result_detail_data_subhead">
										{#toreutics#|escape:htmall}
									</td>
								</tr>
								<tr>
									<td style="line-height: 0;">
										<textarea class="inactive" name="edit[obj_toreutics]" cols="47" rows="2" {if $row.obj_toreutics neq ""} style="width: 400px; height: 40px;" {else} style="width: 400px; height: 0px; visibility: hidden" {/if} readonly="readonly" >{$row.obj_toreutics|escape:html}</textarea>
										<input type="hidden" name="edit[obj_toreutics_fn]" size="40" value="{$row.obj_toreutics_fn|escape:html}">
									</td>
								</tr>
								<tr>
									<td class="result_detail_data_subhead">
										{#jewellery#|escape:htmall}
									</td>
								</tr>
								<tr>
									<td style="line-height: 0;">
										<textarea class="inactive" name="edit[obj_jewellery]" cols="47" rows="2" {if $row.obj_jewellery neq ""} style="width: 400px; height: 40px;" {else} style="width: 400px; height: 0px; visibility: hidden" {/if} readonly="readonly" >{$row.obj_jewellery|escape:html}</textarea>
										<input type="hidden" name="edit[obj_jewellery_fn]" size="40" value="{$row.obj_jewellery_fn|escape:html}">
									</td>
								</tr>
								<tr>
									<td class="result_detail_data_subhead">
										{#glass#|escape:htmall}
									</td>
								</tr>
								<tr>
									<td style="line-height: 0;">
										<textarea class="inactive" name="edit[obj_glass]" cols="47" rows="2" {if $row.obj_glass neq ""} style="width: 400px; height: 40px;" {else} style="width: 400px; height: 0px; visibility: hidden" {/if} readonly="readonly" >{$row.obj_glass|escape:html}</textarea>
										<input type="hidden" name="edit[obj_glass_fn]" size="40" value="{$row.obj_glass_fn|escape:html}">
									</td>
								</tr>
								<tr>
									<td class="result_detail_data_subhead">
										{#glyptics#|escape:htmall}
									</td>
								</tr>
								<tr>
									<td style="line-height: 0;">
										<textarea class="inactive" name="edit[obj_glyptics]" cols="47" rows="2" {if $row.obj_glyptics neq ""} style="width: 400px; height: 40px;" {else} style="width: 400px; height: 0px; visibility: hidden" {/if} readonly="readonly" >{$row.obj_glyptics|escape:html}</textarea>
										<input type="hidden" name="edit[obj_glyptics_fn]" size="40" value="{$row.obj_glyptics_fn|escape:html}">
									</td>
								</tr>
								<tr>
									<td class="result_detail_data_subhead">
										{#numismatics#|escape:htmall}
									</td>
								</tr>
								<tr>
									<td style="line-height: 0;">
										<textarea class="inactive" name="edit[obj_numismatics]" cols="47" rows="2" {if $row.obj_numismatics neq ""} style="width: 400px; height: 40px;" {else} style="width: 400px; height: 0px; visibility: hidden" {/if} readonly="readonly" >{$row.obj_numismatics|escape:html}</textarea>
										<input type="hidden" name="edit[obj_numismatics_fn]" size="40" value="{$row.obj_numismatics_fn|escape:html}">
									</td>
								</tr>
								<tr>
									<td class="result_detail_data_subhead">
										{#textiles#|escape:htmall}
									</td>
								</tr>
								<tr>
									<td style="line-height: 0;">
										<textarea class="inactive" name="edit[obj_textiles]" cols="47" rows="2" {if $row.obj_textiles neq ""} style="width: 400px; height: 40px;" {else} style="width: 400px; height: 0px; visibility: hidden" {/if} readonly="readonly" >{$row.obj_textiles|escape:html}</textarea>
										<input type="hidden" name="edit[obj_textiles_fn]" size="40" value="{$row.obj_textiles_fn|escape:html}">
									</td>
								</tr>
								<tr>
									<td class="result_detail_data_subhead">
										{#misc#|escape:htmall}
									</td>
								</tr>
								<tr>
									<td style="line-height: 0;">
										<textarea class="inactive" name="edit[obj_misc]" cols="47" rows="2" {if $row.obj_misc neq ""} style="width: 400px; height: 40px;" {else} style="width: 400px; height: 0px; visibility: hidden" {/if} readonly="readonly" >{$row.obj_misc|escape:html}</textarea>
										<input type="hidden" name="edit[obj_misc_fn]" size="40" value="{$row.obj_misc_fn|escape:html}">
									</td>
								</tr>
								<tr>
									<td class="result_detail_data_subhead">
										{#epigraphy#|escape:htmall}
									</td>
								</tr>
								<tr>
									<td style="line-height: 0;">
										<textarea class="inactive" name="edit[obj_epigraphy]" cols="47" rows="2" {if $row.obj_epigraphy neq ""} style="width: 400px; height: 40px;" {else} style="width: 400px; height: 0px; visibility: hidden" {/if} readonly="readonly" >{$row.obj_epigraphy|escape:html}</textarea>
										<input type="hidden" name="edit[obj_epigraphy_fn]" size="40" value="{$row.obj_epigraphy_fn|escape:html}">
									</td>
								</tr>
								<tr>
									<td class="result_detail_data_subhead">
										{#ac_methods#|escape:htmall}
									</td>
								</tr>
								<tr>
									<td style="line-height: 0;">
										<textarea class="inactive" name="edit[obj_methods]" cols="47" rows="2" {if $row.obj_methods neq ""} style="width: 400px; height: 40px;" {else} style="width: 400px; height: 0px; visibility: hidden" {/if} readonly="readonly" >{$row.obj_methods|escape:html}</textarea>
										<input type="hidden" name="edit[obj_methods_fn]" size="40" value="{$row.obj_methods_fn|escape:html}">
									</td>
								</tr>
								<tr>
									<td class="result_detail_data_subhead">
										{#reception#|escape:htmall}
									</td>
								</tr>
								<tr>
									<td style="line-height: 0;">
										<textarea class="inactive" name="edit[obj_reception]" cols="47" rows="2" {if $row.obj_reception neq ""} style="width: 400px; height: 40px;" {else} style="width: 400px; height: 0px; visibility: hidden" {/if} readonly="readonly" >{$row.obj_reception|escape:html}</textarea>
										<input type="hidden" name="edit[obj_reception_fn]" size="40" value="{$row.obj_reception_fn|escape:html}">
									</td>
								</tr>
			            	</table>
            			</td>
            			<td style="vertical-align: top;">
							&nbsp;[<a onClick="editArchaeologyElement( '{$sessionid}', '{$id}', 'obj');">{#enter#}</a>]
            			</td>
            		</tr>
            	</table>
			</td>
		</tr>
		<!--
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
		-->
		<tr>
		   <td class="result_detail_data_head">{#artistname#|escape:htmlall}</td>
		   <td colspan="2" class="result_detail_data_data">
		   		<input type="hidden" name="edit[name1id]" value="0">
		   		<input type="text" name="edit[name1text]" size="60" style="width: 400px;" value="{$row.name1text|escape:html}" style="width: 400px;"><br />
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
		   					&nbsp;[<a onClick="editArchaeologyElement( '{$sessionid}', '{$id}', 'iconography');">{#enter#}</a>]
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
							&nbsp;[<a onClick="editArchaeologyElement( '{$sessionid}', '{$id}', 'dating_ext');">{#enter#}</a>]
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
							&nbsp;[<a onClick="editArchaeologyElement( '{$sessionid}', '{$id}', 'material_ext');">{#enter#}</a>]
            			</td>
            		</tr>
            	</table>
			</td>
		</tr>
		<tr>
		   <td class="result_detail_data_head">{#location_ext#|escape:htmlall}</td>
		   <td colspan="2" class="result_detail_data_data"><input type="text" name="edit[location_ext]" size="60" style="width: 400px;" value="{$row.location_ext|escape:html}"></td>
		</tr>
		<!--
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
		-->
		<tr>
		   <td class="result_detail_data_head">
		    	{#city#|escape:htmlall}
		    </td>
		   <td colspan="2" class="result_detail_data_data">
   				<input type="text" name="edit[city]" size="60" value="{$row.city|escape:html}" style="width: 400px;"><br />
		   </td>
		</tr>
		<tr>
		   <td class="result_detail_data_head">
		    	{#institution#|escape:htmlall}
		    </td>
		   <td colspan="2" class="result_detail_data_data">
   				<input type="text" name="edit[institution]" size="60" value="{$row.institution|escape:html}" style="width: 400px;">
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
		   <td colspan="2" class="result_detail_data_data">
		   	<input type="button" class="button" name="edit[save]" value="{#save#|escape:htmlall}" onClick="saveImage();">
		   	&nbsp;
		   	<input type="button" class="button" name="edit[cancel]" value="{#cancel#|escape:htmlall}" onClick="showDetail('{$sessionid}','{$result.id}','{$query.remoteCollection}');"></td>
		</tr>

<!-- --------------------------------------------
END archaeology_edit.tpl
--------------------------------------------- -->
