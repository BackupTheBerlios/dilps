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
BEGIN at_edit_classification.tpl
================================================= -->

{if $config.utf8 eq "true"}
	{config_load file="`$config.skinBase``$config.skin`/`$config.language`/edit_architecture.conf.utf8"}
{else}
	{config_load file="`$config.skinBase``$config.skin`/`$config.language`/edit_architecture.conf"}
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
<meta name="author" content="jrgen enge, thorsten wbbena">
<meta name="date" content="2003-01-23">
<link rel="shortcut icon" href="favicon.ico">
<title>. : DILPS : .</title>
<link rel="stylesheet" type="text/css" href="css.php">
<script src="dilps.lib.js" type="text/javascript"></script>
<script src="include/extended/ext_edit.js" type="text/javascript"></script>
</head>

<body class="headerstyle" style="width: 100%; height: 100%; vertical-align: top;">
	<form name="Main" action="{$SCRIPT_NAME}" method="POST" enctype="multipart/form-data">
	<input type="hidden" name="PHPSESSID" value="{$sessionid}">

	{if $query.id ne ""}
	
	{query_ext_element type="architecture" element="classification" fieldnames="fieldnames" values="values" sql="sql" query=$query}
	
	<!-- {$sql} -->
	
	<script language="javascript">
		var rs_fn 	= "{$fieldnames}";
		var rs_val 	= "{$values}";
		
		js_fn 	= rs_fn.split('; ');
		js_val	= rs_val.split('; ');
	</script>
	
	<input type="hidden" name="imageid" value="{$query.id}">

	<table class="header" style="width: 90%; margin: auto;"/>
		<tr>
			<td class="heading">{#classification#}</td>
		</tr>
		<tr>
			<td style="height: 20px;">
				&nbsp;
			</td>
		</tr>
		<tr>
			<td>
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="total" value="{#total#}">{#total#}</td>
					<td><input type="checkbox" name="facade" value="{#facade#}">{#facade#}</td>
					<td><input type="checkbox" name="yard" value="{#yard#}">{#yard#}</td>
					<td><input type="checkbox" name="wing" value="{#wing#}">{#wing#}</td>
				</tr>
				</table>  
				
				<input type="checkbox" name="choir" value="{#choir#}">{#choir#}<br />
				<br />
				
				<input type="checkbox" name="transept" value="{#transept#}">{#transept#}<br />
				<br />
				
				<input type="checkbox" name="nave" value="{#nave#}">{#nave#}<br />
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="centralaisle" value="{#centralaisle#}">{#centralaisle#}</td>
					<td><input type="checkbox" name="sideaisle" value="{#sideaisle#}">{#sideaisle#}</td>
				</tr>
				</table>  
				
				<input type="checkbox" name="annex" value="{#annex#}">{#annex#}<br />
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="chapel" value="{#chapel#}">{#chapel#}</td>
				</tr>
				</table>  
				
				<input type="checkbox" name="portal" value="{#portal#}">{#portal#}<br />
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="jamb" value="{#jamb#}">{#jamb#}</td>
					<td><input type="checkbox" name="tympanum" value="{#tympanum#}">{#tympanum#}</td>
				</tr>
				</table>  
				
				<input type="checkbox" name="architecturewindow" value="{#architecturewindow#}">{#architecturewindow#}<br />
				<br />
				
				<input type="checkbox" name="stairway" value="{#stairway#}">{#stairway#}<br />
				<br />
				
				<input type="checkbox" name="tower" value="{#tower#}">{#tower#}<br />
				<br />
				
				<input type="checkbox" name="cupola" value="{#cupola#}">{#cupola#}<br />
				<br />
				
				<input type="checkbox" name="hall" value="{#hall#}">{#hall#}<br />
				<br />
				
				<input type="checkbox" name="vault" value="{#vault#}">{#vault#}<br />
				<br />
				
				<input type="checkbox" name="architectureelement" value="{#architectureelement#}">{#architectureelement#}<br />
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><input type="checkbox" name="column" value="{#column#}">{#column#}</td>
					<td><input type="checkbox" name="base" value="{#base#}">{#base#}</td>
					<td><input type="checkbox" name="capital" value="{#capital#}">{#capital#}</td>
					<td><input type="checkbox" name="frames" value="{#frames#}">{#frames#}</td>
				</tr>
				</table>  
				
				
				<input type="checkbox" name="park" value="{#park#}">{#park#}<br />
				<br />
				
				<input type="checkbox" name="square" value="{#square#}">{#square#}<br />
				<br />
				
				<strong>{#additionalentry#}</strong><br>
				<textarea name="classificationaddition" rows="2" cols="40"></textarea>
				
			</td>
		</tr>
		<tr>
			<td style="height: 20px;">
				&nbsp;
			</td>
		</tr>
		<tr>
			<td>
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
					<tr>
						<td><input type="button" value="eingeben" onclick="saveSelection('classification'); window.close();"></td>
						<td><input type="button" value="zur&uuml;cksetzen" onclick="restoreState(js_fn, js_val);"></td>
						<td><input type="reset" value="alle l&ouml;schen"></td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<input type="hidden" name="step" value="1">
</form>

<script language="javascript">
	restoreState(js_fn, js_val);
</script>


{/if}

</body>
</html>

<!-- =================================================
END ac_edit_iconography.tpl
================================================= -->
