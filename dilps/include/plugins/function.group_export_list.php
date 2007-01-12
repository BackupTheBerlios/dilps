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
 * File:     	function.group_export_list.php
 * Type:     	function
 * Name:     	group_export_list
 * Purpose:  	list the exports of a user 
 * --------------------------------------------------------------------
 */

function smarty_function_group_export_list($params, &$smarty)
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

    if (empty($params['result'])) {
    	$smarty->trigger_error("assign: missing 'result' parameter");
        return;
    }
    
    // get all recent exports
    
    $db->SetFetchMode(ADODB_FETCH_ASSOC);
	
    $sql = 	"SELECT * FROM ".$db_prefix."export WHERE"
 			." userid = ".$db->qstr($userid)
			." ORDER BY creationtime DESC"; 	
 	$rs  = $db->Execute($sql);
	
	// our result
	$result = array();
	
	while (!$rs->EOF)
	{
		$result[] = array
						(	
							'id'				=> $rs->fields['id'],
							'groupname'			=> $rs->fields['groupname'],
							'comment' 			=> $rs->fields['comment'],
							'creationtime'		=> $rs->fields['creationtime'],
							'filename' 			=> $rs->fields['filename'],
							'url'				=> str_replace("\\","/",$exportdir.$userid.DIRECTORY_SEPARATOR.$rs->fields['filename'] )
						);
		$rs->MoveNext();
	}


   	$smarty->assign($params['result'], $result);
   	
    if( !empty($params['sql']))
	{
		$smarty->assign($params['sql'], $sql);
	}
}
?>
