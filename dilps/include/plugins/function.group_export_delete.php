<?php
/*
   +----------------------------------------------------------------------+
   | DILPS - Distributed Image Library System                             |
   +----------------------------------------------------------------------+
   | Copyright (c) 2002-2004 Juergen Enge                                 |
   | juergen@info-age.net                                                 |
   | http://www.dilps.net                                                 |
   +----------------------------------------------------------------------+
   | published by the Free Software Foundation; either version 2 of the   |
   | This source file is subject to the GNU General Public License as     |
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
 * Smarty plugin
 * --------------------------------------------------------------------
 * File:     	function.group_export_delete.php
 * Type:     	function
 * Name:     	group_export_delete
 * Purpose:  	delete export with given id
 * --------------------------------------------------------------------
 */

function smarty_function_group_export_delete($params, &$smarty)
{
    global $db, $db_prefix;
    global $exportdir, $exportdirlong;

    // print_r($params);

    // $db->debug = true;
    
    // check parameters
    
    if (empty($params['userid'])) {
    	$smarty->trigger_error("assign: missing 'userid' parameter");
        return;
    } else {
    	$userid = $params['userid'];
    }
    
    if (empty($params['deleteid'])) {
    	$smarty->trigger_error("assign: missing 'deleteid' parameter");
        return;
    } else {
    	$deleteid = $params['deleteid'];
    }

    if (empty($params['result'])) {
    	$smarty->trigger_error("assign: missing 'result' parameter");
        return;
    }
    
    $db->SetFetchMode(ADODB_FETCH_ASSOC);
	
    // user's are only allowed to delete their own exports
    $sql = 	"SELECT filename FROM ".$db_prefix."export WHERE"
 			." id = ".$db->qstr($deleteid)
 			." AND userid = ".$db->qstr($userid);
 	
 	$deletefile  = $db->GetOne($sql);
	
	if ($deletefile)
	{
		$sql = 	"DELETE FROM ".$db_prefix."export WHERE"
 			." id = ".$db->qstr($deleteid);
 		$rs = $db->Execute($sql);
		
		$unlink = @unlink($exportdirlong.$userid.DIRECTORY_SEPARATOR.$deletefile);
		
		$result = ($rs != false) & $unlink;
	}
	else {
		$result = false;
	}

   	$smarty->assign($params['result'], $result);
   	
    if( !empty($params['sql']))
	{
		$smarty->assign($params['sql'], $sql);
	}
}
?>
