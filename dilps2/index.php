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
 * index file
 * -------------------------------------------------------------
 * File:     	index.php
 * Purpose:  	startpoint of the DILPS system
 * -------------------------------------------------------------
 */
ini_set( 'zend.ze1_compatibility_mode', 'On' );
ini_set( 'session.use_cookies' , 1 );
ini_set( 'session.use_only_cookies', 1);
session_start();

/**
*  import standard libraries and configuraiton values
*/

include('includes.inc.php');

require_once( $config['includepath'].'param.inc.php' );

//$smarty->display( $config['skin'].'/'.$tpl);

$smarty->display( $config['skin'].'/'.'index.tpl');

//phpinfo();
?>
