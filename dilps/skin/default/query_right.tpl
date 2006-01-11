<td width="30%" valign="top">
	<!-- right side of query -->
	<table class="query" cellspacing="1" cellpadding="0" >
		{if $user.admin or $user.editor}
		<tr>
			<td class="field_name"><strong>{#mygroup#}</strong></td>
		</tr>
		<tr>
			<td class="queryinputfield">
			{if $query.mygroup eq ""}
				<input class="queryinputfield" type="text" name="query[mygroup]" size="40" readonly="readonly" value=" ({#selecthere#}) " onclick="javascript:window.open('group_select.php?PHPSESSID={$sessionid}&target=mygroup','groupselection2','width=800,height=300,left=10,top=250,dependent=yes');">
			{else}
				<input class="queryinputfield" type="text" name="query[mygroup]" size="40" readonly="readonly" value="{$query.mygroup|escape:html}" onclick="javascript:window.open('group_select.php?PHPSESSID={$sessionid}&target=mygroup','groupselection2','width=800,height=300,left=10,top=250,dependent=yes');">
			{/if}
				<input class="queryinputfield" type="hidden" name="query[mygroupid]" value="{$query.mygroupid|escape:html}">
				<input class="queryinputfield" type="hidden" name="query[mygrouplevel]" value="{$query.mygrouplevel|escape:html}">
			</td>
		</tr>
		<tr>
			<td>
				<input type="button" onClick="clearmygroup();" name="nogroup" value="{#nogroup#|escape:html}">
			</td>
		</tr>
		{else}
		<tr>
			<td class="field_name">
				&nbsp;
			</td>
		</tr>
		<tr>
			<td class="queryinputfield">
				&nbsp;
			</td>
		</tr>
		<tr>
			<td>
				&nbsp;
			</td>
		</tr>
		{/if}
		{if $query.mygroupid neq ""}
		<tr>
			<td class="field_name">
				<a class="navsymbol" href="javascript:;" onclick="javascript:window.open('export_group.php?PHPSESSID={$sessionid}&collectionid={$query.querypiece.0.val.0}&groupid={$query.mygroupid}&groupname={$query.mygroup}','groupexport','width=800,height=420,dependent=yes,scrollbars=yes');">{#exportgroup#}</a>
			</td>
		</tr>
		{/if}
		<tr>
			<td>
			  <br /><br />
			</td>
		</tr>
		<tr>
			<td class="field_name">
				{if $user.admin or $user.editor}
					<a class="navsymbol" href="javascript:;" onclick="javascript:window.open('group_edit.php?PHPSESSID={$sessionid}','groupedit','width=800,height=420,dependent=yes,scrollbars=yes');">{#editgroups#}</a>
				{/if}
			</td>
		</tr>
		<tr>
			<td>
				{if $user.admin or $user.editor}
					<a class="navsymbol" href="javascript:;" onclick="javascript:window.open('add_images.php?PHPSESSID={$sessionid}','imageadd','width=900,height=420,dependent=yes,scrollbars=yes');">{#insertimages#}</a>
				{/if}
			</td>
		</tr>
		<!-- perform actions -->
		<tr>
			<td>
				<input class="queryinputfield" type="hidden" name="action[target]" value="">
				<input class="queryinputfield" type="hidden" name="action[function]" value="">
				<input class="queryinputfield" type="hidden" name="action[cid]" value="">
				<input class="queryinputfield" type="hidden" name="action[gid]" value="">
				<input class="queryinputfield" type="hidden" name="action[imageid]" value="">
				{if $action.target eq "mygroup"}
					{mygroup_change action=$action.function cid=$action.cid gid=$action.gid imageid=$action.imageid result=result sql=sql}
				{/if}
				{if $action.target eq "image"}
					{image_change action=$action.function cid=$action.cid imageid=$action.imageid result=result sql=sql}
				{/if}								
				
				<!-- {$result} -->
				<!-- {$sql} -->
									
			</td>
		</tr>
		<tr>
			<td>
				<br />
			</td>
		</tr>
		<tr>
			<td>
				<br />
			</td>
		</tr>
		<tr>
			<td>
				<br />
			</td>
		</tr>
		<tr>
			<td>
				<input class="queryinputfield" type="hidden" name="logout" value="0">
				<a href="javascript:performlogout();" 
					class="navsymbol">
					<em>{#logout#|escape:html}</em>
				</a>
			</td>
		</tr>
	</table>
	<!-- right side of query - end -->
</td>