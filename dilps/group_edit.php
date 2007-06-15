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
 * Group Managament
 * -------------------------------------------------------------
 * File:     	edit_groups.php
 * Purpose:  	Implements the functionality of the group
 *				management (found in edit_groups.tpl)
 * -------------------------------------------------------------
 */


// print_r($_REQUEST);

/*
die ('stop!');
*/


// import standard libraries and configuraiton values
require('includes.inc.php');

global $db, $db_prefix, $user;


/*
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

if (isset ($_REQUEST['action']) && !empty($_REQUEST['action'])){
	$actionraw = $_REQUEST['action'];
	list($action,$arguments) = explode(':',$_REQUEST['action']);
} else {
	$action = 'none';
	$arguments = 0;
}

if (isset ($_REQUEST['actioncommited']) && !empty($_REQUEST['actioncommited'])){
	$actioncommited = $_REQUEST['actioncommited'];
} else {
	$actioncommited = 0;
}

if (isset ($_REQUEST['source']) && !empty($_REQUEST['source'])){
	$source = $_REQUEST['source'];
} else {
	$source = array();
}

if (isset ($_REQUEST['target']) && !empty($_REQUEST['target'])){
	$target = $_REQUEST['target'];
} else {
	$target = array();
}

$enougharguments = 0;

if ($arguments > 0)
{
  if ($arguments == 1 && !empty($source['groupid']))  {
    $enougharguments = 1;
  } elseif (($arguments == 2) && !empty($source['groupid']) && !empty($target['groupid'])) {
    $enougharguments = 1;
  }
}

if ($actioncommited) {
  $enougharguments = 0;
  $commitedaction = $action;
  $action = 'none';
  $arguments = 0;
}
else {
  $commitedaction = '';
}

/*
echo ("Action: \n<br>\n");
print_r($action);
echo ("\n<br>\n");
*/

$smarty->assign('sessionid',$sessionid);
$smarty->assign('action',$action); 
$smarty->assign('arguments',$arguments); 
$smarty->assign('enougharguments',$enougharguments); 
$smarty->assign('actioncommited',$actioncommited); 
$smarty->assign('commitedaction',$commitedaction); 
$smarty->assign('source',$source); 
$smarty->assign('target',$target); 

$smarty->display( $config['skin'].'/'.'group_edit.tpl' );

//phpinfo();
?>
