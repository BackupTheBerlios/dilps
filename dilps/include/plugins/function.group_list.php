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
 * File:     function.group_list.php
 * Type:     function
 * Name:     group_list
 * Purpose:  assign the group_list to a template variable
 * -------------------------------------------------------------
 */

 
function smarty_function_group_list($params, &$smarty)
{
    if (empty($params['var'])) {
        $smarty->trigger_error("assign: missing 'var' parameter");
        return;
    }
    
    global $db, $db_prefix;
    
	/*
	print_r($params);
    
    $db->debug = true;
	*/
	
	$db->SetFetchMode(ADODB_FETCH_ASSOC);
    
    $sql = "SELECT id, name, owner FROM ".$db_prefix."group WHERE "
	 			."parentid = '0'"
				." ORDER BY name"; 	
 	
 	$rs  = $db->Execute($sql);
	
	// our result
	$groups = array();
	
	while (!$rs->EOF)
	{
		$sql2 = "SELECT id, name, owner FROM ".$db_prefix."group WHERE "
					."parentid = ".$db->qstr($rs->fields['id'])
					." ORDER BY name"; 	
		
		$rs2 = $db->Execute($sql2);
		
		$l2groups = array();
		
		while(!$rs2->EOF)
		{
			$sql3 = "SELECT id, name, owner FROM ".$db_prefix."group WHERE "
					."parentid = ".$db->qstr($rs2->fields['id'])
					." ORDER BY name"; 	
		
			$rs3 = $db->Execute($sql3);
			
			$l3groups = array();
			
			while(!$rs3->EOF)
			{
				$l3groups[$rs3->fields['id']] = array(	'id'		=> $rs3->fields['id'],
																			'name' 	=> $rs3->fields['name'],
																			'owner' => $rs3->fields['owner'] );
																			
				$rs3->MoveNext();
			}
			
			$l2groups[$rs2->fields['id']] = array(	'id'				=> $rs2->fields['id'],
																		'name' 			=> $rs2->fields['name'],
																		'owner' 		=> $rs2->fields['owner'],
																		'subgroups' 	=> $l3groups );
																		
			unset($l3groups);
			
			$rs2->MoveNext();
		}				
		
		$groups[$rs->fields['id']] = array(	'id'				=> $rs->fields['id'],
																'name' 			=> $rs->fields['name'],
																'owner'		 	=> $rs->fields['owner'],
																'subgroups' 	=> $l2groups );
																
		unset($l2groups);
		
		$rs->MoveNext();
	}

	/*
	echo ("\n<br><br><br><br>\n");
	
	print_r($groups); 	
	*/
 	
		 	
    $smarty->assign($params['var'], $groups);
    
    if( !empty($params['sql'])) {
		     $smarty->assign($params['sql'], $sql);
	 }
	 
}
?>
