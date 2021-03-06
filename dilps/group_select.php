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
 * group selector
 * -------------------------------------------------------------
 * File:     	group_select.php
 * Purpose:  	implements the functionality of the group
 *				selector (found in group_select.tpl)
 * -------------------------------------------------------------
 */

// import standard libraries and configuraiton values
require('includes.inc.php');

global $db, $db_prefix, $user;

/*
print_r($_REQUEST);

$db->debug = true;
*/


// read sessiond id from get/post
if (isset($_REQUEST['PHPSESSID']))
{
	$sessionid = $_REQUEST['PHPSESSID'];
}
else
{
	$sessionid = '';
}

if (!empty($_REQUEST['target'])){
	$target = trim($_REQUEST['target']);
} else {
	echo ("Error: No target specified\n<br>\n");
	exit;	
}

if (!empty($_REQUEST['lastpath'])){
	$lastpath = trim($_REQUEST['lastpath']);
} else {
	$lastpath = '';
}

if (!empty($_REQUEST['action'])){
	$action = $_REQUEST['action'];
} else {
	$action = '';
}

if (!empty($_REQUEST['currentid'])){
	$currentid = $_REQUEST['currentid'];
} else {
	$currentid = '';
}

if (!empty($_REQUEST['currentname'])){
	$currentname = $_REQUEST['currentname'];
} else {
	$currentname = '';
}

if (!empty($_REQUEST['currentowner'])){
	$currentowner = $_REQUEST['currentowner'];
} else {
	$currentowner = '';
}

if (!empty($_REQUEST['parameter'])){
	$parameter = $_REQUEST['parameter'];
} else {
	$parameter = '';
}

/*
echo ("Action: \n<br>\n");
print_r($action);
echo ("\n<br>\n");
echo ("Target: \n<br>\n");
print_r($target);
echo ("\n<br>\n");
*/

$smarty->assign('sessionid',$sessionid);
$smarty->assign('target', $target);
$smarty->assign('lastpath', $lastpath);
$smarty->assign('action',$action); 
$smarty->assign('currentid',$currentid); 
$smarty->assign('currentname',$currentname); 
$smarty->assign('currentowner',$currentowner);
$smarty->assign('parameter',$parameter);


$smarty->display( $config['skin'].'/'.'group_select.tpl' );

?>
