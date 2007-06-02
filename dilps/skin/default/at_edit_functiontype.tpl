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
BEGIN at_edit_functiontype.tpl
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
<meta name="author" content="juergen enge, thorsten wuebbena, sebastian doeweling">
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
	
	{query_ext_element type="architecture" element="functiontype" fieldnames="fieldnames" values="values" sql="sql" query=$query}
	
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
			<td class="heading">{#functiontype#}</td>
		</tr>
		<tr>
			<td style="height: 20px;">
				&nbsp;
			</td>
		</tr>
		<tr>
				<table width="0*" border="0" cellspacing="10" cellpadding="0">
  				<tr>
  					<td>
  					   <input type="checkbox" name="SacralChristian" value="{#sacral_christian#}">{#sacral_christian#}<br />
  					   <input type="checkbox" name="SacralJewish" value="{#sacral_jewish#}">{#sacral_jewish#}<br />
  					   <input type="checkbox" name="SacralMuslim" value="{#sacral_muslim#}">{#sacral_muslim#}<br />
  					   <input type="checkbox" name="SacralAncient" value="{#sacral_ancient#}">{#sacral_ancient#}<br />
  					</td>
  				</tr>
  				<tr>
  				  <td>
  				    <input type="checkbox" name="TenementPrivate" value="{#tenement_private#}">{#tenement_private#}<br />
  				    <input type="checkbox" name="TenementCollective" value="{#tenement_collective#}">{#tenement_collective#}<br />
  				  </td>
  				</tr>
  				<tr>
  				  <td>
  				    <input type="checkbox" name="PublicBuilding" value="{#public_building#}">{#public_building#}<br />
  				  </td>
  				</tr>
  				<tr>
  				  <td>
  				    <input type="checkbox" name="Fortification" value="{#fortification#}">{#fortication#}<br />
  				  </td>
  				</tr>
  				<tr>
  				  <td>
  				    <input type="checkbox" name="IndustrialBuilding" value="{#industrial_building#}">{#industrial_building#}<br />
  				  </td>
  				</tr>
				</table>  
		</tr>
		<tr>
			<td>
			   <table width="0*" border="0" cellspacing="10" cellpadding="0">
  				<tr>
  					<td>
  					   <strong>{#other#} {#functiontype#}</strong><br />
				        <textarea name="OtherFunctiontype" rows="2" cols="40"></textarea>
  					</td>
  				</tr>
				</table>  
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
						<td><input type="button" value="eingeben" onclick="saveSelection('functiontype');window.close();"></td>
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
