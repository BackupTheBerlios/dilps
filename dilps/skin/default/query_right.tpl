<td width="30%" valign="top">
	<!-- right side of query -->
	<table class="query" cellspacing="1" cellpadding="0" >
		<tr>
			<td>
				<strong>{#user#|escape:htmlall}</strong>
			</td>
		</tr>
		<tr>
			<td style="padding-top: 1px;">
				<table class="query" cellpadding="0" cellspacing="0" style="width: 90%;">
					<tr>
						<td style="width: 55%; text-align: left;">							
							{if $user.login neq ""}
								<em>{$user.login|escape:htmlall}</em>
							{else}
								&nbsp;
							{/if}
						</td>
						<td style="width: 45%; text-align: right;">
							<button type="button" class="actionbutton" onclick="performlogout();" title="{#logout#|escape:html}">{#logout#|escape:html}</button>
							<input class="queryinputfield" type="hidden" name="logout" value="0">
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td style="height: 48px;">
				&nbsp;
			</td>
		</tr>
		<tr>
			<td class="field_name"><strong>{#mygroup#|escape:htmlall}</strong></td>
		</tr>
		<tr>
			<td class="queryinputfield">
				<table class="query" cellpadding="0" cellspacing="0" style="width: 90%;">
					<tr>
						<td style="width: 90%; text-align: left;">
							{if $query.mygroup eq ""}
								<input class="queryinputfield" type="text" name="query[mygroup]" size="40" readonly="readonly" value=" ({#selecthere#|escape:htmlall}) " onclick="editGroupSelection('{$sessionid}','mygroup','{$query.mygrouplastpath}','{$query.mygroupid}');">
							{else}
								<input class="queryinputfield" type="text" name="query[mygroup]" size="40" readonly="readonly" value="{$query.mygroup|escape:html}" onclick="editGroupSelection('{$sessionid}','mygroup','{$query.mygrouplastpath}','{$query.mygroupid}');">
							{/if}
			
							<input class="queryinputfield" type="hidden" name="query[mygroupid]" value="{$query.mygroupid|escape:html}">
							<input class="queryinputfield" type="hidden" name="query[mygroupowner]" value="{$query.mygroupowner|escape:html}">
							<input class="queryinputfield" type="hidden" name="query[mygrouplastpath]" value="{$query.mygrouplastpath|escape:html}">
						</td>
						<td style="width: 10%; text-align: right;">
							{if $query.mygroup neq ""}
								<button type="button" class="actionbutton2" onclick="clearmygroup();" title="{#nogroup#|escape:htmall}"><img src="clear.png" style="width: 12px; height: 12px;" /></button>			
							{else}
								&nbsp;
							{/if}
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td style="padding-top: 2px;">
				{if $query.mygroupid neq ""}
					<table class="query" cellpadding="0" cellspacing="0" style="width: 90%;">
						<tr>
							<td style="width: 55%; text-align: left;">
								<button type="button" class="actionbutton" onclick="updatemygroup();" title="{#applychanges#|escape:htmlall}">{#applychanges#|escape:htmall}</button>							
							</td>
							<td style="width: 45%; text-align: right;">
								<button type="button" class="actionbutton" onclick="exportGroup('{$sessionid}','{$query.mygroupid}','{$query.mygroup}');" title="{#exportgroup#}">{#exportgroup#}</button>
							</td>
						</tr>
					</table>
				{else}
					&nbsp;
				{/if}

			</td>
		</tr>
		<tr>
			<td>
				<!-- we insert the nodes for changes in group membership here -->
				<div id="mygroupchanges" style="visibility: hidden;"></div>
			</td>
		</tr>
		<tr>
			<td>
				<iframe src="session_control.php?PHPSESSID={$sessionid}" id="sessioncontrol" name="sessioncontrol" width="350px" height="0px" marginheight="0" marginwidth="0" border="0" align="left" scrolling="No" style="visibility: hidden;">
  					<p>Error loading session control</p>
				</iframe>
			</td>
		</tr>
		<tr>
			{if $user.insertimages or $user.editgroups}
				<td class="field_name">
					<strong>{#administration#|escape:htmlall}</strong>
				</td>
			{else}
				<td class="field_name">
					&nbsp;
				</td>
			{/if}
		</tr>
		<tr>
			<td style="padding-top: 1px;">
				<table class="query" cellpadding="0" cellspacing="0" style="width: 90%;">
					<tr>
						<td style="width: 55%; text-align: left;">
							<button type="button" class="actionbutton" onclick="editGroups('{$sessionid}');" title="{#editgroups#|escape:htmlall}">{#editgroups#|escape:htmlall}</button>						
						</td>
						<td style="width: 45%; text-align: right;">
							{if $user.insertimages}
								<button type="button" class="actionbutton" onclick="addImages('{$sessionid}');" title="{#insertimages#|escape:htmlall}">{#insertimages#|escape:htmlall}</button>
							{else}
								&nbsp;
							{/if}
						</td>
					</tr>
				</table>
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
					{if $mygroup neq ""}
						{mygroup_change action=$action.function gid=$action.gid changes=$mygroup result=result sql=sql}
					{/if}
				{/if}
				{if $action.target eq "image"}
					{image_change action=$action.function cid=$action.cid imageid=$action.imageid result=result sql=sql}
				{/if}

				<!-- {$result} -->
				<!-- {$sql} -->

			</td>
		</tr>
	</table>
	<!-- right side of query - end -->
</td>