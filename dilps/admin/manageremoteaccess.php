<?php

	include( '../config.inc.php' );
	include( '../globals.inc.php' );
	include( $config['includepath'].'adodb/adodb.inc.php' );
	
	error_reporting("E_ALL");

	global $db_db, $db_host, $db_prefix, $db_pwd, $db_user;

	$db_driver	= 'mysql';

	define( 'BAD', 0 );
	define( 'GOOD', 1 );
	
	// print_r($_REQUEST);
	
	if (isset($_REQUEST['action'])){
		$action = trim($_REQUEST['action']);
	}
	else
	{
		$action = "view";
	}
	
	if (isset($_REQUEST['ip'])){
		$ip = trim(urldecode($_REQUEST['ip']));
	}
	else
	{
		$ip = "";
	}
	
	if (isset($_REQUEST['access'])){
		$access = trim($_REQUEST['access']);
	}
	else
	{
		$access = 0;
	}
	
	if (isset($_REQUEST['line'])){
		$line = intval(trim($_REQUEST['line']));
	}
	else
	{
		$line = -1;
	}	
	
	if (isset($_REQUEST['changed'])){
		$changed = intval(trim($_REQUEST['changed']));
	}
	else
	{
		$changed = 0;
	}
	
	if (isset($_REQUEST['added'])){
		$added = intval(trim($_REQUEST['added']));
	}
	else
	{
		$added = 0;
	}
	
?>

<html>
<head>
<title> DILPS Remote Access Management  </title>
<link rel="stylesheet" type="text/css" href="admin.css" />
</head>
<body>
<table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff">
	<tr class="top-bar">
		<td class="links">
			[ <a href="index.php">Back to Administration</a> ]
		</td>
		<td class="title">
			<a href="<?php echo ($_SERVER['PHP_SELF']); ?>">Manage DILPS remote access<a/>
		</td>
	</tr>
</table>

<?php

	$db = NewADOConnection("mysql");
	$rs = $db->Connect( $db_host, $db_user, $db_pwd, $db_db);
	$db->SetFetchMode(ADODB_FETCH_ASSOC);	
	
	// $db->debug = true;
	
	if (!$rs)
	{
		die("Error connecting to database - please check your configuration");
	}

?>

