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
 * Smarty plugin
 * -------------------------------------------------------------
 * File:     function.group_detail.php
 * Type:     function
 * Name:     group_detail
 * Purpose:  assign details of a group to a template variable
 * -------------------------------------------------------------
 */
 
function smarty_function_group_detail($params, &$smarty)
{
	//print_r($params);
	
	global $db, $db_prefix;
	
    if (empty($params['var'])) {
        $smarty->trigger_error("assign: missing 'var' parameter");
        return;
    }
    
    if (empty($params['level'])) {
    	$smarty->trigger_error("assign: missing 'level' parameter");
        return;
    } else {
    	$level = $params['level'];
    }    
  
	if ($level < 1 or $level > 3){
		$smarty->trigger_error("assign: invalid level number");
		return;
	}
	
	 if (empty($params['groupid'])) {
    	$smarty->trigger_error("assign: missing 'groupid' parameter");
        return;
    } else {
    	$groupid = $params['groupid'];
    }
    
    $sql = "SELECT groupid, level".$level."_name AS groupname, owner_name AS owner FROM ".$db_prefix."group WHERE "
	 			."groupid=".$db->qstr($groupid);
 	
 	$db->SetFetchMode(ADODB_FETCH_ASSOC);
 	
 	$rs  = $db->GetArray ($sql);
 	
 	// print_r($rs);
 	
 	$rs2 = $rs[0];
 	
    $smarty->assign($params['var'], $rs2);
    
    if( !empty($params['sql'])) {
		     $smarty->assign($params['sql'], $sql);
	 }
	 
}
?>
