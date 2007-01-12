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
 * File:     	function.group_export.php
 * Type:     	function
 * Name:     	group_export
 * Purpose:  	export the specified group
 * --------------------------------------------------------------------
 */

// import helper functions
global $config;
include($config['includepath'].'tools.inc.php');

function smarty_function_group_export($params, &$smarty)
{
    global $db, $db_prefix;
    global $exportdir, $exportdirlong;
    global $user;
    
    global $zip_binary;

	// print_r($params);

    // $db->debug = true;
    
    // check parameters

    if (empty($params['id'])) {
    	$smarty->trigger_error("assign: missing 'id' parameter");
        return;
    } else {
    	$id = $params['id'];
    }
    
    if (empty($params['name'])) {
    	$smarty->trigger_error("assign: missing 'name' parameter");
        return;
    } else {
    	$name = $params['name'];
    }
    
    if (empty($params['subgroups'])) {
    	$smarty->trigger_error("assign: missing 'subgroups' parameter");
        return;
    } else {
    	if ($params['subgroups'] == 'yes') {
    		$subgroups = true;
    	}
    	else {
    		$subgroups = false;
    	}
    }
    
    if (empty($params['withviewer'])) {
    	$smarty->trigger_error("assign: missing 'withviewer' parameter");
        return;
    } else {
    	if ($params['withviewer'] == 'yes') {
    		$withviewer = true;
    	}
    	else {
    		$withviewer = false;
    	}
    }
    
    if (empty($params['targetsystem'])) {
    	$smarty->trigger_error("assign: missing 'targetsystem' parameter");
        return;
    } else {
    	$targetsystem = $params['targetsystem'];
    }
    
    if (!empty($params['comment'])) {
    	$comment = $params['comment'];
    }
    else {
    	$comment = '';
    }
    
    
    
    if (empty($params['result'])) {
    	$smarty->trigger_error("assign: missing 'result' parameter");
        return;
    }
    
    // generate unique filename for this export
	$tmpid = generate_random_string();
	
	while 	
	(	file_exists($exportdir.DIRECTORY_SEPARATOR.$user['login'].DIRECTORY_SEPARATOR.$tmpid.'.zip') ||
		file_exists($exportdir.DIRECTORY_SEPARATOR.$user['login'].DIRECTORY_SEPARATOR.$tmpid)	)
	{
		$tmpid = generate_random_string();
	}
	
	// check if export sub-directories already exists and are writeable
	
	$create_directories 
		= array	(
					$user['login'],
					$user['login'].DIRECTORY_SEPARATOR.$tmpid,
					$user['login'].DIRECTORY_SEPARATOR.$tmpid.DIRECTORY_SEPARATOR.'xml',
					$user['login'].DIRECTORY_SEPARATOR.$tmpid.DIRECTORY_SEPARATOR.'images',
					$user['login'].DIRECTORY_SEPARATOR.$tmpid.DIRECTORY_SEPARATOR.'thumbnails'
				 );

				 
	$ret = true;
	
	foreach ($create_directories as $dir)
	{
		$sret = check_dir($exportdir.DIRECTORY_SEPARATOR.$dir,true, true, 0755);
		$ret = $ret & $sret;
	}
	
	if (!$ret){
		$result = 'E_CREATE_DIRECTORY';
	}
	else 
	{
		// if we succeeded in creating the directories, this is our temporary directory
		$tmpdir 	= $exportdir.$user['login'].DIRECTORY_SEPARATOR.$tmpid;
		$tmpdirlong = $exportdirlong.$user['login'].DIRECTORY_SEPARATOR.$tmpid;
		
		// do we need to copy the viewer skeleton?
		if ($withviewer)
		{
			$viewerdir = '';
	
			if ($targetsystem == 'mac') {
				$viewerdir = $dilpsdir.'viewer'.DIRECTORY_SEPARATOR.'mac'.DIRECTORY_SEPARATOR;
			}
			else {
				$viewerdir = $dilpsdir.'viewer'.DIRECTORY_SEPARATOR.'windows'.DIRECTORY_SEPARATOR;
			}
	
			// copy viewer with PHP-functions
			$olddir = getcwd();
			chdir($viewerdir);
	
			$ret = copy_recursive('.',$tmpdirlong.DIRECTORY_SEPARATOR);
			chdir($olddir);
		}
		
		if (!$ret){
			$result = 'E_COPY_VIEWER';
		}
		else 
		{
			// start reading actual data
		
			$sql = "SELECT DISTINCT * FROM ".$db_prefix."img, ".$db_prefix."img_group, ".$db_prefix."meta"
					." WHERE ".$db_prefix."img.collectionid = ".$db_prefix."meta.collectionid"
					." AND ".$db_prefix."img.imageid = ".$db_prefix."meta.imageid"
					." AND ".$db_prefix."img.collectionid = ".$db_prefix."img_group.collectionid"
					." AND ".$db_prefix."img.imageid = ".$db_prefix."img_group.imageid"
					.get_groupid_where($id,$db,$db_prefix,$subgroups);
		
			$rs = $db->Execute( $sql );
			
			$xml_ret = true;
			$img_ret = true;
			
			// we continue, even when there are errors
			while ( !$rs->EOF )
			{
				// print_r($rs->fields);
				
				$xmlout = "<?"."xml version=\"1.0\" encoding=\"UTF-8\" ?".">\n";
				$xmlout .= "<imgdata>\n";
				$xmlout .= "<width>".utf8_encode($rs->fields['width'])."</width>\n";
				$xmlout .= "<height>".utf8_encode($rs->fields['height'])."</height>\n";
				$xmlout .= "<name>".utf8_encode($rs->fields['name1'])."</name>\n";
				$xmlout .= "<vorname>".utf8_encode($rs->fields['name2'])."</vorname>\n";
				$xmlout .= "<titel>".utf8_encode($rs->fields['title'])."</titel>\n";
				$xmlout .= "<datierung>".utf8_encode($rs->fields['dating'])."</datierung>\n";
				$xmlout .= "<material>".utf8_encode($rs->fields['material'])."</material>\n";
				$xmlout .= "<technik>".utf8_encode($rs->fields['technique'])."</technik>\n";
				$xmlout .= "<format>".utf8_encode($rs->fields['format'])."</format>\n";
				$xmlout .= "<stadt>".utf8_encode($rs->fields['location'])."</stadt>\n";
				$xmlout .= "<institution>".utf8_encode($rs->fields['institution'])."</institution>\n";
				$xmlout .= "<literatur>".utf8_encode($rs->fields['literature'])."</literatur>\n";
			    $xmlout .= "<url>".utf8_encode("images".DIRECTORY_SEPARATOR.$rs->fields['filename'])."</url>\n";
				$xmlout .= "<thumbnail>".utf8_encode("thumbnail".DIRECTORY_SEPARATOR.$rs->fields['filename'])."</thumbnail>\n";
			    $xmlout .= "<schlagworte>".utf8_encode($rs->fields['keyword'])."</schlagworte>\n";
			   	$xmlout .= "<quelle>".utf8_encode($rs->fields['imagerights'])."</quelle>\n";
				$xmlout .= "<comment>".utf8_encode($rs->fields['commentary'])."</comment>\n";
				$xmlout .= "</imgdata>\n";
				
				// print_r($xmlout);
		
				$sql2 = "SELECT base FROM ".$db_prefix."img_base WHERE "
						.$db_prefix."img_base.img_baseid = ".$db->qstr($rs->fields['img_baseid']);
		
				$path = $db->GetOne ($sql2);
		
				$copyfilename = $rs->fields['collectionid']."-".$rs->fields['imageid'].".jpg";
		
				$source = $path.DIRECTORY_SEPARATOR.'cache'.DIRECTORY_SEPARATOR.'1600x1200'.DIRECTORY_SEPARATOR.$copyfilename;
				$dest = $tmpdir.DIRECTORY_SEPARATOR.'images'.DIRECTORY_SEPARATOR.$copyfilename;
				
				$img_sret = @copy($source,$dest);
		
				/*
				echo ("Source: ".$source."\n<br>\n");
				echo ("Dest: ".$dest."\n<br>\n");
				*/
		
				$source = $path.DIRECTORY_SEPARATOR.'cache'.DIRECTORY_SEPARATOR.'120x90'.DIRECTORY_SEPARATOR.$copyfilename;
				$dest = $tmpdir.DIRECTORY_SEPARATOR.'thumbnails'.DIRECTORY_SEPARATOR.$copyfilename;
		
				$thumb_sret = @copy($source,$dest);
		
				$handle 	= @fopen ($tmpdir.DIRECTORY_SEPARATOR.'xml'.DIRECTORY_SEPARATOR
									.$rs->fields['collectionid'].'-'.$rs->fields['imageid']
									.'.xml','w');
				
				if (!$handle)
				{
					$xml_sret = false;
				}
				else {
					$xml_sret 	= @fwrite($handle,$xmlout);	
				}
				

				// cleanup
				fclose($handle);
				unset($xmlout);
				
				flush();
				
				$img_ret = $img_sret & $thumb_sret & $img_ret;
				$xml_ret = $xml_ret & $xml_sret;
		
				$rs->MoveNext();
			}
			
			// create zip archive
	
			$old = getcwd();
			chdir ($exportdirlong.$user['login']);
			
			$cmd = $zip_binary.' -9 -r -m  '.escapeshellarg($tmpid.'.zip').' '.escapeshellarg($tmpid);
			exec($cmd, $result, $ret);
			
			/*
			echo ("CMD: {$cmd}\n<br>\n");
			echo ("Result:");
			nl2br(print_r($result));
			echo ("\n<br>\n");
			echo ("Ret: {$ret} \n<br>\n");
			*/
		
			if ($ret != 0){
				$result = 'E_CREATE_ZIP';
			}
			else {
				chdir($olddir);
	
				$ret = @chmod($tmpdirlong.'.zip',0755);
				
				// echo ("Ret: {$ret} \n<br>\n");
			
				if (!$ret){
					$result = 'E_CREATE_ZIP';
				}
				else {
					
					if (insert_export($user['login'],$name, $tmpid.'.zip',$comment))
					{
						$result = 'R_EXPORT_SUCCESSFUL';	
					}
					else {
						$result = 'E_ACCESS_DB';
					}
				}
			}
		}
	}
	
	// if something went wrong, clean up a little bit
	if (file_exists($tmpdirlong))
	{
		@delete_recursive($tmpdirlong);
	}

   	$smarty->assign($params['result'], $result);
   	
    if( !empty($params['sql']))
	{
		$smarty->assign($params['sql'], $sql);
	}
}
?>
