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
 * File:     	export_group.php
 * Purpose:  	gathers information and inmages from a group
 *				and writes the necessary XML and image files
 *				to use the export with the DILPS viewer
 * -------------------------------------------------------------
 */

// import standard libraries and configuraiton values
require('includes.inc.php');

// import helper functions
include($config['includepath'].'tools.inc.php');

// from block.query.php

function get_groupid_where_clause($groupid, &$db, $db_prefix, $subgroups = true) {
    
    $where = '';
    
	if (!empty($groupid))
	{
		// our result
		$groups = array();
		// first id is the give one
		$groups[] = $groupid;
		$db->SetFetchMode(ADODB_FETCH_ASSOC);
		$sql = "SELECT id FROM ".$db_prefix."group WHERE "
					."parentid = ".$db->qstr($groupid)
					." ORDER BY id"; 	
		$rs  = $db->Execute($sql);
		if (!$rs || !$subgroups)
		{
			// we have no subgroups, just query one id
			$where .= " AND {$db_prefix}img_group.groupid = ".$db->qstr($groupid);
		}
		else
		{
			// get next sublevel		
			while (!$rs->EOF)
			{
				// add group to result array
				$groups[] = $rs->fields['id'];
				// get next but one sublevel, if available
				$sql2 = "SELECT id FROM ".$db_prefix."group WHERE "
							."parentid = ".$db->qstr($rs->fields['id'])
							." ORDER BY id"; 	
				$rs2 = $db->Execute($sql2);
				
				while(!$rs2->EOF)
				{
					$groups[] = $rs2->fields['id'];				
					$rs2->MoveNext();
				}			
				$rs->MoveNext();
			}
			$where .= " AND (0 ";
			foreach ($groups as $gid)
			{
				$where .= " OR {$db_prefix}img_group.groupid = ".$db->qstr($gid);
			}
			$where .= ") ";
		}
	}
    return $where;
}

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

if (!empty($_REQUEST['export']))
{
	$export = $_REQUEST['export'];
}
else
{
	$export = 0;
}

if (!empty($_REQUEST['groupid'])){
		$groupid = $_REQUEST['groupid'];
} else {
	$groupid = '';
	die ("Error - no group ID\n<br>\n");	
}

if (!empty($_REQUEST['groupname'])){
		$groupname = $_REQUEST['groupname'];
} else {
	$groupname = '';
	echo ("Error - no group name\n<br>\n");
	flush();
	exit;
}

$smarty->assign('sessionid',$sessionid);
$smarty->assign('groupid', $groupid);
$smarty->assign('groupname', $groupname);
$smarty->assign('export',$export);
$smarty->display( $config['skin'].DIRECTORY_SEPARATOR.'export_group.tpl' );


//phpinfo();
?>