<?php
/*      
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
*/

/*
 * dilps includes
 * -------------------------------------------------------------
 * File:     			includes.inc.php
 * Purpose:  	central place to configure all
 *						standard includes and their order
 * -------------------------------------------------------------
 */

	/* configuration start */

	// read db-config from file
	$config = array();
	include('config.inc.php');
	
	// read config-variables from db and connect
	include( $config['includepath'].'db.inc.php' );
	
	// read the rest of the configuration (global part)
	include( 'globals.inc.php' );
	
	// read the rest of the configuration (global part)
	include( 'locals.inc.php' );
	
	// session management
	include( $config['includepath'].'session.inc.php' );
	
	// user management
	include( $config['includepath'].'userList.class.php' );
	include( $config['includepath'].'authUser.class.php' );
	include( $config['includepath'].'authStaticUser.class.php' );
	
	// authentication handling
	include( $config['includepath'].'auth.inc.php' );
	
	// smarty base include
	include( $config['includepath'].'smarty/Smarty.class.php' );
	// smarty customization
	include( $config['includepath'].'smarty.inc.php' );
	
	// add some libraries to include path
	
	$lib_include_path = ini_get('include_path');
	
	$new_include_path = 	$lib_include_path.":"
										.$config['includepath'].'pear'.":"
										.$config['includepath'].'xml'.":"
										.$config['includepath'].'mime'.":"
										.$config['includepath'].'console'.":"
										.$config['includepath'].'system'.":"
										.$config['includepath'].":"
										.$config['dilpsdir'];
	
	ini_set('include_path', $new_include_path);
	
	// we use this nearly everywhere
	
	global $db, $db_prefix, $user;
	
	/* configuration end */	
	
	// this may be useful for debugging purposes
	function print_html($value, $key)
	{
		if (is_array($value))
		{
			array_walk($value,"print_html");
		}
		else 
		{
			echo ($key." => ".$value."\n<br>\n");
		}
		
		return;
	}

?>