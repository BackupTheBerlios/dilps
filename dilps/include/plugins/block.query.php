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
 * File:     block.query.php
 * Type:     block
 * Name:     query
 * Purpose:  execute query
 * -------------------------------------------------------------
 */

global $config;
require_once( $config['includepath'].'tools.inc.php' );
require_once( $config['includepath'].'htmlquery.inc.php' );

function smarty_block_query($params, $content, &$smarty, &$repeat)
{

    global $db, $db_prefix, $query, $view, $user;

	if (isset($content)) {
	    echo $content;
	    return;
	}

	if (empty($params['var'])) {
	  $smarty->trigger_error("assign: missing 'var' parameter");
	  return;
	}


	$fields = "{$db_prefix}meta.type as type,{$db_prefix}meta.collectionid as collectionid,{$db_prefix}meta.imageid as imageid,ifnull({$db_prefix}meta.name1, '') as name1,ifnull({$db_prefix}meta.name2, '') as name2,{$db_prefix}meta.addition as addition, {$db_prefix}meta.title as title, {$db_prefix}meta.dating as dating";

	if (!empty($query['groupid'])){
		// add grouptable to query
			$fields .= ", {$db_prefix}img_group.groupid as groupid";
	}

	/*	$querystruct = transform_query($query);

	$dbQuery = new dilpsQuery($db, $db_prefix);
	$where = $dbQuery->buildWhere($querystruct);*/
	//$smarty->assign($params['sql'], var_export($where, true)); return;
	
	$where = $query['prepared_where'];

	if (!empty($query['groupid']))
	{
		// query group and all subgroups

		$groupid = $query['groupid'];
		
		// our result
		$groups = array();
		
		// first id is the give one
		$groups[] = $groupid;
		
		$db->SetFetchMode(ADODB_FETCH_ASSOC);
		
		$sql = "SELECT id FROM ".$db_prefix."group WHERE "
					."parentid = ".$db->qstr($query['groupid'])
					." ORDER BY id"; 	
 	
		$rs  = $db->Execute($sql);
		
		if (!$rs)
		{
			// we have no subgroups, just query one id
			$where .= " AND {$db_prefix}img_group.groupid = ".$db->qstr($query['groupid']);
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
			
			$where .= ")";
			
		}
	}

	if (!empty($query['imagestatus'])){
		if ($query['imagestatus'] != 'all')
			$where .= " AND {$db_prefix}meta.status = ".$db->qstr($query['imagestatus']);
	}

	if (!empty($query['imageid'])){
		$where .= " AND {$db_prefix}meta.imageid = ".$db->qstr($query['imageid']);
	}

	$from = "{$db_prefix}meta ";

	if (!empty($query['groupid'])){
			$from .= "LEFT JOIN {$db_prefix}img_group ON {$db_prefix}img_group.imageid = {$db_prefix}meta.imageid AND {$db_prefix}img_group.collectionid = {$db_prefix}meta.collectionid";
	}

	$sql = "SELECT DISTINCT $fields FROM $from WHERE $where";

	switch( $view['type'] )
	{
		case 'liste':
		   $defaultpagesize = 8;
			break;
		case 'detail':
		   $defaultpagesize = 4;
			break;
		case 'grid':
		   $defaultpagesize = 16;
			break;
		case 'grid_detail':
		   $defaultpagesize = 16;
			break;
		default:
		   $defaultpagesize = 4;
	}
	$sql .= " ORDER BY insert_date DESC, imageid DESC";

	$page = (isset( $query['page'] ) ? intval( $query['page'] ) : 1 );

	$pagesize = (isset( $query['pagesize'] ) ? intval( $query['pagesize'] ) : $defaultpagesize );
	if( intval( $query['rows'] ) && intval( $query['cols'] ))
	   $pagesize = intval( $query['cols'] ) * intval( $query['rows'] );
	if( $pagesize < 1 || $pagesize > 500 ) $pagesize = $defaultpagesize;

	if( isset( $query['next'] )) $page++;
	if( isset( $query['prev'] )) $page--;
	if( isset( $query['new'] )) $page = 1;
	if( $page < 1 ) $page = 1;
	$sqls = $sql;
	$rs = $db->PageExecute( $sql, $pagesize, $page );
	if( !$rs ) echo $sql;
	$result = array();
	$result['lastpage'] = $rs->LastPageNo();
	$result['maxrecords'] = $rs->MaxRecordCount();
	$result['rs'] = array();
	while( !$rs->EOF )
	{
		array_walk( $rs->fields, '__stripslashes' );
		$result['rs'][] = $rs->fields;
		$rs->MoveNext();
	}
	$rs->Close();
	if( $page > $result['lastpage'] ) $page = $result['lastpage'];
	$result['page'] = $page;
	$result['pagesize'] = $pagesize;

	$smarty->assign($params['var'], $result);

	if( !empty($params['sql'])) {
		  $smarty->assign($params['sql'], $sqls);
	}


}



?>
