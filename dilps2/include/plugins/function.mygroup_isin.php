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
 * File:     function.in_mygroup.php
 * Type:     function
 * Name:     in_mygroup
 * Purpose:  tests if an image is in the specified group
 * -------------------------------------------------------------
 */
 
function smarty_function_mygroup_isin($params, &$smarty)
{
    if (empty($params['var'])) {
        $smarty->trigger_error("assign: missing 'var' parameter");
        return;
    }
    
    //print_r($params);
    
    global $db, $db_prefix;
    
    // $db->debug = true;
 
    if (empty($params['cid'])) {
    	$smarty->trigger_error("assign: missing 'cid' parameter");
        return;
    } else {
    	$collectionid = $params['cid'];
    }
    
    if (empty($params['groupid'])) {
    	$smarty->trigger_error("assign: missing 'groupid' parameter");
        return;
    } else {
    	$groupid = $params['groupid'];
    }
    
     if (empty($params['imageid'])) {
    	$smarty->trigger_error("assign: missing 'imageid' parameter");
        return;
    } else {
    	$imageid = $params['imageid'];
    }
    
 	$sql = "SELECT * FROM ".$db_prefix."img_group WHERE "
 			."collectionid=".$db->qstr($collectionid)
 			." AND groupid=".$db->qstr($groupid)
 			." AND imageid=".$db->qstr($imageid);
 	
 	$rs  = $db->GetOne ($sql);
 	
 	//print_r($rs);
 	
 	if ($rs !== false) {
 		$ingroup = 'yes';
 	} else {
 		$ingroup = 'no';
 	}
		 	
    $smarty->assign($params['var'], $ingroup);
    
    if( !empty($params['sql'])) {
		     $smarty->assign($params['sql'], $sql);
	 }
	 
}
?>
