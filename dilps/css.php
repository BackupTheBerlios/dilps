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
 * Style Sheet Include File
 * -------------------------------------------------------------
 * File:     	css.php
 * Purpose:  	includes the style sheet into smarty
 * -------------------------------------------------------------
 */

header("content-type: text/css");

// import standard libraries and configuraiton values
// require('includes.inc.php');

// read db-config from file
	$config = array();
	include('config.inc.php');	
	
	$GLOBALS['force'] = true;
	
	// read config-variables from db and connect
	include( $config['includepath'].'db.inc.php' );	
	
	// read the rest of the configuration
	include( 'globals.inc.php' );

	// session management
	if (!defined('DILPS_SOAP_QUERY') && !defined('DILPS_INTER_DILPS_IMAGE_REQUEST')) {
    	// smarty base include
    	include( $config['includepath'].'smarty/Smarty.class.php' );
		
    	// smarty customization
    	include( $config['includepath'].'smarty.inc.php' );
}


$smarty->display( $config['skin'].DIRECTORY_SEPARATOR.'dilps.css' );
//phpinfo();
?>
