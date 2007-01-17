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
 * Image Displaying
 * -------------------------------------------------------------
 * File:     	image.php
 * Purpose:  	extracts the image and collection ID from its
 *				arguments and reads the approriate information
 *				from the database, outputs the image in the
 *				specified resolution or an empty image if the
 *				latter one doesn't exist.
 * -------------------------------------------------------------
 */
ini_set( 'zend.ze1_compatibility_mode', 'On' );

// read sessiond id from get/post
if (isset($_REQUEST['PHPSESSID'])) {
	$sessionid = $_REQUEST['PHPSESSID'];
} else {
	$sessionid = '';
}
include_once( 'config.inc.php');
include_once( $config['includepath'].'../includes.inc.php' );
//include_once( $config['includepath'].'tools.inc.php' );
?>

<html>
<head>
  <meta name="robots" content="index,follow">
  <meta http-equiv="pragma" content="no-cache">
  <meta http-equiv="expires" content="0">
  <meta http-equiv="cache-control" content="no-cache">
  <meta name="keywords" content="Bilddatenbanksystem, Bilddatenbank, Diathek, digitalisiert">
  <meta http-equiv="Content-Script-Type" content="text/javascript">
  <meta http-equiv="Content-Style-Type" content="text/css">
  <meta name="author" content="jrgen enge, thorsten wbbena">
  <meta name="date" content="2003-01-23">
  <link rel="shortcut icon" href="favicon.ico">
  <title>. : {#title#|escape:"htmlall"} : .</title>
  <link rel="stylesheet" type="text/css" href="css.php">
</head>
<body class="main">
<div id="session_control_inner" style="font-size: 50%;">

<?php


// error_reporting('E_ALL');

// print_r($_REQUEST);

// think about what to escape for safety reasons

global $_SESSION;

if (isset($_REQUEST['id']))
{
	$id = $_REQUEST['id'];
	
	if (isset($_REQUEST['key1']))
	{
		$key1 = $_REQUEST['key1'];
		if (isset($_REQUEST['value1']))
		{
			$_SESSION['tempvals'][$id][$key1] = $_REQUEST['value1'];
			echo ("{$key1} stored - success\n<br>\n");
		}
		else 
		{
			echo ("{$key1} not stored - no value\n<br>\n");
		}
	}
	
	if (isset($_REQUEST['key2']))
	{
		$key2 = $_REQUEST['key2'];
		if (isset($_REQUEST['value2']))
		{
			$_SESSION['tempvals'][$id][$key2] = $_REQUEST['value2'];
			echo ("{$key2} stored - success\n<br>\n");
		}
		else 
		{
			echo ("{$key2} not stored - no value\n<br>\n");
		}
	}
}
else 
{
	echo ("Missing imageid - nothing stored\n<br>\n");
}

?>
</div>
</body>
</html>