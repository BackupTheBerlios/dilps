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
<!-- =================================================
BEGIN image_add.tpl
================================================= -->
{if $config.utf8 eq "true"}
	{config_load file="`$config.skinBase``$config.skin`/`$config.language`/easy_query.conf.utf8"}
{else}
	{config_load file="`$config.skinBase``$config.skin`/`$config.language`/easy_query.conf"}
{/if}

<html>
<head>
<meta name="robots" content="index,follow">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="cache-control" content="no-cache">
<meta name="keywords" content="Bilddatenbanksystem, Bilddatenbank, Diathek, digitalisiert">

{if $config.utf8 eq 'true'}
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
{else}
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
{/if}
<meta http-equiv="Content-Script-Type" content="text/javascript">
<meta http-equiv="Content-Style-Type" content="text/css">
<meta name="author" content="juergen enge, thorsten wuebbena, sebastian doeweling">
<meta name="date" content="2003-01-23">
<link rel="shortcut icon" href="favicon.ico">
<script src="dilps.lib.js" type="text/javascript"></script>
<title>. : DILPS : .</title>
<script type="text/javascript">
{literal}
function cleargroup1() {
	document.forms["Main"].elements["query[group1]"].value = '';
	document.forms["Main"].elements["query[group1id]"].value = '';
	document.forms["Main"].elements["query[group1owner]"].value = '';
}

function cleargroup2() {
	document.forms["Main"].elements["query[group2]"].value = '';
	document.forms["Main"].elements["query[group2id]"].value = '';
	document.forms["Main"].elements["query[group2owner]"].value = '';
}

function cleargroup3() {
	document.forms["Main"].elements["query[group3]"].value = '';
	document.forms["Main"].elements["query[group3id]"].value = '';
	document.forms["Main"].elements["query[group3owner]"].value = '';
}

function postletFinished(){
  {/literal}
	var finishedMessageString = "<p>{#upload_errors#}:</p>";
	{literal}
	var failedfiles = document.postlet.javascriptGetFailedFiles();
	if (failedfiles != null){
		if (failedfiles.length >0)
		  {/literal}
			finishedMessageString += "<ul>{#not_uploaded#}:";
			{literal}
			
		for (var i=0; i<failedfiles.length; i++)
			finishedMessageString += "<li>"+failedfiles[i]+"</li>";
		if (failedfiles.length >0)
			finishedMessageString += "</ul>";
	}
	else
	{
	  {/literal}
	  finishedMessageString += "<ul>{#none#}</ul>";
	  {literal}
	}
	
	document.getElementById("finishedmessage").innerHTML=finishedMessageString;
	document.getElementById("finishedmessage").style.display="block";
          //window.location="http://www.postlet.com/success/";
	return true;
}
{/literal}

</script>