<table width="50%" border="1" cellpadding="10" cellspacing="1">

	<tr>
		<th>
			IP adress
		</th>
		<th>
			Access granted
		</th>
		<th>
			Description
		</th>
	</tr>

	<?php
	
		if ($changed >0)
		{
			if (empty($ip))
			{
				echo ("<tr>\n<td colspan='3'>Data unchanged - you may not use empty IP adress fields</td>\n<tr>");
			}
			else 
			{
				if ($access < 0)
				{
					echo ("<tr>\n<td colspan='3'>Data unchanged - a transfer error occured while saving your data</td>\n<tr>");
				}
				else 
				{	
					$description = trim($_REQUEST['description']);
									
					$sql = "UPDATE ".$db_prefix."interdilps_hosts SET "
					."access=".$db->qstr($access).","
					."description=".$db->qstr($description)
					." WHERE ip=".$db->qstr($ip);
					
					$rs = $db->Execute($sql);

					if ($rs === false)				
					{
						echo ("<tr>\n<td colspan='3'>Data unchanged - a database error occured while saving your data</td>\n<tr>");
					}
					
				}			
				
			}
			
		}
		
		if ($added > 0)
		{
			if (empty($ip))
			{
				echo ("<tr>\n<td colspan='3'>Data unchanged - you may not use empty IP adress fields</td>\n<tr>");
			}
			else 
			{
				if ($access < 0)
				{
					echo ("<tr>\n<td colspan='3'>Data unchanged - a transfer error occured while saving your data</td>\n<tr>");
				}
				else 
				{
					$description = trim($_REQUEST['description']);
					
					$sql = 	"SELECT * FROM ".$db_prefix."interdilps_hosts WHERE ip="
							.$db->qstr($ip);
					
					$rs  = $db->Execute($sql);
					
					if ($rs === false)				
					{
						echo ("<tr>\n<td colspan='3'>Data not added - a database error occured while saving your data</td>\n<tr>");
					}
					else 
					{
						if ($rs->RecordCount() > 0)
						{
							echo ("<tr>\n<td colspan='3'>Data not added - IP adress already exists</td>\n<tr>");
						}
						else 
						{
							if ($ip == '0.0.0.0')
							{
								echo ("<tr>\n<td colspan='9'>Data not added - you cannot use '0.0.0.0' as IP Adress</td>\n<tr>");
							}
							else 
							{
								$sql = 	"INSERT INTO ".$db_prefix."interdilps_hosts (ip, access, description) VALUES("
									.$db->qstr($ip).","
									.$db->qstr($access).","
									.$db->qstr($description).")";
							
								$rs = $db->Execute($sql);
			
								if ($rs === false)				
								{
									echo ("<tr>\n<td colspan='3'>Data not added - a database error occured while saving your data</td>\n<tr>");
								}
								
							}
							
						}
						
					}
					
				}
				
			}
			
		}
		
		if ($action == "delete")
		{
			if ($ip == "")
			{
				echo ("<tr>\n<td colspan='3'>Data unchanged - you must specify the entry you want to delete</td>\n<tr>");
			}
			else 
			{
				$sql = "DELETE FROM ".$db_prefix."interdilps_hosts WHERE "
					."ip=".$db->qstr($ip);
					
				$rs = $db->Execute($sql);
	
				if ($rs === false)				
				{
					echo ("<tr>\n<td colspan='3'>Data unchanged - a database error occured while deleting the entry</td>\n<tr>");
				}
				
			}			
			
		}
	
		
		$sql 	= "SELECT * FROM ".$db_prefix."interdilps_hosts";
		
		$rs 	= $db->Execute($sql);
		
		$count	= 0;
		
		while(!$rs->EOF)
		{
			echo ("<tr>\n");
			
			if ($action == 'edit' && $count == $line)
			{
				echo ("<form method='POST' action='".$_SERVER['PHP_SELF']."'>");
			
				echo(
						"<td>".$rs->fields["ip"]
						."<input type='hidden' name='ip' value='".$rs->fields["ip"]."'"
						."</td>"
					);
				
				echo(
						"<td>"
						."<select name='access' size='1'>\n"
      					."<option value='1'"
  					);
  					
				if ($rs->fields['access'] == '1')
				{
					echo (" selected ");
				}
				
				echo (">grant</option>\n");
				
				echo ("<option value='0'");
				
				if ($rs->fields['access'] == '0')
				{
					echo (" selected ");
				}
				
				echo (">deny</option>\n");
				
				echo(
						"<td>"
						."<input type='text' name='description' value='".$rs->fields["description"]."'"
						."</td>"
					);
				
				echo (	"<td>"
						."<input type='hidden' name='changed' value='1'>\n"
						."<input type='hidden' name='line' value='".$line."'>\n"
						."<input type='submit' value='Save'>\n"
						."<a href='".$_SERVER['PHP_SELF']."'><button type='button' value='Cancel'>Cancel</button></a>\n"
						."</td>");
				
				echo ("</form>");
				
			}
			else 
			{
				echo ("<td>".$rs->fields["ip"]."</td>");
				
				echo ("<td>");
				
				echo ($rs->fields["access"] == 1 ? 'grant' : 'deny');
				
				echo ("</td>");
				
				echo ("<td>".$rs->fields["description"]."</td>");
				
				echo ("<td><a href='".$_SERVER['PHP_SELF']."?action=edit&line=".$count."'><button type='button' value='Edit'>Edit</button></a> <a href='".$_SERVER['PHP_SELF']."?action=delete&ip=".urlencode($rs->fields['ip'])."&access=".$rs->fields['access']."'><button type='button' value='Delete'>Delete</button></a></td>");
				
			}
			
			echo ("</tr>\n");
			
			$count++;
																		
			$rs->MoveNext();
		}
		
		if ($action != "edit")
		{
			echo ("<tr>\n");
		
			echo ("<form method='POST' action='".$_SERVER['PHP_SELF']."'>");
		
			echo ("<td><input type='text' name='ip'></td>");
			
			echo(
				"<td>"
				."<select name='access' size='1'>\n"
				."<option value='1' selected>grant</option>\n"
				."<option value='0'>deny</option>\n"
				."</select>\n"
				."</td>"
			);				
			
			echo ("<td><input type='text' name='description'></td>");
			
			echo (	"<td>"
					."<input type='hidden' name='added' value='1'>\n"
					."<input type='submit' value='Add'>\n"
					."</td>");
			
			echo ("</form>");
			
			echo ("</tr>");			
		}
			
	
	?>

</table>