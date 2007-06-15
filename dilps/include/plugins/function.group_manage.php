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
    global $db, $db_prefix, $resolutions_available, $formats_suffix;
    
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
    
    if (!empty($params['targetid'])) {
    	$targetid = $params['targetid'];
    }
    else {
      $targetid = '';
    }

    $login      = $user['login'];
    $admin      = $user['admin'];
    $editgroups = $user['editgroups'];
    

  	// perform actions
  
  	if ($action == 'copyContent')
  	{
  	   $result = copy_groupcontent($sourceid,$targetid,$db_prefix,$db);
  	   if ($result)
  	   {
  	     $result = 'R_COPYCONT_SUCCESS';
  	   }
  	   else 
  	   {
  	     $result = 'E_COPYCONT_FAILED';  
  	   }
  	}
  	elseif ($action == 'moveContent')
  	{
  	   $result = copy_groupcontent($sourceid,$targetid,$db_prefix,$db);
  	   if (!$result)
  	   {
  	     $result = 'E_MOVECONT_FAILED';  
  	   }
  	   else 
  	   {
  	     $sql = "DELETE FROM {$db_prefix}img_group WHERE groupid=".$db->qstr($sourceid);
  	     $rs  = $db->execute($sql);
  	     
  	     if ($rs === false)
  	     {
  	       $result = 'E_MOVECONT_FAILED';  
  	     }
  	     else 
  	     {
  	       $result = 'R_MOVECONT_SUCCESS';  
  	     }
  	   }
  	  
  	}
  	elseif ($action == 'deleteContent')
  	{
  	  // only admins may delete content from the system
  	  if ($admin)
  	  {
  	    $sql = "SELECT * FROM {$db_prefix}img_group WHERE groupid=".$db->qstr($sourceid);
  	    
  	    $rs  = $db->execute($sql);
  	    
  	    while (!$rs->EOF)
  	    {
  	      $collectionid = $rs->fields['collectionid'];
  	      $imageid = $rs->fields['imageid'];
  	      
  	      delete_image($collectionid,$imageid,$db_prefix,$db,$resolutions_available, $formats_suffix);
  	      
  	      $rs->MoveNext();
  	    }
  	    
  	    $result = 'R_DELCONT_SUCCESS';
  	  }
  	  else 
  	  {
  	    $result = 'E_DELCONT_NOADMIN';
  	  }
  	}
  	
  	// echo ("Result: {$result}");
  
    $smarty->assign($params['result'], $result);
     	
    if( !empty($params['sql']))
  	{
  		$smarty->assign($params['sql'], $sql);
  	}
}

function delete_image($collectionid, $imageid, $db_prefix, &$db, &$resolutions_available, &$formats_suffix)
{
  // Get file location

		$sql = "SELECT filename,base FROM ".$db_prefix."img,".$db_prefix."img_base WHERE ".$db_prefix."img.imageid=".intval($imageid)
				." AND ".$db_prefix."img.collectionid=".intval($collectionid)
				." AND ".$db_prefix."img.collectionid=".$db_prefix."img_base.collectionid"
				." AND ".$db_prefix."img.img_baseid=".$db_prefix."img_base.img_baseid";
				
		$row = $db->GetRow( $sql );
		
		$base = $row['base'];
		
		$file = intval($imageid).'.jpg';
		if( $base != '' && $base{strlen($base)-1} != DIRECTORY_SEPARATOR )
		{
			$base .= DIRECTORY_SEPARATOR;
		}
		
		// Iterate through all available resolutions and formats and delete corresponding files
		
		foreach ($resolutions_available as $resolution)
		{		
			$path = $base.'cache'.DIRECTORY_SEPARATOR.$resolution.DIRECTORY_SEPARATOR.intval($collectionid).'-'.intval($imageid).'.jpg';
			
			// echo "Delete-Path: $path";
		
			if (file_exists($path)){
				unlink($path);
			}
		}
		
		// Delete JPEG-version of original image
		
		$path = $base.'cache'.DIRECTORY_SEPARATOR.intval($collectionid).'-'.intval($imageid).'.jpg';
		
		// echo "Delete-Path: $path";
	
		if (file_exists($path)){
			unlink($path);
		}

		
		// Delete copy of original image
		
		foreach ($formats_suffix as $mime => $suffix)
		{
			$path = $base.intval($collectionid).'-'.intval($imageid).'.'.$suffix;
			
			// echo "Delete-Path: $path";
		
			if (file_exists($path)){
				unlink($path);
			}
		}
		
		
		// Delete image information
		
		$sql = "DELETE FROM ".$db_prefix."img WHERE imageid=".intval($imageid)
				." AND collectionid=".intval($collectionid);																										
		$rs = $db->Execute( $sql );
		
		$sql = "DELETE FROM ".$db_prefix."meta WHERE imageid=".intval($imageid)
				." AND collectionid=".intval($collectionid);																										
		$rs = $db->Execute( $sql );
		
		$sql = "DELETE FROM ".$db_prefix."archaeology WHERE imageid=".intval($imageid)
				." AND collectionid=".intval($collectionid);																										
		$rs = $db->Execute( $sql );
		
		$sql = "DELETE FROM ".$db_prefix."architecture WHERE imageid=".intval($imageid)
				." AND collectionid=".intval($collectionid);																										
		$rs = $db->Execute( $sql );
		
		$sql = "DELETE FROM ".$db_prefix."img_group WHERE imageid=".intval($imageid)
				." AND collectionid=".intval($collectionid);
		$rs = $db->Execute( $sql );		
}

function copy_groupcontent($sourceid,$targetid,$db_prefix,&$db)
{
  $sql = "SELECT * FROM {$db_prefix}img_group WHERE groupid=".$db->qstr($sourceid);
   $rs  = $db->execute($sql);
   
   if ($rs === false)
   {
     return false;
   }
   else 
   {
     while (!$rs->EOF)
     {
       $sql2 = "REPLACE INTO {$db_prefix}img_group (groupid,collectionid,imageid) VALUES ("
               .$db->qstr($targetid).",".$db->qstr($rs->fields['collectionid']).",".$db->qstr($rs->fields['imageid']).")";
       
       $rs2  = $db->execute($sql2);
               
       if ($rs2 === false)
       {
         return false;
       }
       
       $rs->MoveNext();
     }
   }
   
   return true;
}

?>
