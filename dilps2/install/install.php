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

	# Mantis - a php based bugtracking system
	# Copyright (C) 2000 - 2002  Kenzaburo Ito - kenito@300baud.org
	# Copyright (C) 2002 - 2004  Mantis Team   - mantisbt-dev@lists.sourceforge.net
	# This program is distributed under the terms and conditions of the GPL
	# See the README and LICENSE files for details

	# --------------------------------------------------------
	# $Id: install.php,v 1.3 2006/06/19 12:13:47 fabtho Exp $
	# --------------------------------------------------------
?>
<?php
	error_reporting( E_ALL );

	//@@@ put this somewhere
	set_time_limit ( 0 ) ;
	$g_skip_open_db = true;

	// Path to html dir
	$g_absolute_path	= dirname(dirname( __FILE__ )) . DIRECTORY_SEPARATOR;
	$g_absolute_path2	= dirname(dirname(dirname( __FILE__ ))) . DIRECTORY_SEPARATOR;
	$g_absolute_path3	= dirname(dirname(dirname(dirname( __FILE__ )))) . DIRECTORY_SEPARATOR;

	define( 'BAD', 0 );
	define( 'GOOD', 1 );
	$g_failed = false;

	# Strip slashes if necessary (supports arrays)
	function gpc_strip_slashes( $p_var ) {
		if ( 0 == get_magic_quotes_gpc() ) {
			return $p_var;
		} else if ( !is_array( $p_var ) ){
			return stripslashes( $p_var );
		} else {
			foreach ( $p_var as $key => $value ) {
				$p_var[$key] = gpc_strip_slashes( $value );
			}
			return $p_var;
		}
	}

		function ini_get_bool( $p_name ) {
		$result = ini_get( $p_name );

		if ( is_string( $result ) ) {
			switch ( $result ) {
				case 'off':
				case 'false':
				case 'no':
				case 'none':
				case '':
				case '0':
					return false;
					break;
				case 'on':
				case 'true':
				case 'yes':
				case '1':
					return true;
					break;
			}
		} else {
			return (bool)$result;
		}
	}
		# ---------------
	# Retrieve a GPC variable.
	# If the variable is not set, the default is returned.
	# If magic_quotes_gpc is on, slashes will be stripped from the value before being returned.
	#
	#  You may pass in any variable as a default (including null) but if
	#  you pass in *no* default then an error will be triggered if the field
	#  cannot be found
	function gpc_get( $p_var_name, $p_default = null ) {
  	    global $_POST, $_GET;

		if ( isset( $_POST[$p_var_name] ) ) {
			$t_result = gpc_strip_slashes( $_POST[$p_var_name] );
		} else if ( isset( $_GET[$p_var_name] ) ) {
			$t_result = gpc_strip_slashes( $_GET[$p_var_name] );
		} else if ( func_num_args() > 1 ) { #check for a default passed in (allowing null)
			$t_result = $p_default;
		} else {
			error_parameters( $p_var_name );
			trigger_error( ERROR_GPC_VAR_NOT_FOUND, ERROR );
			$t_result = null;
		}

		return $t_result;
	}
	# -----------------
	# Retrieve a string GPC variable. Uses gpc_get().
	#  If you pass in *no* default, an error will be triggered if
	#  the variable does not exist
	function gpc_get_string( $p_var_name, $p_default = null ) {
		# Don't pass along a default unless one was given to us
		#  otherwise we prevent an error being triggered
		$args = func_get_args();
		$t_result = call_user_func_array( 'gpc_get', $args );

		if ( is_array( $t_result ) ) {
			error_parameters( $p_var_name );
			trigger_error( ERROR_GPC_ARRAY_UNEXPECTED, ERROR );
		}

		return $t_result;
	}
	# ------------------
	# Retrieve an integer GPC variable. Uses gpc_get().
	#  If you pass in *no* default, an error will be triggered if
	#  the variable does not exist
	function gpc_get_int( $p_var_name, $p_default = null ) {
		# Don't pass along a default unless one was given to us
		#  otherwise we prevent an error being triggered
		$args = func_get_args();
		$t_result = call_user_func_array( 'gpc_get', $args );

		if ( is_array( $t_result ) ) {
			error_parameters( $p_var_name );
			trigger_error( ERROR_GPC_ARRAY_UNEXPECTED, ERROR );
		}
		$t_val = str_replace( " ", "", trim( $t_result ) );
		if ( ! preg_match( "/^-?([0-9])*$/", $t_val ) ) {
			error_parameters( $p_var_name );
			trigger_error( ERROR_GPC_NOT_NUMBER, ERROR );
		}

		return (int)$t_val;
	}
	# ------------------
	# Retrieve a boolean GPC variable. Uses gpc_get().
	#  If you pass in *no* default, false will be used
	function gpc_get_bool( $p_var_name, $p_default = false ) {
		$t_result = gpc_get( $p_var_name, $p_default );

		if ( $t_result === $p_default ) {
			return $p_default;
		} else {
			if ( is_array( $t_result ) ) {
				error_parameters( $p_var_name );
				trigger_error( ERROR_GPC_ARRAY_UNEXPECTED, ERROR );
			}

			return gpc_string_to_bool( $t_result );
		}
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

	function determine_path($filetofind, $pathtoadd) {
	  global $g_absolute_path3;
	  global $g_absolute_path2;
	  global $g_absolute_path;

	  if (file_exists($g_absolute_path3.$filetofind))
	  {
	  	return $g_absolute_path3.$pathtoadd.DIRECTORY_SEPARATOR;
	  }

	  if (file_exists($g_absolute_path2.$filetofind))
	  {
	    return $g_absolute_path2.$pathtoadd.DIRECTORY_SEPARATOR;
	  }

	  if (file_exists($g_absolute_path.$filetofind))
	  {
	    return $g_absolute_path.$pathtoadd.DIRECTORY_SEPARATOR;
	  }

	  return 'not found. Please enter.';
	}

	//temporary default values
	$t_hostname = 'localhost';
	$t_database_name = 'DILPS';
	$t_db_username = '';
	$t_db_password = '';
	$t_db_prefix = 'ng_';
	$t_authdomain = 'static';
	$t_ldapserver = 'localhost';
	$t_userclass  = 'authStaticUser';
	$t_includepath = 'not found. Please enter.';
	$t_smartybasepath= 'not found. Please enter.';
//	$t_smartylang = 'not found. Please enter.';
	$t_smartyskin = 'not found. Please enter.';
	$t_upload     = 'not found. Please enter.';
//	$t_backup = 'not found. Please enter.';
	$t_export = 'not found. Please enter.';
	$t_dilps = 'not found. Please enter.';

    $t_includepath = determine_path('include'.DIRECTORY_SEPARATOR.'smarty.inc.php', 'include');
    $t_smartyskin = determine_path('skin','skin');
    $t_smartybasepath = determine_path('include'.DIRECTORY_SEPARATOR.'smarty'.DIRECTORY_SEPARATOR.'Smarty.class.php','include'.DIRECTORY_SEPARATOR.'smarty');
	$t_upload = determine_path('upload', 'upload');
	$t_export = determine_path('export', 'export');
	$t_dilps = determine_path('dilps', 'dilps');	
	
	# install_state
	#   0 = no checks done
	#   1 = server ok, get database information
	#   2 = check the database information
	#   3 = install the database
	#   5 = get additional config information
	#   4 = write the config file
	$t_install_state = gpc_get_int( 'install', 0 );

	$f_includepath = gpc_get_string('includepath','');
	$f_smartybasepath = gpc_get_string('smartybasepath','');
	$f_smartylang = gpc_get_string('smartylang','');
	$f_smartyskin = gpc_get_string('smartyskin','');
	$f_authdomain = gpc_get_string('authdomain','');
	$f_ldapserver = gpc_get_string('ldapserver','');
	$f_userclass = gpc_get_string('userclass','');
	$f_db_prefix = gpc_get_string('db_prefix','');
	$f_upload = gpc_get_string('upload','');
	$f_export = gpc_get_string('export','');
	$f_dilps = gpc_get_string('dilps','');

	$f_skin = 'default';
	$f_language = 'de';

//	$f_backup = gpc_get_string('backup','');

    $g_config_db_entry['authdomain'] = $f_authdomain;
    $g_config_db_entry['ldapserver'] = $f_ldapserver;
    $g_config_db_entry['userClass'] = $f_userclass;
    $g_config_db_entry['skin'] = $f_skin;
    $g_config_db_entry['language'] = $f_language;
    $g_config_db_entry['uploaddir'] = $f_upload;
	$g_config_db_entry['exportdir'] = $f_export;
	$g_config_db_entry['dilpsdir'] = $f_dilps;
    $g_config_file_entry['$db_prefix'] = '\''.$f_db_prefix.'\'';
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
			switch ( $t_install_state ) {
				case 5:
					echo "Install Configuration File";
					break;
				case 4:
					echo "Additional Configuration Information";
					break;
				case 3:
					echo "Install Database";
					break;
				case 2:
					echo "Check and Install Database";
					break;
				case 1:
					echo "Database Parameters";
					break;
				case 0:
				default:
					echo "Pre-Installation Check";
					break;
			}
		?>
		</td>
	</tr>
</table>
<br /><br />

<form method='POST'>
<?php
if ( 0 == $t_install_state ) {
?>
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

<!-- Check Safe Mode -->
<tr>
	<td bgcolor="#ffffff">
		Checking If Safe mode is enabled for install script
	</td>
	<?php
		if ( ! ini_get ( 'SAFE_MODE' ) ) {
			print_test_result( GOOD );
		} else {
			print_test_result( BAD );
		}
	?>
</tr>

<!-- Checking register_globals are off -->
<tr>
	<td bgcolor="#ffffff">
		Checking for register_globals are off for DILPS
	</td>
	<?php
		if ( ! ini_get_bool( 'register_globals' ) ) {
			print_test_result( GOOD );
		} else {
			print_test_result( BAD );
		}
	?>
</tr>

<!-- Checking config file is writable -->
<tr>
	<td bgcolor="#ffffff">
		Checking that configuration file can be created
	</td>
	<?php
		$t_fd = @fopen( $g_absolute_path . DIRECTORY_SEPARATOR . 'config.inc.php', 'w+' );
		//$t_fd = @fopen('c:/wamp/www/dilps/dilps/htdocs/globals.inc.php', 'w' );

		if ( false !== $t_fd ) {
			print_test_result( GOOD );
			fclose( $t_fd );
			@unlink( $g_absolute_path . DIRECTORY_SEPARATOR . 'config.inc.php' );
		} else {
			print_test_result( BAD );
		}
	?>
</tr>
</table>
<?php
	if ( false == $g_failed ) {
		$t_install_state++;
	}
} # end install_state == 0

# got database information, check and install
if ( 2 == $t_install_state ) {
?>

<table width="100%" border="0" cellpadding="10" cellspacing="1">
<tr>
	<td bgcolor="#e8e8e8" colspan="2">
		<span class="title">Check directories</span>
	</td>
</tr>
<tr>
	<td bgcolor="#ffffff">
		Smarty base directory
	</td>
	<?php
	  if ((!empty($f_smartybasepath)) && (file_exists($f_smartybasepath))) {
	  	$g_config_db_entry['smartyBase'] = $f_smartybasepath;
		print_test_result( GOOD );
	  } else {
		print_test_result( BAD );
	  }
	 ?>
</tr>
<!--
<tr>
	<td bgcolor="#ffffff">
		Smarty language directory
	</td>
	<?php /*
	  if ((!empty($f_smartylang)) && (file_exists($f_smartylang))) {
		print_test_result( GOOD );
	  } else {
		print_test_result( BAD );
	  } */
	 ?>
</tr>
--->
 <tr>
	<td bgcolor="#ffffff">
		Smarty skin directory
	</td>
	<?php
	  if ((!empty($f_smartyskin)) && (file_exists($f_smartyskin))) {
		print_test_result( GOOD );
		$g_config_db_entry['skinBase'] = $f_smartyskin;
	  } else {
		print_test_result( BAD );
	  }
	 ?>
</tr>
 <tr>
	<td bgcolor="#ffffff">
		Smarty template_c directory: <?php echo  $f_smartybasepath.'template_c'?> (must be writeable)
	</td>
	<?php
	  if ((!empty($f_smartybasepath)) && (file_exists($f_smartybasepath.'template_c')) && is_writable($f_smartybasepath.'template_c'))  {
		print_test_result( GOOD );
	  } else {
		print_test_result( BAD );
	  }
	 ?>
</tr>
 <tr>
	<td bgcolor="#ffffff">
		Smarty cache directory: <?php echo  $g_absolute_path.'cache'?> (must be writeable)
	</td>
	<?php
	  if ((!empty($g_absolute_path)) && (is_writable($g_absolute_path.'cache')))  {
		print_test_result( GOOD );
	  } else {
		print_test_result( BAD );
	  }
	 ?>
</tr>
 <tr>
	<td bgcolor="#ffffff">
		Upload directory: <?php echo  $f_upload ?> (must be writeable)
	</td>
	<?php
	  if ((!empty($f_upload)) && (is_writable($f_upload)))  {
		print_test_result( GOOD );
	  } else {
		print_test_result( BAD );
	  }
	 ?>
</tr>
 <tr>
	<td bgcolor="#ffffff">
		Export directory: <?php echo $f_export  ?>  (must be writeable)
	</td>
	<?php
	  if ((!empty($f_export)) && (is_writable($f_export)))  {
		print_test_result( GOOD );
	  } else {
		print_test_result( BAD );
	  }
	 ?>
</tr>
<tr>
	<td bgcolor="#ffffff">
		Dilps directory: <?php echo $f_dilps ?> (must be writeable)
	</td>
	<?php
	  if ((!empty($f_dilps)) && (is_writable($f_dilps)))  {
		print_test_result( GOOD );
	  } else {
		print_test_result( BAD );
	  }
	 ?>
</tr>

<tr>
	<td bgcolor="#e8e8e8" colspan="2">
		<span class="title">Check database options</span>
	</td>
</tr>

<!-- Setting config variables -->
<tr>
	<td bgcolor="#ffffff">
		AdoDB
	</td>
	<?php
	  if (!empty($f_includepath) && file_exists($f_includepath.DIRECTORY_SEPARATOR.'adodb/adodb.inc.php')) {
		print_test_result( GOOD );
		$g_config_file_entry['$config[\'includepath\']'] = '"'.addslashes($f_includepath).'"';
	  } else {
		print_test_result( BAD );
	  }
	  if (!empty($f_includepath) && file_exists($f_includepath.DIRECTORY_SEPARATOR.'adodb/adodb.inc.php'))
	    require_once($f_includepath.DIRECTORY_SEPARATOR.'adodb/adodb.inc.php')
	?>
</tr>
<tr>
	<td bgcolor="#ffffff">
		Setting Database Hostname
	</td>
	<?php
			$f_hostname = gpc_get('hostname', '');
			$g_config_file_entry['$db_host'] = '\''.$f_hostname.'\'';
			if ( '' !== $f_hostname ) {
				print_test_result( GOOD );
			} else {
				print_test_result( BAD );
			}
	?>
</tr>

<!-- Setting config variables -->
<tr>
	<td bgcolor="#ffffff">
		Setting Database Type
	</td>
	<?php
			$f_db_type = gpc_get('db_type', '');
			$g_config_entry['db_type'] = '\''.$f_db_type.'\'';
			if ( '' !== $f_db_type ) {
				print_test_result( GOOD );
			} else {
				print_test_result( BAD );
			}
	?>
</tr>

<!-- Checking DB support-->
<tr>
	<td bgcolor="#ffffff">
		Checking PHP support for database type
	</td>
	<?php
			$t_support = false;
			switch ($f_db_type) {
				case 'mysql':
					$t_support = function_exists('mysql_connect');
					break;
				default:
					$t_support = false;
			}

			if ( $t_support ) {
				print_test_result( GOOD );
			} else {
				print_test_result( BAD );
			}
	?>
</tr>

<!-- Setting config variables -->
<tr>
	<td bgcolor="#ffffff">
		Setting Database Username
	</td>
	<?php
			$f_db_username = gpc_get('db_username', '');
			$g_config_file_entry['$db_user'] = '\''.$f_db_username.'\'';
			if ( '' !== $f_db_username ) {
				print_test_result( GOOD );
			} else {
				print_test_result( BAD );
			}
	?>
</tr>

<!-- Setting config variables -->
<tr>
	<td bgcolor="#ffffff">
		Setting Database Password
	</td>
	<?php
			$f_db_password = gpc_get('db_password', '');
			$g_config_file_entry['$db_pwd'] = '\''.$f_db_password.'\'';
			if ( '' !== $f_db_password ) {
				print_test_result( GOOD );
			} else {
				print_test_result( BAD, false );
			}
	?>
</tr>

<!-- Setting config variables -->
<tr>
	<td bgcolor="#ffffff">
		Setting Database Name
	</td>
	<?php
			$f_database_name = gpc_get('database_name', '');
			$g_config_file_entry['$db_db'] = '\''.$f_database_name.'\'';
			if ( '' !== $f_database_name ) {
				print_test_result( GOOD );
			} else {
				print_test_result( BAD );
			}
	?>
</tr>

<!-- Setting config variables -->
<tr>
	<td bgcolor="#ffffff">
		Setting Admin Username
	</td>
	<?php
			$f_adm_username = gpc_get( 'admin_username', '' );
			if ( '' !== $f_adm_username ) {
				print_test_result( GOOD );
			} else {
				print_test_result( BAD );
			}
	?>
</tr>

<!-- Setting config variables -->
<tr>
	<td bgcolor="#ffffff">
		Setting Admin Password
	</td>
	<?php
			$f_adm_password = gpc_get( 'admin_password', '');
			if ( '' !== $f_adm_password ) {
				print_test_result( GOOD );
			} else {
				print_test_result( BAD, false );
			}
	?>
</tr>

<!-- Setting config variables -->
<tr>
	<td bgcolor="#ffffff">
		Attempting to connect to database as admin
	</td>
	<?php
		$g_db = ADONewConnection($f_db_type);
		$t_result = @$g_db->Connect($f_hostname, $f_adm_username, $f_adm_password);

		if ( $t_result == true ) {
			print_test_result( GOOD );
		} else {
			print_test_result( BAD );
		}
	?>
</tr>
<tr>
	<td bgcolor="#ffffff">
		Attempting to connect to database as user <br> (may fail if database doesn't exist yet)
	</td>
	<?php
		$g_db = ADONewConnection($f_db_type);
		$t_result = @$g_db->Connect($f_hostname, $f_db_username, $f_db_password, $f_database_name);

		if ( $t_result == true ) {
			print_test_result( GOOD );
		} else {
			print_test_result( BAD, false ); # may fail if db doesn't exist, will recheck later
		}
	?>
</tr>

<?php
	if ( false == $g_failed ) {
		$t_install_state++;
	}
} # end 2 == $t_install_state

# system checks have passed, get the database information
if ( 1 == $t_install_state ) {
?>

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
	<td>
		Admin Username (to create Database)
	</td>
	<td>
		<input  size="80" name="admin_username" type="textbox" value="<?php echo ( ( !empty($f_adm_username )) ? $f_adm_username : $t_db_username ); ?>"></input>
	</td>
</tr>

<tr>
	<td>
		Admin Password (to create Database)
	</td>
	<td>
		<input  size="80" name="admin_password" type="password" value="<?php echo ( ( !empty($f_adm_password) ) ? $f_adm_password : $t_db_password ); ?>"></input>
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
	<td>
		Export directory
	</td>
	<td>
		<input size="80"  name="export" type="textbox" value="<?php echo ( ( !empty($f_export) ) ? $f_export : $t_export ); ?>"></input>
	</td>
</tr>

<tr>
	<td>
		Dilps directory
	</td>
	<td>
		<input size="80"  name="dilps" type="textbox" value="<?php echo ( ( !empty($f_dilps) ) ? $f_dilps : $t_dilps ); ?>"></input>
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



<!--

<tr>
	<td>
		Language directory
	</td>
	<td>
		<input size="80"  name="smartylang" type="textbox" value="<?php echo ( ( !empty($f_smartylang) ) ? $f_smartylang : $t_smartylang ); ?>"></input>
	</td>
</tr>

<tr>
	<td>
		Backup directory
	</td>
	<td>
		<input size="80" name="backup" type="textbox" value="<?php echo ( ( !empty($f_backup) ) ? $f_backup : $t_backup ); ?>"></input>
	</td>
</tr>
--->
<tr>
	<td>
		Attempt Installation
	</td>
	<td>
		<input name="go" type="submit" value="Install Database"></input>
	</td>
</tr>
<input name="install" type="hidden" value="2"></input>

</table>
<?php
}  # end install_state == 1

# all checks have passed, install the database
if ( 3 == $t_install_state ) {
?>

<table width="100%" border="0" cellpadding="10" cellspacing="1">
<tr>
<tr>
	<td bgcolor="#e8e8e8" colspan="2">
		<span class="title">Install Database</span>
	</td>
</tr>

	<td bgcolor="#ffffff">
		Create database if it does not exist
	</td>
	<?php
		$t_result = @$g_db->Connect( $f_hostname, $f_adm_username, $f_adm_password, $f_database_name );

		if ( $t_result == true ) {
			print_test_result( GOOD );
		} else {
			// create db
			$g_db = ADONewConnection( $f_db_type );
			$t_result = $g_db->Connect( $f_hostname, $f_adm_username, $f_adm_password );	
			$dict = NewDataDictionary( $g_db );
			$sqlarray = $dict->CreateDatabase( $f_database_name );
			$ret = $dict->ExecuteSQLArray( $sqlarray );
			if( $ret == 2) {
				print_test_result( GOOD );
			} else {
				print_test_result( BAD );
			}
	}
	?>
</tr>
<tr>
	<td bgcolor="#ffffff">
		Attempting to connect to database as user
	</td>
	<?php
		$g_db = ADONewConnection($f_db_type);
		$t_result = @$g_db->Connect($f_hostname, $f_db_username, $f_db_password, $f_database_name);

		if ( $t_result == true ) {
			print_test_result( GOOD );
		} else {
			print_test_result( BAD );
		}
	?>
</tr>
<?php
	if ( false == $g_failed ) {
		$g_db = ADONewConnection( $f_db_type );
		$t_result = @$g_db->Connect( $f_hostname, $f_db_username, $f_db_password, $f_database_name );
?>
<tr>
	<td bgcolor="#ffffff">
		Create Schema
	</td>
<?php
            $sql = file_get_contents('schema.sql');
            $sqlarray = explode(';', $sql);
            $ret = TRUE;
            foreach ($sqlarray as $sqlstatement ) {
            if (!empty($sqlstatement)) {
              $sqlstatement = str_replace('!prefix_!', $f_db_prefix, $sqlstatement);
			  $sret = $g_db->Execute($sqlstatement);
			  $ret = $ret && $sret;
			}
            }
			if ( $ret != FALSE ) {
				print_test_result( GOOD );
			} else {
				print_test_result( BAD, true);
			}
			echo '</tr>';

	}
	if ( false == $g_failed ) {
		$t_install_state++;
	}
?>
</table>
<?php
}  # end install_state == 3

# all checks have passed, install the database
if ( 4 == $t_install_state ) {
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
	 	
		/*
		if (get_magic_quotes_gpc()) {
			$value = stripslashes($value);
		}
		*/

		$value = $g_db->qstr($value);
		
		$sqlstatement = 'insert '.$f_db_prefix.'config (name, val) values (\''.$key.'\','.($value).');';
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

<?php
	if ( false == $g_failed ) {
		$t_install_state++;
	}
}  # end install_state == 4

# database installed, get any additional information
if ( 5 == $t_install_state ) {
?>
<table width="100%" border="0" cellpadding="10" cellspacing="1">
<tr>
	<td bgcolor="#e8e8e8" colspan="2">
		<span class="title">Installation successfull</span>
	</td>
</tr>
<tr>
	<td bgcolor="#ffffff">
		Database Installation successfull! Press <a href="appearance.php">here</a> to continue installation.
	</td>
	<?php
	?>
</tr>
</table>

<?php
	}  # end install_state == 5

if ( 6 == $t_install_state ) {
?>
<p>Install was successful.</p>
<p>Log in <a href="<?php echo dirname( dirname( __FILE__ ) ) . DIRECTORY_SEPARATOR; ?>">here</a></p>

<?php
} # end install_state == 6


if( $g_failed ) {
?>
	<p>Please correct failed checks</p>
<?php
}
?>

</form>

</body>
</html>
