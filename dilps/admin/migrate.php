<?php

	include( '../config.inc.php' );
	include( '../globals.inc.php' );
	include( $config['includepath'].'convert_v1.inc.php');
	include( $config['includepath'].'adodb/adodb.inc.php' );
	include( $config['includepath'].'tools.inc.php' );

	ini_set('display_errors',1);
	ini_set('magic_quotes_runtime',0);

  error_reporting(E_ALL);

	// activate compatibility mode
	ini_set( 'zend.ze1_compatibility_mode', 'On' );

	// deactive output buffering
	ini_set( 'output_buffering', 0 );

	global $db_db, $db_host, $db_prefix, $db_pwd, $db_user;

	$db_driver	= 'mysql';

	define( 'BAD', 0 );
	define( 'GOOD', 1 );

	if (isset($_REQUEST['step'])){
		$step = $_REQUEST['step'];
	}
	else
	{
		$step = 0;
	}

	if (isset($_REQUEST['ng_hostname'])){
		$ng_hostname = $_REQUEST['ng_hostname'];
	}
	else
	{
		$ng_hostname = '';
	}

	if (isset($_REQUEST['ng_username'])){
		$ng_username = $_REQUEST['ng_username'];
	}
	else
	{
		$ng_username = '';
	}

	if (isset($_REQUEST['ng_password'])){
		$ng_password = $_REQUEST['ng_password'];
	}
	else
	{
		$ng_password = '';
	}

	if (isset($_REQUEST['ng_name'])){
		$ng_name = $_REQUEST['ng_name'];
	}
	else
	{
		$ng_name = '';
	}

	if (isset($_REQUEST['ng_prefix'])){
		$ng_prefix = $_REQUEST['ng_prefix'];
	}
	else
	{
		$ng_prefix = '';
	}

	if (isset($_REQUEST['old_hostname'])){
		$old_hostname = $_REQUEST['old_hostname'];
	}
	else
	{
		$old_hostname = '';
	}

	if (isset($_REQUEST['old_username'])){
		$old_username = $_REQUEST['old_username'];
	}
	else
	{
		$old_username = '';
	}

	if (isset($_REQUEST['old_password'])){
		$old_password = $_REQUEST['old_password'];
	}
	else
	{
		$old_password = '';
	}

	if (isset($_REQUEST['old_name'])){
		$old_name = $_REQUEST['old_name'];
	}
	else
	{
		$old_name = '';
	}

?>