<link rel="stylesheet" type="text/css" href="css.php">
</head>
<body class="main" style="width: 100%; height: 100%;">
	<form name="Main" action="{$SCRIPT_NAME}" method="POST" enctype="multipart/form-data">
	<input type="hidden" name="PHPSESSID" value="{$sessionid}">

	<table class="header" style="width: 100%; height: 100%; vertical-align: top;">
	{if $query.process eq "" or $query.process eq "0"}
		<tr>
		   <td class="queryinputfieldtext">
		      {#collection#}
		   </td>
		   <td>
		      <select class="queryselectfield" name="query[collectionid]">
					{collection_list var=collections sql=sql}
					<!-- {$sql} -->
					{foreach from=$collections item=row}
						<option value="{$row.collectionid}"{if $query.collection eq "" and $config.defaultcollection eq $row.collectionid} selected{elseif $query.collection eq $row.collectionid} selected{/if}>{$row.name|escape:htmlall}</option>
					{/foreach}
				</select>
		   </td>
		</tr>
		<tr>
		   <td class="queryinputfieldtext">
		      {#type#}
		   </td>
		   <td>
		      <select class="queryselectfield" name="query[type]">
					{type_list var="types" sql="sql"}
					<!-- {$sql} -->	
			        {foreach from=`$types` item=type}
			            <option value="{$type.name|escape:html}"{if $config.defaulttype eq $type.name} selected{/if}>{$type.print_name|escape:htmlall}</option>
			        {/foreach}
				</select>
		   </td>
		</tr>
		<tr>
			<td class="queryinputfieldtext">
		  		{#group#|escape:htmlall} 1
			</td>
			<td class="queryinputfield">
				{if $query.group1 eq ""}
					<input class="queryinputfield" type="text" name="query[group1]" size="40" readonly="readonly" value=" ({#selecthere#|escape:htmlall}) " onclick="editGroupSelection('{$sessionid}','img_group_1','{$query.group1lastpath}','{$query.group1id}');">
				{else}
					<input class="queryinputfield" type="text" name="query[group1]" size="40" readonly="readonly" value="{$query.mygroup|escape:html}" onclick="editGroupSelection('{$sessionid}','img_group_1','{$query.group1lastpath}','{$query.group1id}');">
				{/if}

				<input class="queryinputfield" type="hidden" name="query[group1id]" value="{$query.group1id|escape:html}">
				<input class="queryinputfield" type="hidden" name="query[group1owner]" value="{$query.group1owner|escape:html}">
				<input class="queryinputfield" type="hidden" name="query[group1lastpath]" value="{$query.group1lastpath|escape:html}">
			
				<input type="button" onClick="cleargroup1();" name="nogroup1" value="{#nogroup#|escape:html}">
			</td>
		</tr>
		<tr>
			<td class="queryinputfieldtext">
		  		{#group#|escape:htmlall} 2
			</td>
			<td class="queryinputfield">
				{if $query.group2 eq ""}
					<input class="queryinputfield" type="text" name="query[group2]" size="40" readonly="readonly" value=" ({#selecthere#|escape:htmlall}) " onclick="editGroupSelection('{$sessionid}','img_group_2','{$query.group2lastpath}','{$query.group2id}');">
				{else}
					<input class="queryinputfield" type="text" name="query[group2]" size="40" readonly="readonly" value="{$query.mygroup|escape:html}" onclick="editGroupSelection('{$sessionid}','img_group_2','{$query.group2lastpath}','{$query.group2id}');">
				{/if}

				<input class="queryinputfield" type="hidden" name="query[group2id]" value="{$query.group2id|escape:html}">
				<input class="queryinputfield" type="hidden" name="query[group2owner]" value="{$query.group2owner|escape:html}">
				<input class="queryinputfield" type="hidden" name="query[group2lastpath]" value="{$query.group2lastpath|escape:html}">
			
				<input type="button" onClick="cleargroup2();" name="nogroup2" value="{#nogroup#|escape:html}">
			</td>
		</tr>
		<tr>
			<td class="queryinputfieldtext">
		  		{#group#|escape:htmlall} 3
			</td>
			<td class="queryinputfield">
				{if $query.group3 eq ""}
					<input class="queryinputfield" type="text" name="query[group3]" size="40" readonly="readonly" value=" ({#selecthere#|escape:htmlall}) " onclick="editGroupSelection('{$sessionid}','img_group_3','{$query.group3lastpath}','{$query.group3id}');">
				{else}
					<input class="queryinputfield" type="text" name="query[group3]" size="40" readonly="readonly" value="{$query.mygroup|escape:html}" onclick="editGroupSelection('{$sessionid}','img_group_3','{$query.group3lastpath}','{$query.group3id}');">
				{/if}

				<input class="queryinputfield" type="hidden" name="query[group3id]" value="{$query.group3id|escape:html}">
				<input class="queryinputfield" type="hidden" name="query[group3owner]" value="{$query.group3owner|escape:html}">
				<input class="queryinputfield" type="hidden" name="query[group3lastpath]" value="{$query.group3lastpath|escape:html}">
			
				<input type="button" onClick="cleargroup3();" name="nogroup3" value="{#nogroup#|escape:html}">
			</td>
		</tr>
		<tr>
			<td class="queryinputfieldtext">
		  		{#upload#}
			</td>
			<td class="queryinputfield">
				<select class="queryselectfield" name="query[completedir]">
				  <option value="1">{#applet#}</option>
					<option value="0">{#file_zip#}</option>
				</select>
			</td>
		</tr>
		<!--
		<tr>
			<td class="queryinputfieldtext">
		  		{#completedir#}
			</td>
			<td class="queryinputfield">
				<select class="queryselectfield" name="query[completedir]">
					<option value="0">{#file#}</option>
					<option value="1">{#directory#}</option>
				</select>
			</td>
		</tr>
		-->
		<tr>
		   	<td class="queryinputfieldtext">
		    	{#targetdirectory#}
		   	</td>
		   	<td>
		   		{#nextstep#}
			</td>
		</tr>
		<tr>
			<td class="field_name">
				&nbsp;
			</td>
			<td>
				<input type="hidden" name="query[process]" value="1">
				<input type="submit" name="query[new]" value="{#continue#|escape:html}">
			</td>
		</tr>
	{else}
		{if $query.completedir eq "0"}
		<tr>
			<td class="queryinputfieldtext">
		  		{#sourcefile#}
			</td>
			<td class="queryinputfield">
				<input class="queryinputfield" type="file" name="query[sourcedirectory]" value="{$query.directory|escape:html}" size="40">
				<input type="hidden" name="query[completedir]" value="0">
			</td>
		</tr>
		{else}
		<!--
		<tr>
			<td class="queryinputfieldtext">
		  		{#sourcedirectory#}
			</td>
			<td class="queryinputfield">

				<select class="queryselectfield" name="query[sourcedirectory]">
				{dir_list var=basedirs dir=$config.uploaddir}
					{foreach from=$basedirs item=row}
						<option value="{$config.uploaddir}{$row.name}">{if $row.name eq "no_subdirs"}{assign var=no_subdirs value=1}{#no_subdirs#}{else}{$row.name}{/if}</option>
					{/foreach}
				</select>
				<input type="hidden" name="query[completedir]" value="1">
			</td>
		</tr>
		-->
		<tr>
			<td class="queryinputfieldtext">
				&nbsp;
			</td>
			<td class="queryinputfield">
				&nbsp;
				<input type="hidden" name="query[completedir]" value="1">
			</td>
		</tr>
		<tr>
				<td class="queryinputfieldtext" style="vertical-align: top;">
		    	{#java_upload_applet#}
		    	<div id="finishedmessage" class="message">
			     </div>
		   	</td>
		   	<td style="vertical-align: top;">
    			<div id="uploadapplet" style="border-width: 1px; border-style: solid; border-color: black; text-align: center; vertical-align: middle; padding: 5px 10px; background-color: #DCDCDC; width: 470px;">
      			<applet name="postlet" code="Main.class" archive="include/postlet/postlet.jar" width="450" height="200" mayscript>
      				<param name = "maxthreads"		value = "5" />
      
      				<param name = "language"		value = "DE" />
      				<param name = "type"			value = "application/x-java-applet;version=1.3.1" />
      				<param name = "destination"		value = "http://{$smarty.server.SERVER_NAME}{$smarty.server.SCRIPT_NAME}?PHPSESSID={$sessionid}&javaupload=1" />
      				<param name = "backgroundcolour" value = "7833753" />
      				<param name = "tableheaderbackgroundcolour" value = "13947080" />
      				<param name = "tableheadercolour" value = "0" />
      				<param name = "warnmessage" value = "true" />
      				<param name = "autoupload" value = "false" />
      				<param name = "helpbutton" value = "false" />
      
      				<param name = "fileextensions" value = "Bilder,jpg,gif,jpeg" />
      				<param name = "endpage" value = "[This is unset here]" />
      				<param name = "helppage" value = "[This is unset here]" />
      				
      				Your browser does not support Java Applets or you disabled Java Applets in your browser-options.
      				To use this applet, please install the newest version of Sun's Java Runtime Environment (JRE).
      				You can get it from <a href="http://www.java.com/">java.com</a>
      			</applet>
    			</div>
			</td>
		</tr>
		{/if}
		<tr>
		   	<td class="queryinputfieldtext">
		    	{#targetdirectory#}
		   	</td>
		   	<td>
		   	
		   		{basedir_list var=basedirs cid=$query.collectionid sql=sql}
		   	
				<select class="queryselectfield" name="query[baseid]">
					<!-- {$sql} -->
					{foreach from=$basedirs item=row}
						<option value="{$row.img_baseid}" {if $query.baseid eq $row.img_baseid} selected{/if}>{if $row.host neq "local" and $row.host neq ""}{$row.host}{else}localhost{/if} :: {$row.base}</option>
					{/foreach}
				</select>
					
			</td>
		</tr>
		<tr>
			<td class="field_name">
				&nbsp;
			</td>
			<td>
				<input type="hidden" name="query[collectionid]" value="{$query.collectionid}">
				<input type="hidden" name="query[type]" value="{$query.type}">
				<input type="hidden" name="query[group1id]" value="{$query.group1id}">
				<input type="hidden" name="query[group1owner]" value="{$query.group1owner}">
				<input type="hidden" name="query[group2id]" value="{$query.group2id}">
				<input type="hidden" name="query[group2owner]" value="{$query.group2owner}">
				<input type="hidden" name="query[group3id]" value="{$query.group3id}">
				<input type="hidden" name="query[group3owner]" value="{$query.group3owner}">
				<input type="hidden" name="query[process]" value="2">
				{if $no_subdirs neq "1"}
					<input type="submit" name="query[new]" value="{#insertimages#|escape:html}">
				{else}
					<br />
					<strong onclick="window.close();">{#closewindow#}</strong>
				{/if}
			</td>
		</tr>
	{/if}

	<tr>
		<td>
		&nbsp;
		</td>
	</tr>
	</table>
</form>
</body>
</html>
<!-- --------------------------------------------
END image_add.tpl
--------------------------------------------- -->
