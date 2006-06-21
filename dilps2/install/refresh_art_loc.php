<?php

	include( $config['includepath'].'globals.inc.php' );
	include( $config['includepath'].'convert_v1.inc.php');
	include( $config['includepath'].'adodb/adodb.inc.php' );
	include( $config['includepath'].'tools.inc.php' );
	include( $config['includepath'].'thesauri/soundex_fr.php' );

	global $db, $db_db, $db_host, $db_prefix, $db_pwd, $db_user;

	define( 'BAD', 0 );
	define( 'GOOD', 1 );

	if (isset($_REQUEST['step'])){
		$step = $_REQUEST['step'];
	}
	else
	{
		$step = 0;
	}

?>

<html>
<head>
<title> DILPS Installer  </title>
<link rel="stylesheet" type="text/css" href="install.css" />
</head>
<body>
<table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff">
	<tr class="top-bar">
		<td class="links">
			[ <a href="index.php">Back to Administration</a> ]
		</td>
		<td class="title">
		<?php
			switch ( $step ) {
				case 1:
					echo "Processing";
					break;
				case 0:
				default:
					echo "Test Database";
					break;
			}
		?>
		</td>
	</tr>
</table>


<form method='POST'>
<?php

	$failed = false;

	if ( 0 == $step)
	{

	?>

		<!-- Test the values and select tables to migrate -->
		<table width="100%" border="0" cellpadding="10" cellspacing="1">
			<tr>
				<td bgcolor="#e8e8e8" colspan="2">
					<span class="title">Testing Databases</span>
				</td>
			</tr>

			<tr>
				<td bgcolor="#ffffff">
					Attempting to connect to target database
				</td>

				<?php

					if (!$db)
					{
						$db = NewADOConnection( "mysql" );
						$res = @$db->Connect( $db_host, $db_user, $db_pwd, $db_db);
					}
					else
					{
						$res = true;
					}

					echo '<td ';
					if ( $res === false ) {
							echo 'bgcolor="red">BAD';
							$failed = true;
					}
					else
					{
						echo 'bgcolor="green">GOOD';
					}
					echo '</td>';
				?>

			</tr>

		<?php

		if (!$failed)
		{
			?>
			<table width="100%" border="0" cellpadding="10" cellspacing="1">
				<tr>
					<td>
						<strong>
							Please note: <br/>
							<ul>
								<li>
								This tool normally isn't necessary. It just helps you, if your artist and location databases are
								</li>
								<li>
								It will not touch any artist or location information that were not generated by the system (e.g. Getty)
								</li>
							</ul>
						</strong>
						<input type="hidden" name="step" value="1">
					</td>
				</tr>
				<tr>
					<td>
						<input type="button" value="Proceed" onclick="submit()">
					</td>
				</tr>
			</table>
		<?php
		}

	}
	elseif (1 == $step)
	{

		if (!$db)
		{
			$db = NewADOConnection( "mysql" );
			$res = $db->Connect( $db_host, $db_user, $db_pwd, $db_db);
		}

		$sql = "DELETE FROM {$db_prefix}artist WHERE src=".$db->qstr("dilps");
		$rs = $db->Execute( $sql );

		$sql = "SELECT DISTINCT name1 FROM {$db_prefix}meta WHERE name1 != ''";
		$rs = $db->Execute( $sql );

		while( !$rs->EOF )
		{
			$name = trim(stripslashes($rs->fields['name1']));
			$artistnames = explode(',',$name);

			if (isset($artistnames[0])){

				if (strlen($artistnames[0]))
				{
					$art_name = trim(stripslashes(($artistnames[0])));
				}

			}
			else
			{
				$art_name = '';
			}

			if (isset($artistnames[1])){
				if (strlen($artistnames[1]))
				{
					$art_surname = trim(stripslashes($artistnames[1]));
				}
			}
			else
			{
					$art_surname = '';
			}

			$soundslike = '';

			if (strlen($art_surname) > 0){

				$soundslike .= '.'.soundex2($art_surname).'.';

			}

			if (strlen($art_name) > 0){

				$soundslike .= soundex2($art_name).'.';

			}

			$sql2 = "SELECT * FROM {$db_prefix}artist WHERE lower(name) = ".$db->qstr(trim(strtolower($name)));
			$rs2 = $db->GetOne ($sql2);

			if ($rs2 === false)
			{
				$sql3 = "INSERT INTO `{$db_prefix}artist` (src,name,sounds)"
						." VALUES('dilps',".$db->qstr($name).",".$db->qstr($soundslike).")";
				echo $sql3."\n<br>\n";
				$rs3 = $db->Execute($sql3);
				if( !$rs3 )
				{
					echo $db->ErrorMsg()."\n<br>\n";
				}
			}
			$rs->MoveNext();
		}

		$sql = "SELECT * FROM {$db_prefix}artist";
		$rs = $db->Execute( $sql );
		while( !$rs->EOF )
		{
			$sql2 = "UPDATE `{$db_prefix}meta` SET name1id = ".$db->qstr($rs->fields['id']).
					", name1sounds = ".$db->qstr($rs->fields['sounds']).
					" WHERE lower(name1) = ".$db->qstr(strtolower($rs->fields['name']));
			
			echo $sql2."\n<br>\n";
			$rs2 = $db->Execute($sql2);
			if( !$rs2 )
			{
				echo $db->ErrorMsg()."\n<br>\n";
			}
					
			$sql2 = "UPDATE `{$db_prefix}meta` SET name2id = ".$db->qstr($rs->fields['id']).
					", name2sounds = ".$db->qstr($rs->fields['sounds']).
					" WHERE lower(name2) = ".$db->qstr(strtolower($rs->fields['name']));

			echo $sql2."\n<br>\n";
			$rs2 = $db->Execute($sql2);
			if( !$rs2 )
			{
				echo $db->ErrorMsg()."\n<br>\n";
			}
			$rs->MoveNext();
		}
		
		$sql = "SELECT DISTINCT name2 FROM {$db_prefix}meta WHERE name2 != ''";
		$rs = $db->Execute( $sql );

		while( !$rs->EOF )
		{
			$name = trim(stripslashes($rs->fields['name2']));
			$artistnames = explode(',',$name);

			if (isset($artistnames[0])){

				if (strlen($artistnames[0]))
				{
					$art_name = trim(stripslashes(($artistnames[0])));
				}

			}
			else
			{
				$art_name = '';
			}

			if (isset($artistnames[1])){
				if (strlen($artistnames[1]))
				{
					$art_surname = trim(stripslashes($artistnames[1]));
				}
			}
			else
			{
					$art_surname = '';
			}

			$soundslike = '';

			if (strlen($art_surname) > 0){

				$soundslike .= '.'.soundex2($art_surname).'.';

			}

			if (strlen($art_name) > 0){

				$soundslike .= soundex2($art_name).'.';

			}

			$sql2 = "SELECT * FROM {$db_prefix}artist WHERE lower(name) = ".$db->qstr(trim(strtolower($name)));
			$rs2 = $db->GetOne ($sql2);

			if ($rs2 === false)
			{
				$sql3 = "INSERT INTO `{$db_prefix}artist` (src,name,sounds)"
						." VALUES('dilps',".$db->qstr($name).",".$db->qstr($soundslike).")";
				echo $sql3."\n<br>\n";
				$rs3 = $db->Execute($sql3);
				if( !$rs3 )
				{
					echo $db->ErrorMsg()."\n<br>\n";
				}
			}
			$rs->MoveNext();
		}

		$sql = "SELECT * FROM {$db_prefix}artist";
		$rs = $db->Execute( $sql );
		while( !$rs->EOF )
		{
			$sql2 = "UPDATE `{$db_prefix}meta` SET name1id = ".$db->qstr($rs->fields['id']).
					", name1sounds = ".$db->qstr($rs->fields['sounds']).
					" WHERE lower(name1) = ".$db->qstr(strtolower($rs->fields['name']));
			
			echo $sql2."\n<br>\n";
			$rs2 = $db->Execute($sql2);
			if( !$rs2 )
			{
				echo $db->ErrorMsg()."\n<br>\n";
			}
					
			$sql2 = "UPDATE `{$db_prefix}meta` SET name2id = ".$db->qstr($rs->fields['id']).
					", name2sounds = ".$db->qstr($rs->fields['sounds']).
					" WHERE lower(name2) = ".$db->qstr(strtolower($rs->fields['name']));

			echo $sql2."\n<br>\n";
			$rs2 = $db->Execute($sql2);
			if( !$rs2 )
			{
				echo $db->ErrorMsg()."\n<br>\n";
			}
			$rs->MoveNext();
		}

		$sql = "DELETE FROM {$db_prefix}location WHERE src=".$db->qstr("dilps");
		$rs = $db->Execute( $sql );

		$sql = "SELECT DISTINCT imageid, collectionid, location, locationsounds"
				." FROM {$db_prefix}meta WHERE location != ''";
		$rs = $db->Execute( $sql );

		while( !$rs->EOF )
		{
			$location = trim(stripslashes($rs->fields['location']));
			$locationsounds = trim(stripslashes(soundex2($location)));

			$imageid = trim(stripslashes($rs->fields['imageid']));
			$collectionid = trim(stripslashes($rs->fields['collectionid']));

			$sql2 = "SELECT * FROM {$db_prefix}location WHERE location = ".$db->qstr($location);
			$rs2 = $db->GetOne ($sql2);

			if ($rs2 === false)
			{

				$sql3 = "INSERT INTO `{$db_prefix}location` (src, source_id, location, sounds) "
						."VALUES ('dilps',".$db->qstr($collectionid.":".$imageid).", "
						.$db->qstr($location).", ".$db->qstr($locationsounds).")";

				echo $sql3."\n<br>\n";
				$rs3 = $db->Execute($sql3);
				if( !$rs3 )
				{
					echo $db->ErrorMsg()."\n<br>\n";
				}
			}
			$rs->MoveNext();
		}

		$sql = "SELECT * FROM {$db_prefix}location";
		$rs = $db->Execute( $sql );

		while( !$rs->EOF )
		{
			$sql2 = "UPDATE `{$db_prefix}meta` SET locationid = ".$db->qstr($rs->fields['id']).
					", locationsounds = ".$db->qstr($rs->fields['sounds']).
					" WHERE location = ".$db->qstr($rs->fields['location']);

			echo $sql2."\n<br>\n";
			$rs2 = $db->Execute($sql2);
			if( !$rs2 )
			{
				echo $db->ErrorMsg()."\n<br>\n";
			}
			$rs->MoveNext();
		}

		?>

		<table width="100%" border="0" cellpadding="10" cellspacing="1">
			<tr>
				<td>
					<strong>
						Your Artist und Location database has been refreshed.<br>
						See above for details.
					</strong>
				</td>
			</tr>
			<tr></tr>
				<td class="links">
					<a href="index.php">Back to Administration</a>
				</td>
			</tr>
		</table>

	<?php

	}

	?>

	</form>

</body>
</html>