<html>
<head>
<title> DILPS Installer  </title>
<link rel="stylesheet" type="text/css" href="admin.css" />
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
				case 3:
					echo "Processing";
					break;
				case 2:
					echo "Test and Proceed";
					break;
				case 1:
					echo "Select Collections";
					break;
				case 0:
				default:
					echo "Collect Database Information";
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

	<table width="100%" border="0" cellpadding="10" cellspacing="1">
		<tr>
			<td bgcolor="#e8e8e8" colspan="2">
				<span class="title">Target Database Option</span> (read from your configuration file)
			</td>
		</tr>

		<tr>
			<td>
				Hostname (for Database Server)
			</td>
			<td>
				<input size="80"  name="ng_hostname" type="text" value="<?php echo ($db_host); ?>"></input>
			</td>
		</tr>

		<tr>
			<td>
				Username (for Database)
			</td>
			<td>
				<input  size="80" name="ng_username" type="text" value="<?php echo ($db_user); ?>"></input>
			</td>
		</tr>

		<tr>
			<td>
				Password (for Database)
			</td>
			<td>
				<input  size="80" name="ng_password" type="password" value="<?php echo ($db_pwd); ?>"></input>
			</td>
		</tr>

		<tr>
			<td>
				Database name (for Database)
			</td>
			<td>
				<input  size="80" name="ng_name" type="text" value="<?php echo ($db_db); ?>"></input>
			</td>
		</tr>

		<tr>
			<td>
			  Table prefix (for Database)
			</td>
			<td>
				<input  size="80" name="ng_prefix" type="text" value="<?php echo ($db_prefix); ?>"></input>
			</td>
		</tr>

		<tr>
			<td bgcolor="#e8e8e8" colspan="2">
				<span class="title">Source Database Option</span> (guessed by installer)
			</td>
		</tr>

		<tr>
			<td>
				Hostname (for Database Server)
			</td>
			<td>
				<input size="80"  name="old_hostname" type="text" value="<?php echo ($db_host); ?>"></input>
			</td>
		</tr>

		<tr>
			<td>
				Username (for Database)
			</td>
			<td>
				<input  size="80" name="old_username" type="text" value="<?php echo ($db_user); ?>"></input>
			</td>
		</tr>

		<tr>
			<td>
				Password (for Database)
			</td>
			<td>
				<input  size="80" name="old_password" type="password" value="<?php echo ($db_pwd); ?>"></input>
			</td>
		</tr>

		<tr>
			<td>
				Database name (for Database)
			</td>
			<td>
				<input  size="80" name="old_name" type="text" value="<?php echo ($db_db); ?>"></input>
			</td>
		</tr>
		<tr>
			<td>
				<input type="hidden" name="step" value="1">
			</td>
			<td>
				<input type="button" value="Proceed" onclick="submit()">
			</td>
		</tr>
	</table>

	<?php

	}
	else if (1 == $step)
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

					$ng_db = NewADOConnection("mysql");
					$ng_res = $ng_db->NConnect( $ng_hostname, $ng_username, $ng_password, $ng_name);

					$ng_db->SetFetchMode(ADODB_FETCH_ASSOC);


					echo '<td ';
					if ( !$ng_res) {
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
			<tr>
				<td bgcolor="#ffffff">
					Attempting to connect to source database
				</td>
				<?php

					$old_db = NewADOConnection("mysql");
					$old_res = $old_db->NConnect( $old_hostname, $old_username, $old_password, $old_name);

					$old_db->SetFetchMode(ADODB_FETCH_ASSOC);


					echo '<td ';
					if ( !$old_res) {
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
		</table>

		<table width="100%" border="0" cellpadding="10" cellspacing="1">
			<tr>
				<td bgcolor="#e8e8e8" colspan="2">
					<span class="title">Select the source collection</span>
				</td>
			</tr>
		</table>
		<table width="100%">
			<tr>

				<?php
					$sql = "SELECT smg.sammlungid as sammlungid, smg.name as name, smg.sammlung_ort as sammlung_ort, "
							."imb.base as base, imb.img_baseid as baseid "
							."FROM sammlung AS smg LEFT JOIN img_base imb ON smg.sammlungid = imb.sammlungid "
							."WHERE active = 1 AND base != '' ORDER BY sammlungid, baseid";
					$old_rs = $old_db->Execute( $sql );

					echo '<td>';
					if ($old_rs === false)
					{
						$failed = true;
						echo '<strong>No active collections where found</strong>';

					}
					else
					{
						echo ('<table width="100%" border="0" cellpadding="10" cellspacing="1">');
							echo ('<tr>');
								echo ('<td width="10%"><strong>&nbsp; #</strong></td>');
								echo ('<td width="40%"><strong>Name</strong></td>');
								echo ('<td width="20%"><strong>Place</strong></td>');
								echo ('<td width="30%"><strong>Image directory</strong></td>');
							echo ('</tr>');

							while (!$old_rs->EOF)
							{
								echo ('<tr>');
									echo ('<td>');
									echo ('<input type="radio" name="old_baseid" value="'.$old_rs->fields['baseid'].'">'.$old_rs->fields['sammlungid'].":".$old_rs->fields['baseid'].'<br>');
									echo ('</td>');
									echo ('<td>');
									echo ($old_rs->fields['name']);
									echo ('</td>');
									echo ('<td>');
									echo ($old_rs->fields['sammlung_ort']);
									echo ('</td>');
									echo ('<td>');
									echo ($old_rs->fields['base']);
									echo ('</td>');
								echo ('</tr>');

								$old_rs->MoveNext();
							}
						echo ('</table>');
					}

					echo '</td>';
				?>
			</tr>
		</table>

		<table width="100%" border="0" cellpadding="10" cellspacing="1">
			<tr>
				<td bgcolor="#e8e8e8" colspan="2">
					<span class="title">Select the target collection</span>
				</td>
			</tr>
		</table>
		<table width="100%">
			<tr>
				<?php

					$sql = "SELECT col.collectionid AS collectionid, col.name AS name, col.sammlung_ort AS sammlung_ort, "
							."imb.base AS base, imb.img_baseid AS baseid "
							."FROM ".$ng_prefix."collection AS col "
							."LEFT JOIN ".$ng_prefix."img_base AS imb ON col.collectionid = imb.collectionid "
							."WHERE active = 1 AND base != '' "
							."ORDER BY collectionid, baseid";

					$ng_rs = $ng_db->Execute( $sql );

					if ($ng_rs === false)
					{
						$failed = true;
						echo '<strong>No active collections where found</strong>';

					}
					else
					{
						echo ('<table width="100%" border="0" cellpadding="10" cellspacing="1">');
							echo ('<tr>');
								echo ('<td width="10%"><strong>&nbsp; #</strong></td>');
								echo ('<td width="40%"><strong>Name</strong></td>');
								echo ('<td width="20%"><strong>Place</strong></td>');
								echo ('<td width="30%"><strong>Image directory</strong></td>');
							echo ('</tr>');

							while (!$ng_rs->EOF)
							{
								echo ('<tr>');
									echo ('<td>');
									echo ('<input type="radio" name="ng_baseid" value="'.$ng_rs->fields['baseid'].'">'.$ng_rs->fields['collectionid'].":".$ng_rs->fields['baseid'].'<br>');
									echo ('</td>');
									echo ('<td>');
									echo ($ng_rs->fields['name']);
									echo ('</td>');
									echo ('<td>');
									echo ($ng_rs->fields['sammlung_ort']);
									echo ('</td>');
									echo ('<td>');
									echo ($ng_rs->fields['base']);
									echo ('</td>');
								echo ('</tr>');

								$ng_rs->MoveNext();
							}
						echo ('</table>');
					}

					echo '</td>';
				?>
			</tr>
		</table>

		<input size="80"  name="ng_hostname" type="hidden" value="<?php echo ($ng_hostname); ?>"></input>
		<input  size="80" name="ng_username" type="hidden" value="<?php echo ($ng_username); ?>"></input>
		<input  size="80" name="ng_password" type="hidden"" value="<?php echo ($ng_password); ?>"></input>
		<input  size="80" name="ng_name" type="hidden"" value="<?php echo ($ng_name); ?>"></input>
		<input  size="80" name="ng_prefix" type="hidden" value="<?php echo ($ng_prefix); ?>"></input>
		<input size="80"  name="old_hostname" type="hidden" value="<?php echo ($old_hostname); ?>"></input>
		<input  size="80" name="old_username" type="hidden" value="<?php echo ($old_username); ?>"></input>
		<input  size="80" name="old_password" type="hidden" value="<?php echo ($old_password); ?>"></input>
		<input  size="80" name="old_name" type="hidden" value="<?php echo ($old_name); ?>"></input>

		<?php

		if (!$failed)
		{
			?>
			<table width="100%" border="0" cellpadding="10" cellspacing="1">
				<tr>
					<td width="48%">
						<strong>
							Please note that this migration tool will overwrite <br/>
							all changes to images in the target collection <br />
							that have been made since the last import!
						</strong>
						<input type="hidden" name="step" value="2">
					</td>
					<td width="52%">
						<input type="button" value="Proceed" onclick="submit()">
					</td>
				</tr>
			</table>
		<?php
		}

		$old_db->Close();
		$ng_db->Close();

	}
	elseif (2 == $step) {

		?>

		<table width="100%" border="0" cellpadding="10" cellspacing="1">
			<tr>
				<td bgcolor="#e8e8e8" colspan="2">
					<span class="title">Checking directories</span>
				</td>
			</tr>

			<tr>
				<td bgcolor="#ffffff">
					Source directory exists
				</td>

				<?php
					$old_db = NewADOConnection("mysql");
					$old_res = $old_db->NConnect( $old_hostname, $old_username, $old_password, $old_name);
					$old_db->SetFetchMode(ADODB_FETCH_ASSOC);


					$sql = "SELECT smg.sammlungid as sammlungid, smg.name as name, smg.sammlung_ort as sammlung_ort, "
							."imb.base as base, imb.img_baseid AS baseid "
							."FROM sammlung AS smg LEFT JOIN img_base imb ON smg.sammlungid = imb.sammlungid "
							."WHERE imb.img_baseid = ".$old_db->qstr($_REQUEST['old_baseid']);
					$rs = $old_db->Execute( $sql );

					$olddir_exists = is_dir($rs->fields["base"]);

					$old_collection = $rs->fields['sammlungid'];
					$old_baseid = $_REQUEST['old_baseid'];

					echo '<td ';
					if ( $olddir_exists === false ) {
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
			<tr>
				<td bgcolor="#ffffff">
					Destination directory exists and is writeable
				</td>

				<?php
					$ng_db = NewADOConnection("mysql");
					$ng_res = $ng_db->NConnect( $ng_hostname, $ng_username, $ng_password, $ng_name);

					$ng_db->SetFetchMode(ADODB_FETCH_ASSOC);

					$sql = "SELECT col.collectionid AS collectionid, col.name AS name, col.sammlung_ort AS sammlung_ort, "
							." imb.base AS base, imb.img_baseid AS baseid "
							."FROM ".$ng_prefix."collection AS col "
							."LEFT JOIN ".$ng_prefix."img_base AS imb ON col.collectionid = imb.collectionid "
							."WHERE imb.img_baseid = ".$ng_db->qstr($_REQUEST['ng_baseid']);
					$rs = $ng_db->Execute( $sql );

					$ngdir_exists = @is_dir($rs->fields["base"]);
					$ngdir_writeable = @fopen( $rs->fields['base'] . DIRECTORY_SEPARATOR . 'test.txt', 'w+' );

					$ng_collection = $rs->fields['collectionid'];
					$ng_baseid = $_REQUEST['ng_baseid'];

					echo '<td ';
					if ( false !== ($ngdir_exists && $ngdir_writeable) ) {
						echo 'bgcolor="green">GOOD';
						fclose( $ngdir_writeable);
						@unlink( $rs->fields['base'] . DIRECTORY_SEPARATOR . 'test.txt');
					} else {
						echo 'bgcolor="red">BAD';
						$failed = true;
					}
					echo '</td>';

				?>

			</tr>
		</table>

		<input size="80"  name="ng_hostname" type="hidden" value="<?php echo ($ng_hostname); ?>"></input>
		<input  size="80" name="ng_username" type="hidden" value="<?php echo ($ng_username); ?>"></input>
		<input  size="80" name="ng_password" type="hidden"" value="<?php echo ($ng_password); ?>"></input>
		<input  size="80" name="ng_name" type="hidden"" value="<?php echo ($ng_name); ?>"></input>
		<input  size="80" name="ng_prefix" type="hidden" value="<?php echo ($ng_prefix); ?>"></input>
		<input size="80"  name="old_hostname" type="hidden" value="<?php echo ($old_hostname); ?>"></input>
		<input  size="80" name="old_username" type="hidden" value="<?php echo ($old_username); ?>"></input>
		<input  size="80" name="old_password" type="hidden" value="<?php echo ($old_password); ?>"></input>
		<input  size="80" name="old_name" type="hidden" value="<?php echo ($old_name); ?>"></input>
		<input  size="80" name="old_collection" type="hidden" value="<?php echo ($old_collection); ?>"></input>
		<input  size="80" name="ng_collection" type="hidden" value="<?php echo ($ng_collection); ?>"></input>
		<input  size="80" name="old_baseid" type="hidden" value="<?php echo ($old_baseid); ?>"></input>
		<input  size="80" name="ng_baseid" type="hidden" value="<?php echo ($ng_baseid); ?>"></input>

			<?php
			if (!$failed)
			{
				?>
				<table width="100%" border="0" cellpadding="10" cellspacing="1">
					<tr>
						<td>
							<input type="hidden" name="step" value="3">
							<input type="button" value="Proceed" onclick="submit()">
						</td>
					</tr>
				</table>

			<?php
			}

			$old_db->Close();
			$ng_db->Close();

		}
		elseif (3 == $step) {


			$old_db = NewADOConnection("mysql");
			$old_res = $old_db->NConnect( $old_hostname, $old_username, $old_password, $old_name);
			$old_db->SetFetchMode(ADODB_FETCH_ASSOC);

			// $old_db->debug = true;

			$ng_db = NewADOConnection("mysql");
			$ng_res = $ng_db->NConnect( $ng_hostname, $ng_username, $ng_password, $ng_name);
			$ng_db->SetFetchMode(ADODB_FETCH_ASSOC);

			// $ng_db->debug = true;

			// get old image base and image table

			$sql = "SELECT smg.sammlungid as sammlungid, smg.tabelle as tabelle, imb.base as base, imb.img_baseid AS baseid "
					."FROM sammlung AS smg LEFT JOIN img_base imb ON smg.sammlungid = imb.sammlungid "
					."WHERE imb.img_baseid = ".$old_db->qstr($_REQUEST['old_baseid']);
			$rs = $old_db->Execute( $sql );

			$old_table = $rs->fields['tabelle'];

			$old_img_dir = $rs->fields['base'];

			// get new image base

			$sql3 = "SELECT col.collectionid AS collectionid, col.name AS name, col.sammlung_ort AS sammlung_ort, imb.base AS base, imb.img_baseid AS baseid "
							."FROM ".$ng_prefix."collection AS col "
							."LEFT JOIN ".$ng_prefix."img_base AS imb ON col.collectionid = imb.collectionid "
							."WHERE imb.img_baseid = ".$ng_db->qstr($_REQUEST['ng_baseid']);
			$rs3 = $ng_db->Execute( $sql3 );

			$new_img_dir = $rs3->fields['base'];

			// clear information in target image tables (img, meta) for the selected
			// collection and baseid

			//			$sql4 	= 	"DELETE img.*, meta.* FROM "
			//						."{$ng_prefix}img as img LEFT JOIN {$ng_prefix}meta as meta ON "
			//						."(img.collectionid = meta.collectionid AND img.imageid = meta.imageid) "
			//						."WHERE "
			//						."(img.collectionid = ".$ng_db->qstr($_REQUEST['ng_collection'])." AND "
			//						."img.img_baseid = ".$ng_db->qstr($_REQUEST['ng_baseid']).")";
			//			$rs4 	= 	$ng_db->Execute( $sql4 );
			//
			//			echo ("Clearing target images tables: ");
			//			if ($rs4){
			//				echo ("OK\n<br>\n");
			//			}
			//			else {
			//				echo ("<b>Failed</b>\n<br>\n");
			//				echo ("SQL: $sql4\n<br>\n");
			//				echo ("\n<br>\n");
			//			}

			// get the entries to import from the old database

			$sql2 = "SELECT ".$old_table.".*, bild.* "
					."FROM ".$old_table." INNER JOIN ".$old_table."_bild "
					."ON ".$old_table.".bildnr = ".$old_table."_bild.bildnr "
					."INNER JOIN bild ON ".$old_table."_bild.bildid = bild.bildid "
					."WHERE bild.img_baseid = ".$old_db->qstr($_REQUEST['old_baseid'])." ORDER BY bild.bildid ";

			$rs2 = $old_db->Execute( $sql2 );

			$num_results = $rs2->MaxRecordCount();

			echo ("Loading old database entries: ");
			if ($rs2){
				echo ("OK ({$num_results} entries)\n<br>\n");
			}
			else {
				echo ("<b>Failed</b>\n<br>\n");
				echo ("SQL: $sql2\n<br>\n");
				echo ("\n<br>\n");
			}

			// echo "$sql2\n";

			// insert converted entries

			while( !$rs2->EOF )
			{
				echo ("\n<br>\n<em>Database entry (".$_REQUEST['ng_collection'].":".$rs2->fields['bildid']."):</em>\n<br>\n");

				echo ("Deleting old image data:\n");
				$sql4   =   "DELETE FROM {$ng_prefix}img WHERE "
				            ."collectionid=".$ng_db->qstr($_REQUEST['ng_collection'])
				            ." AND imageid=".$ng_db->qstr($rs2->fields['bildid']);

        $rs4    =   $ng_db->Execute($sql4);
				if ($rs4){
	        echo ("OK \n<br>\n");
	      }
	      else {
	        echo ("<b>Failed</b>\n<br>\n");
	        echo ("SQL: $sql4\n<br>\n");
	        echo ("\n<br>\n");
	      }

			  echo ("Deleting old meta data:\n");
        $sql4   =   "DELETE FROM {$ng_prefix}meta WHERE "
                    ."collectionid=".$ng_db->qstr($_REQUEST['ng_collection'])
                    ." AND imageid=".$ng_db->qstr($rs2->fields['bildid']);

        $rs4    =   $ng_db->Execute($sql4);
        if ($rs4){
          echo ("OK \n<br>\n");
        }
        else {
          echo ("<b>Failed</b>\n<br>\n");
          echo ("SQL: $sql4\n<br>\n");
          echo ("\n<br>\n");
        }

				echo ("\n<br>\n<em>Inserting new entry:</em>\n<br>\n");
				migrate_insert_meta($_REQUEST['ng_collection'], $_REQUEST['ng_baseid'], $rs2->fields, $ng_db, $ng_prefix, $old_db );

				$rs2->MoveNext();
			}

			// insert all old groups

			//			$old_db->debug = true;
			//			$ng_db->debug = true;

			echo ("\n<br>\n<em>Copying group data:</em>\n<br>\n");

			$sql4 = "SELECT groupsid, owner, name FROM `groups` WHERE 1";
			$rs4 = $old_db->Execute( $sql4 );

			while( !$rs4->EOF)
			{
			  echo ("\n<br>\n<em>Copying group:</em>".$rs4->fields['groupsid']."\n<br>\n");

			  // clear old groups (assuming id is equal)

  			$sql5  = "DELETE FROM ".$ng_prefix."group WHERE id=".$ng_db->qstr($rs4->fields['groupsid']);
  			$rs5   = $ng_db->Execute( $sql5 );

  			echo ("Deleting old group ".$rs4->fields['groupsid']." from target table: ");
  			if ($rs5){
  				echo ("OK\n<br>\n");
  			}
  			else {
  				echo ("<b>Failed</b>\n<br>\n");
  			}

  			$sql5 = "DELETE FROM ".$ng_prefix."img_group WHERE groupid=".$ng_db->qstr($rs4->fields['groupsid']);
  			$rs5 = $ng_db->Execute( $sql5 );

  			echo ("Deleting content for old group ".$rs4->fields['groupsid']." from target table: ");
  			if ($rs5){
  				echo ("OK\n<br>\n");
  			}
  			else {
  				echo ("<b>Failed</b>\n<br>\n");
  			}

				migrate_insert_group($rs4->fields['groupsid'],$rs4->fields['name'],'public',0,$ng_db,$ng_prefix);
				$rs4->MoveNext();

				// transfer the group content (imageid's) to new groups (only for images for which we
	      // have db entries

	      $sql5   =    "SELECT g.groupsid as groupsid, g.bildid as bildid FROM `groups_bild` as g, `"
	                   .$old_table."_bild` as b WHERE "
	                   ."g.bildid = b.bildid AND g.groupsid=".$old_db->qstr($rs4->fields['groupsid']);
	      $rs5    =    $old_db->Execute( $sql5 );

	      echo ("Transferring new content for group ".$rs4->fields['groupsid']." to target table: ");

	      while( !$rs5->EOF)
	      {
	        migrate_insert_into_group($rs5->fields['groupsid'],$_REQUEST['ng_collection'],$rs5->fields['bildid'],$ng_db,$ng_prefix);
	        $rs5->MoveNext();
	      }
			}

			// database updates done, copy files

			echo ("\n<br>\n<em>Database conversion complete.</em>\n<br>\n");

			echo ("\n<br>\n<em>Your old files will now be copied (this can take very long, depending on the number of files that are copied).</em>\n<br>\n");
			// echo ("\n<br>\n<em>(messages about files that have already been copied in earlier import sessions, will be suppressed)</em>\n<br>\n");
			echo ("\n<br>\n");

			echo ("Source directory: ".$old_img_dir.DIRECTORY_SEPARATOR."\n<br>\n");
			echo ("Target directory: ".$new_img_dir.DIRECTORY_SEPARATOR."\n<br>\n");

			$resolutions = array(
				"0"	=>	"120x90",
				"1"	=>	"640x480",
				"2"	=>	"800x600",
				"3"	=>	"1024x768",
				"4"	=>	"1280x1024",
				"5"	=>	"1600x1200"
			);

			// reuse the results from above and copy all corresponding files

			$rs2->MoveFirst();

			while (!$rs2->EOF) {

				$collectionid = $_REQUEST['ng_collection'];
				$imageid = $rs2->fields['bildid'];

				echo ("\n<br>\n<em>Copying image for entry (".$collectionid.":".$imageid.").</em>\n<br>\n");

				$source = 'cache'.DIRECTORY_SEPARATOR.'<em>resolution</em>'.DIRECTORY_SEPARATOR.$imageid.'.jpg';
				$target = $new_img_dir.DIRECTORY_SEPARATOR.'cache'.DIRECTORY_SEPARATOR.'<em>resolution</em>'.DIRECTORY_SEPARATOR.$collectionid.'-'.$imageid.'.jpg';

				$test_new_file = $new_img_dir.DIRECTORY_SEPARATOR.'cache'.DIRECTORY_SEPARATOR.'1600x1200'.DIRECTORY_SEPARATOR.$collectionid.'-'.$imageid.'.jpg';

				if (file_exists($test_new_file))
        {
          echo ("Already copied\n<br>\n");
        }
        else
        {
          foreach ($resolutions as $res) {

            $old_file = $old_img_dir.DIRECTORY_SEPARATOR.'cache'.DIRECTORY_SEPARATOR.$res.DIRECTORY_SEPARATOR.$imageid.'.jpg';
            $new_file = $new_img_dir.DIRECTORY_SEPARATOR.'cache'.DIRECTORY_SEPARATOR.$res.DIRECTORY_SEPARATOR.$collectionid.'-'.$imageid.'.jpg';

            /*
            echo ("Res:".$res."\n<br>\n");
            echo ("Old: ".$old_file."\n<br>\n");
            echo ("New: ".$new_file."\n<br>\n");
            */

            echo ($res.": ");

            if (file_exists($old_file))
            {
              $ret = @copy($old_file,$new_file);

              if (!$ret) {
                echo ("<b>Copying failed!</b>");
              } else {
                echo ("Copying succesful");
              }
            }
            else
            {
              echo ("<b>Failed!</b> (Source not found)\n<br>\n");
              echo ("<em>Expected filepath was</em>: ".$old_file."\n<br>\n");
            }
            echo ("\n<br>\n");
          }
        }

				$rs2->MoveNext();
			}

			$old_db->Close();
			$ng_db->Close();

			?>

			<table width="100%" border="0" cellpadding="10" cellspacing="1">
				<tr>
					<td>
						<strong>
							Your collection has been migrated to your new DILPS.<br>
							See above output for detail.
						</strong>
					</td>
				</tr>
				<tr>
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
