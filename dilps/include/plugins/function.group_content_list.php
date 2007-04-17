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
 * File:     function.group_content_list.php
 * Type:     function
 * Name:     group_content_list
 * Purpose:  assign the group_list to a template variable
 * -------------------------------------------------------------
 */

function smarty_function_group_content_list($params, &$smarty)
{
	global $db, $db_prefix;
	
    /*
		print_r($params);
		$db->debug = true;    	
	*/
	
    if (empty($params['var'])) {
        $smarty->trigger_error("assign: missing 'var' parameter");
        return;
    }
    
    if (empty($params['groupid'])) {
        $smarty->trigger_error("assign: missing 'groupid' parameter");
        return;
    }
	else {    
    	$groupid = $params['groupid'];
    }
    
     if (!empty($params['limit'])) {
		$limit = $params['limit'];
    }
    else {
    	$limit = 10;
    }
    
    if (!empty($params['page'])) {
		$page = $params['page'];
    }
    else {
    	$page = 0;
    }
    
	$db->SetFetchMode(ADODB_FETCH_ASSOC);
	
	// print_r($params);
	
    $sql = 	"SELECT {$db_prefix}img_group.collectionid as collectionid, "
    			." {$db_prefix}img_group.imageid as imageid, name1, name2, title "
    			." FROM {$db_prefix}img_group LEFT JOIN {$db_prefix}meta ON "
    			." {$db_prefix}img_group.collectionid = {$db_prefix}meta.collectionid "
    			." AND {$db_prefix}img_group.imageid = {$db_prefix}meta.imageid "
    			." WHERE "
	 			." groupid = ".$db->qstr($groupid)." "
				." ORDER BY collectionid, imageid"; 	

 	$rs  = $db->PageExecute($sql,$limit,$page);
 	
 	// print_r($rs);
	
	// our result
	$content = array();
	
	while (!$rs->EOF)
	{
		
		$content[] = $rs->fields;
		$rs->MoveNext();
	}

	// echo ("\n<br><br><br><br>\n");
	// print_r($content); 	
	
	$smarty->assign($params['numpages'], intval(($rs->MaxRecordCount() / $limit)) + 1);
    $smarty->assign($params['var'], $content);

    if( !empty($params['sql'])) {
		     $smarty->assign($params['sql'], $sql);
	 }

}
?>

