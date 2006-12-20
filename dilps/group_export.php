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
 * exports a group to the DILPS viewer
 * -------------------------------------------------------------
 * File:     	group_export.php
 * Purpose:  	gathers information and inmages from a group
 *				and writes the necessary XML and image files
 *				to use the export with the DILPS viewer
 * -------------------------------------------------------------
 */

global $config;

// import standard libraries and configuraiton values
require('includes.inc.php');

// error_reporting('E_ALL');

// read sessiond id from get/post
if (isset($_REQUEST['PHPSESSID']))
{
	$sessionid = $_REQUEST['PHPSESSID'];
}
else
{
	$sessionid = '';
}

global $db, $db_prefix;

global $resolutions_available;
global $formats_available;
global $formats_suffix;
global $imagemagick_identify;
global $imagemagick_convert;
global $file_binary;
global $zip_binary;

$resolutions = $resolutions_available;

global $db, $db_prefix, $dilpsdir, $exportdir, $exportdirlong, $exporturl, $user;

// print_r($_REQUEST);

// $db->debug = true;

if (!empty($_REQUEST['export'])) {
	$export = $_REQUEST['export'];
}
else {
	$export = 0;
}

if (!empty($_REQUEST['show'])) {
	$show = $_REQUEST['show'];
}
else {
	$show = 0;
}

if (!empty($_REQUEST['deleteid'])) {
	$deleteid = $_REQUEST['deleteid'];
}
else {
	$deleteid = '';
}

if (!empty($_REQUEST['groupid'])){
		$groupid = $_REQUEST['groupid'];
} else {
	$groupid = '';
}

if (!empty($_REQUEST['groupname'])){
	$groupname = $_REQUEST['groupname'];
} else {
	$groupname = '';
}

if (!empty($_REQUEST['comment'])){
	$comment = trim(htmlentities($_REQUEST['comment']));
} else {
	$comment = '';
}

if (!empty($_REQUEST['withviewer'])){
	$withviewer = trim($_REQUEST['withviewer']);
} else {
	$withviewer = 'no';
}

// with or without subgroup content
if (!empty($_REQUEST['subgroups'])){
	if ($_REQUEST['subgroups'] != '1') {
		$subgroups = $_REQUEST['subgroups'];
	}
} else {
	$subgroups = 'no';
}

// which version of the viewer do we use?
if (!empty($_REQUEST['targetsystem'])){
	$targetsystem = trim($_REQUEST['targetsystem']);
} else {
	$targetsystem = 'win';
}

$smarty->assign('sessionid',$sessionid);
$smarty->assign('groupid', $groupid);
$smarty->assign('groupname', $groupname);
$smarty->assign('comment', $comment);
$smarty->assign('subgroups', $subgroups);
$smarty->assign('withviewer', $withviewer);
$smarty->assign('targetsystem', $targetsystem);
$smarty->assign('export',$export);
$smarty->assign('show',$show);
$smarty->assign('deleteid',$deleteid);

$smarty->display( $config['skin'].DIRECTORY_SEPARATOR.'group_export.tpl' );


// phpinfo();
?>