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
 * File:     	function.group_change.php
 * Type:     	function
 * Name:     	group_manage
 * Purpose:   move or copy groups or their content
 * --------------------------------------------------------------------
 */

function smarty_function_group_manage($params, &$smarty)
{
    global $db, $db_prefix;
    
    global $user;

	// print_r($params);

    // $db->debug = true;
    
    // check parameters

    if (empty($params['action'])) {
    	$smarty->trigger_error("assign: missing 'action' parameter");
        return;
    } else {
    	$action = $params['action'];
    }
    
    if (empty($params['sourceid'])) {
    	$smarty->trigger_error("assign: missing 'sourceid' parameter");
        return;
    } else {
    	$sourceid = $params['sourceid'];
    }
    
    if (empty($params['sourcename'])) {
    	$smarty->trigger_error("assign: missing 'sourcename' parameter");
        return;
    } else {
    	$sourcename = $params['sourcename'];
    }
    
    if (empty($params['sourceowner'])) {
    	$smarty->trigger_error("assign: missing 'sourceowner' parameter");
        return;
    } else {
    	$sourceowner = $params['sourceowner'];
    }
    
    if (empty($params['targetid'])) {
    	$smarty->trigger_error("assign: missing 'targetid' parameter");
        return;
    } else {
    	$targetid = $params['targetid'];
    }
    
    if (empty($params['targetname'])) {
    	$smarty->trigger_error("assign: missing 'targetname' parameter");
        return;
    } else {
    	$targetname = $params['targetname'];
    }
    
    if (empty($params['targetowner'])) {
    	$smarty->trigger_error("assign: missing 'targetowner' parameter");
        return;
    } else {
    	$targetowner = $params['targetowner'];
    }
    

	// perform actions

	if ($action == 'addgroup' || $action == 'addsubgroup')
	{
		/* 
			state:
			action 		= add a group
			id 			= current group's id
			name 		= current group's name
			owner 		= current group's owner
			parameter 	= new group's name
		*/
		
		if ($action == 'addgroup') {
			$id = 0;
		}
		
		// check access rights
		
		if ($id == 0) {
			// this means our group is a public one
			$p_owner = 'public';
		}
		else {
			$sql 		= 	"SELECT owner FROM ".$db_prefix."group "
						." WHERE parentid = ".$db->qstr($id);
			$p_owner 	= 	$db->GetOne($sql);
		}
		
		if ($p_owner == $user['login'] || $user['editgroups'])
		{
			// get new groupid
			$sql = "SELECT ifnull((max(id)+1),1) FROM ".$db_prefix."group ";
			$newid = $db->GetOne($sql);
	
			$sql = "INSERT INTO ".$db_prefix."group "
						."(id, name,parentid,owner) "
						."VALUES ("
						.$db->qstr($newid).", "
						.$db->qstr($parameter).", "
						.$db->qstr($id).", "
						.$db->qstr($owner).")";
			$rs  = $db->Execute ($sql);
	
			// keep result codes for the moment
			if (!$rs)
			{
				$result = "E_ADD_FAILED";
			} else
			{
				$result = "R_ADD_SUCCESS";
			}
		}
		else 
		{
			$result = "E_NO_RIGHTS";
		}
	}
	elseif ($action == "rename")
	{
		/* 
			state:
			action 		= rename a group
			id 			= current group's id
			name 		= current group's name
			owner 		= current group's owner
			parameter 	= new name for current group
		*/
		
		// check access rights
		
		if ($id == 0) {
			// this means our group is a public one
			$p_owner = 'public';
		}
		else {
			$sql 		= 	"SELECT owner FROM ".$db_prefix."group "
						." WHERE parentid = ".$db->qstr($id);
			$p_owner 	= 	$db->GetOne($sql);
		}
		
		if ($p_owner == $user['login'] || $user['editgroups'])
		{
			if ($p_owner != 'public') {
				// personal groups are identified by squared brackets
				if ($parameter{0} != '[') {
					$parameter = '['.$parameter;
				}
				
				if ($parameter{strlen($parameter)-1} != ']') {
					$parameter = $parameter.']';
				}
			}
			
			$sql = 	"UPDATE ".$db_prefix."group SET"
					." name=".$db->qstr($parameter)
					." WHERE id= ".$db->qstr($id);

			$rs  = $db->Execute ($sql);
	
			// keep result codes for the moment
			if (!$rs)
			{
				$result = "E_EDIT_FAILED";
			}
			else
			{
				$result = "R_EDIT_SUCCESS";
			}
		}
		else 
		{
			$result = "E_NO_RIGHTS";
		}
	}
	elseif ($action == 'clear') 
	{
		/* 
			state:
			action 		= clear a group (remove all contained images from the group)
			id 			= group to clear: id
			name 		= group to clear: name
			owner 		= group to clear: owner
			parameter 	= empty
		*/
		
		// check access rights
		if ($id == 0) {
			// this means our group is a public one
			$p_owner = 'public';
		}
		else {
			$sql 		= 	"SELECT owner FROM ".$db_prefix."group "
						." WHERE parentid = ".$db->qstr($id);
			$p_owner 	= 	$db->GetOne($sql);
		}
		
		if ($p_owner == $user['login'] || $user['editgroups'])
		{
			// empty group - otherwise ghost members will appear later
 			$sql = 	"DELETE FROM ".$db_prefix."img_group "
					." WHERE groupid = ".$db->qstr($id);

			$rs = $db->Execute ($sql);
	
			if (!$rs) {
				$result = "E_CLEAR_FAILED";
	 		}
	 		else {
	 			$result = "R_CLEAR_SUCCESS";
	 		}
		}
		else 
		{
			$result = "E_NO_RIGHTS";
		}
	}
	elseif ($action == 'del')
	{
		/* 
			state:
			action 		= delete a group (and all subgroups)
			id 			= group to delete: id
			name 		= group to delete: name
			owner 		= group to delete: owner
			parameter 	= empty
		*/
		
		// check access rights
		if ($id == 0) {
			// this means our group is a public one
			$p_owner = 'public';
		}
		else {
			$sql 		= 	"SELECT owner FROM ".$db_prefix."group "
						." WHERE parentid = ".$db->qstr($id);
			$p_owner 	= 	$db->GetOne($sql);
		}
		
		if ($p_owner == $user['login'] || $user['editgroups'])
		{
			// a bit more care is required - we have to look for subgroups
			// and delete images there as well as the groups themselv
	
			$sql = "SELECT id, name, owner FROM ".$db_prefix."group "
					." WHERE parentid = ".$db->qstr($id);
	 		$rs = $db->Execute($sql);
	
			// collect all groups to delete, how far we get depends on the level
			// in the group hierarchy our group resides in
	
			$groups = array();
	
			// add our group first
			$groups[$id] = $id;
	
			// get its children
			while (!$rs->EOF)
			{
				$sql2 = "SELECT id, name, owner FROM ".$db_prefix."group WHERE "
							."parentid = ".$db->qstr($rs->fields['id'])
							." ORDER BY name";
	
				$rs2 = $db->Execute($sql2);
	
				while(!$rs2->EOF)
				{
					$sql3 = "SELECT id, name, owner FROM ".$db_prefix."group WHERE "
							."parentid = ".$db->qstr($rs2->fields['id'])
							." ORDER BY name";
	
					$rs3 = $db->Execute($sql3);
	
					while(!$rs3->EOF)
					{
						$groups[$rs->fields['id']] = $rs3->fields['id'];
						$rs3->MoveNext();
					}
	
					$groups[$rs2->fields['id']] = $rs2->fields['id'];
					$rs2->MoveNext();
				}
	
				$groups[$rs->fields['id']] = $rs->fields['id'];
				$rs->MoveNext();
			}
	
			// we have our groupids now, empty them, then delete
	
			$delete_success = true;
	
			foreach ($groups as $delid)
			{
				// empty group - otherwise ghost members will appear later
	 			$sql = 	"DELETE FROM ".$db_prefix."img_group "
							." WHERE groupid = ".$db->qstr($delid);
	
	 			$rs = $db->Execute ($sql);
	
				if (!$rs)
				{
					$delete_success = false;
				}
	
				// delete group
	 			$sql = 	"DELETE FROM ".$db_prefix."group "
							." WHERE id = ".$db->qstr($delid);
	
	 			$rs = $db->Execute ($sql);
				if (!$rs)
				{
					$delete_success = false;
				}
	 		}
	
			// keep result codes for the moment
			if ($rs === false)
			{
				$result = "E_DELETE_FAILED";
			}
			else
			{
				$result = "R_DELETE_SUCCESS";
			}
		}
		else 
		{
			$result = "E_NO_RIGHTS";
		}
	}
	else
	{
		$result = 'NO_ACTION_TAKEN';
	}
	
	// echo ("Result: {$result}");

   	$smarty->assign($params['result'], $result);
   	
    if( !empty($params['sql']))
	{
		$smarty->assign($params['sql'], $sql);
	}
}
?>
