<?php
/*      
   +----------------------------------------------------------------------+
   | DILPS - Distributed Image Library System                             |
   +----------------------------------------------------------------------+
   | Copyright (c) 2002-2004 Juergen Enge                                 |
   | juergen@info-age.net                                                 |
   | http://www.dilps.net                                                 |
   |                                                                      |
   | This admin/install tool is based upon                                |
   | Mantis - a php based bugtracking system                              |
   | Copyright (C) 2000 - 2002  Kenzaburo Ito                             |
   |    kenito@300baud.org                                                |
   | Copyright (C) 2002 - 2004  Mantis Team                               |
   |   mantisbt-dev@lists.sourceforge.net                                 |
   |                                                                      |
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
*/
	$g_absolute_path	= dirname(dirname( __FILE__ )) . DIRECTORY_SEPARATOR;
	define( 'BAD', 0 );
	define( 'GOOD', 1 );
	$g_failed = false;
	
	function getPost($postd) {
	  if (isset($_POST[$postd])) 
	    return $_POST[$postd];
	  else 
	    return '';  
	}
	
	function print_test_result( $p_result, $p_hard_fail=true, $p_message='' ) {
		global $g_failed;
		echo '<td ';
		if ( BAD == $p_result ) {
			if ( $p_hard_fail ) {
				$g_failed = true;
				echo 'bgcolor="red">BAD';
			} else {
				echo 'bgcolor="pink">BAD';
			}
		}

		if ( GOOD == $p_result ) {
			echo 'bgcolor="green">GOOD';
		}
		if ( '' !== $p_message ) {
			echo '<br />' . $p_message;
		}
		echo '</td>';
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
        Change settings
		</td>
	</tr>
</table>
<br /><br />
<table width="100%" bgcolor="#222222" border="0" cellpadding="10" cellspacing="1">
<tr>
	<td bgcolor="#e8e8e8" colspan="2">
		<span class="title">Checking Installation...</span>
	</td>
</tr>

<!-- Check Php Version -->
<tr>
	<td bgcolor="#ffffff">
		Checking  PHP Version (Your version is <?php echo phpversion(); ?>)
	</td>
	<?php
		if (phpversion() == '4.0.6') {
			print_test_result( GOOD );
		} else {
			if ( function_exists ( 'version_compare' ) ) {
				if ( version_compare ( phpversion() , '4.0.6', '>=' ) ) {
					print_test_result( GOOD );
				} else {
					print_test_result( BAD );
				}
			} else {
			 	print_test_result( BAD );
			}
		}
	?>
</tr>

<tr>
	<td bgcolor="#ffffff">
		Checking config file
	</td>
	<?php
		if (file_exists( $g_absolute_path . DIRECTORY_SEPARATOR . 'config.inc.php' ))	 {
			print_test_result( GOOD );
			require_once($g_absolute_path . DIRECTORY_SEPARATOR . 'config.inc.php');
			$f_includepath = $config['includepath'];
		} else {
			print_test_result( BAD );
		}
	?>
</tr>

<!-- Setting config variables -->
<tr>
	<td bgcolor="#ffffff">
		AdoDB
	</td>
	<?php
	  if (!empty($f_includepath) && file_exists($f_includepath.DIRECTORY_SEPARATOR.'adodb/adodb.inc.php')) {
		if (!empty($f_includepath) && file_exists($f_includepath.DIRECTORY_SEPARATOR.'adodb/adodb.inc.php')) 
	    require_once($f_includepath.DIRECTORY_SEPARATOR.'adodb/adodb.inc.php');
	    print_test_result( GOOD );
	  } else {
		print_test_result( BAD );
	  }
	?>
</tr>
<tr>
	<td bgcolor="#ffffff">
		Attempting to connect to database as user
	</td>
	<?php
		$g_db = @ADONewConnection('mysql');
		$t_result = @$g_db->Connect($db_host, $db_user, $db_pwd, $db_db);
		
		if ( $t_result == true ) {
			print_test_result( GOOD );

			$sql = "SELECT * FROM {$db_prefix}config";
            $result = $g_db->Execute( $sql );
            while( !$result->EOF ) {
              $name = $result->fields["name"];
              $config[$name] = $result->fields["val"];
              $result->MoveNext();
           } 

		} else {
			print_test_result( BAD);
		}
	?>
</tr>
</table>
<br>
<?php
  $status = 0;
 
 $dowrite = getPost('write');
 if (!empty($dowrite)) 
   $status = 1;
?>
 
<?php if ($status == 0) {

	$f_includepath = $config['includepath'];
	$f_hostname        = $db_host;
    $f_db_username     = $db_user;
    $f_db_password     = $db_pwd;
    $f_database_name   = $db_db;
    $f_db_prefix       = $db_prefix;
    $f_smartybasepath  = $config['smartyBase']; 
    $f_smartyskin      = $config['skinBase'];  
    $f_upload          = $config['uploaddir'];
    $f_authdomain      = $config['authdomain']; 
    $f_ldapserver      = $config['ldapserver'];
    $f_userclass       = $config['userClass']; 
?>

<form method='POST'>
<table width="100%" border="0" cellpadding="10" cellspacing="1">
<tr>
	<td bgcolor="#e8e8e8" colspan="2">
		<span class="title">Installation Options</span>
	</td>
</tr>

<tr>
	<td>
		Type of Database
	</td>
	<td>
		<select name="db_type">
		<option value="mysql">MySql (default)</option>
	</td>
</tr>

<tr>
	<td>
		Hostname (for Database Server)
	</td>
	<td>
		<input size="80"  name="hostname" type="textbox" value="<?php echo (!empty($f_hostname ) ? $f_hostname : $t_hostname ); ?>"></input>
	</td>
</tr>

<tr>
	<td>
		Username (for Database)
	</td>
	<td>
		<input  size="80" name="db_username" type="textbox" value="<?php echo (!empty($f_db_username ) ? $f_db_username : $t_db_username ); ?>"></input>
	</td>
</tr>

<tr>
	<td>
		Password (for Database)
	</td>
	<td>
		<input  size="80" name="db_password" type="password" value="<?php echo (!empty($f_db_password ) ? $f_db_password : $t_db_password ); ?>"></input>
	</td>
</tr>

<tr>
	<td>
		Database name (for Database)
	</td>
	<td>
		<input  size="80" name="database_name" type="textbox" value="<?php echo (!empty($f_database_name ) ? $f_database_name : $t_database_name ); ?>"></input>
	</td>
</tr>

<tr>
	<td>
	  Table prefix (for Database)
	</td>
	<td>
		<input  size="80" name="db_prefix" type="textbox" value="<?php echo (!empty($f_db_prefix ) ? $f_db_prefix : $t_db_prefix ); ?>"></input>
	</td>
</tr>


<tr>
	<td bgcolor="#e8e8e8" colspan="2">
		<span class="title">Directories</span>
	</td>
</tr>
<tr>
	<td>
		Include directory path
	</td>
	<td>
		<input size="80"  name="includepath" type="textbox" value="<?php echo ( ( !empty($f_includepath) ) ? $f_includepath : $t_includepath ); ?>"></input>
	</td>
</tr>

<tr>
	<td>
		Smarty base path
	</td>
	<td>
		<input  size="80" name="smartybasepath" type="textbox" value="<?php echo ( ( !empty($f_smartybasepath) ) ? $f_smartybasepath : $t_smartybasepath ); ?>"></input>
	</td>
</tr>

<tr>
	<td>
		Smarty skin path
	</td>
	<td>
		<input size="80"  name="smartyskin" type="textbox" value="<?php echo ( ( !empty($f_smartyskin) ) ? $f_smartyskin : $t_smartyskin ); ?>"></input>
	</td>
</tr>

<tr>
	<td>
		Upload directory
	</td>
	<td>
		<input size="80"  name="upload" type="textbox" value="<?php echo ( ( !empty($f_upload) ) ? $f_upload : $t_upload ); ?>"></input>
	</td>
</tr>


<tr>
	<td bgcolor="#e8e8e8" colspan="2">
		<span class="title">Other (usually you do not need to change this settings)</span>
	</td>
</tr>
<tr>
	<td>
		authdomain
	</td>
	<td>
		<input size="80"  name="authdomain" type="textbox" value="<?php echo ( ( !empty($f_authdomain) ) ? $f_authdomain : $t_authdomain ); ?>"></input>
	</td>
</tr>
<tr>
	<td>
		ldap server
	</td>
	<td>
		<input size="80"  name="ldapserver" type="textbox" value="<?php echo ( ( !empty($f_ldapserver) ) ? $f_ldapserver : $t_ldapserver ); ?>"></input>
	</td>
</tr>
<tr>
	<td>
		user class
	</td>
	<td>
		<input size="80"  name="userclass" type="textbox" value="<?php echo ( ( !empty($f_userclass) ) ? $f_userclass : $t_userclass ); ?>"></input>
	</td>
</tr>


<tr>
	<td>
		Attempt Installation
	</td>
	<td>
		<input name="write" type="submit" value="Change settings"></input>
	</td>
</tr>
</table>

<?php } ?>

<?php if ($status == 1) { 
	$f_includepath = getPost('includepath');
	$f_smartybasepath = getPost('smartybasepath');
	$f_smartylang = getPost('smartylang');
	$f_smartyskin = getPost('smartyskin');
	$f_authdomain = getPost('authdomain');
	$f_ldapserver = getPost('ldapserver');
	$f_userclass = getPost('userclass');
	$f_db_prefix = getPost('db_prefix');
	$f_upload = getPost('upload');
	$f_db_username   = getPost('db_username'); 
	$f_db_password   = getPost('db_passwort');
	$f_database_name = getPost('database_name');
	$f_hostname      = getPost('hostname');

	$g_config_db_entry = array();
      
    $g_config_db_entry['authdomain'] = $f_authdomain;
    $g_config_db_entry['ldapserver'] = $f_ldapserver;
    $g_config_db_entry['userClass'] = $f_userclass;
    $g_config_db_entry['uploaddir'] = $f_upload;
    $g_config_file_entry['$db_prefix'] = '\''.$f_db_prefix.'\'';
    $g_config_file_entry['$config[\'includepath\']'] = '\''.$f_includepath.'\'';
    $g_config_file_entry['$db_host'] = '\''.$f_hostname.'\'';
    $g_config_file_entry['$db_user'] = '\''.$f_db_username.'\'';
    $g_config_file_entry['$db_pwd'] = '\''.$f_db_password.'\'';
    $g_config_file_entry['$db_db'] = '\''.$f_database_name.'\'';
    
?>
<table width="100%" border="0" cellpadding="10" cellspacing="1">
<tr>
	<td bgcolor="#e8e8e8" colspan="2">
		<span class="title">Create configuration</span>
	</td>
</tr>
<tr>
	<td bgcolor="#ffffff">
		Creating Config File
	</td>
	<?php
			$fd = fopen($g_absolute_path.DIRECTORY_SEPARATOR.'config.inc.php','w+');
			fwrite($fd, '<?php'."\r\n");
			foreach ( $g_config_file_entry as $key => $value) {
				fwrite($fd,$key.'='.$value.";\r\n");
			}
			fwrite($fd, '?>'."\r\n");

			fclose($fd);
			if ( file_exists ( $g_absolute_path .DIRECTORY_SEPARATOR.'config.inc.php' ) ) {
				print_test_result( GOOD );
			} else {
				print_test_result( BAD );
			}
	?>
</tr>
<tr>
	<td bgcolor="#ffffff">
		Creating Config Database entries
	</td>
	<?php 
	 $ret = true;
	
	 foreach ( $g_config_db_entry as $key => $value) {
	  $sqlstatement = 'delete from '.$f_db_prefix.'config where name=\''.$key.'\';';
	  $g_db->Execute($sqlstatement);
	 
	  if (get_magic_quotes_gpc()) {
        $value = stripslashes($value);
      }
   	
	  $sqlstatement = 'insert into '.$f_db_prefix.'config (name, val) values (\''.$key.'\',\''.mysql_real_escape_string($value).'\');';
	  if (!empty($sqlstatement)) {
	  $sret = $g_db->Execute($sqlstatement);  
	  $ret = $ret && $sret;
	 }
	 }
	 
 	if ( $ret != FALSE ) {
	print_test_result( GOOD );
	} else {
	print_test_result( BAD);
	}  
	?> 
</tr>

</table>

<p align="center">
[ <a href="index.php">Back to Administration</a> ]
</p>
	
<?php } 
$g_db->close();
?>

</body>
</html>