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
 * File:     function.save_image.php
 * Type:     function
 * Name:     save_image
 * Purpose:  updates the image information in the database
 * -------------------------------------------------------------
 */
global $config;

require_once( $config['includepath'].'tools.inc.php' );
require_once( $config['includepath'].'thesaurusDB.class.php');


function smarty_function_save_image($params, &$smarty)
{
    global $_REQUEST, $db_prefix, $db, $user;

    if (empty($params['error']))
    {
        $smarty->trigger_error("save_image: missing 'error' parameter");
        return;
    }

    $edit = $_REQUEST['edit'];
    
    // echo('function.save_image.php: '.$edit['type'].' - Einsprungpunkt realisieren'."\n<br>\n");
    
 	if( $edit['loadtype'] != 'save')
 	   return;

   if( !$user['editor'] )
   {
   	   $error = "Insufficient Rights";
   	   $smarty->assign( $params['error'], $error );
   	   return;
   }


    extractID( $edit['id'], $collectionid, $imageid );

	$sql = "SELECT status FROM {$db_prefix}meta WHERE collectionid=$collectionid AND imageid=$imageid";
	$status = $db->GetOne($sql);
	if( $user['admin'] ) {

	   $status = $edit['status'];

	} else if ($user['editor']) {

	   $status = $edit['status'] == 'reviewed' ? 'edited' : $edit['status'];

	}
	
	/*
	print_r($edit);
	
	$db->debug = true;
	*/

    // If the name1id, name2id or locationid is "new", check to see whether it does actually already exist.
    // if not, insert the new name into the DB and set the id
    $name1 = get_or_set_values($db, $db_prefix, $edit['id'], 'name', $edit['name1text'], $edit['name1id']);
    if (isset($name1['is_error'])) {
   	   $smarty->assign( $params['error'], $name1['error_msg'] );
   	   return;
    }
    
    $name2 = get_or_set_values($db, $db_prefix, $edit['id'], 'name', $edit['name2text'], $edit['name2id']);
    if (isset($name2['is_error'])) {
   	   $smarty->assign( $params['error'], $name2['error_msg'] );
   	   return;
    }
    
    $location = get_or_set_values($db, $db_prefix, $edit['id'], 'location', $edit['city'], $edit['locationid']);
    if (isset($location['is_error'])) {
   	   $smarty->assign( $params['error'], $location['error_msg'] );
   	   return;
    }

    $export_systems = array('prometheus', 'sid', 'unimedia');
    $exports = '';
    foreach ($export_systems as $system) {
        $exports .= ", exp_{$system} = " . (int)(!empty($edit['export'][$system]));
    }

    $datestring = trim($edit['dating']);
	$sql =
    "UPDATE {$db_prefix}meta
    SET `type`=".$db->qstr($edit['type'])."
    ,`status`=".$db->qstr($status)."
    ,name1id='{$name1['id']}'
    ,name2id='{$name2['id']}'
    ,locationid='{$location['id']}'
    ,name1=".$db->qstr($name1['name'])."
    ,name2=".$db->qstr($name2['name'])."
    ,location=".$db->qstr($location['location'])."
    ,name1sounds=".$db->qstr($name1['sounds'])."
    ,name2sounds=".$db->qstr($name2['sounds'])."
    ,locationsounds=".$db->qstr($location['sounds'])."
    ,addition=".$db->qstr(trim($edit['addition']))."
    ,title=".$db->qstr(trim($edit['title']))."
    ,dating=".$db->qstr($datestring)."
    ,material=".$db->qstr(trim($edit['material']))."
    ,technique=".$db->qstr(trim($edit['technique']))."
    ,format=".$db->qstr(trim($edit['format']))."
    ,institution=".$db->qstr(trim($edit['institution']))."
    ,literature=".$db->qstr(trim($edit['literature']))."
    ,page=".$db->qstr(trim($edit['page']))."
    ,figure=".$db->qstr(trim($edit['figure']))."
    ,`table`=".$db->qstr(trim($edit['table']))."
    ,isbn=".$db->qstr(trim($edit['isbn']))."
    ,keyword=".$db->qstr(trim($edit['keyword']))."
    ,metacreator=".$db->qstr(trim($edit['metacreator']))."
    ,metaeditor=".$db->qstr(trim($edit['metaeditor']))."
    ,imagerights=".$db->qstr(trim($edit['imagerights']))."
    ,commentary=".$db->qstr(trim($edit['commentary']))."
    ,modify_date=NOW()".
    $exports ."
WHERE
    collectionid=$collectionid
    AND imageid=$imageid;";
//die($sql);

   $sqls = $sql;
   if( !$db->Execute( $sql ))
   {
   	   $error = $db->ErrorMsg()."[$sql]";
   }
   else
   {
	   $sql = "DELETE FROM {$db_prefix}dating WHERE collectionid=$collectionid AND imageid=$imageid;";
	   $sqls .= "\n".$sql;
	   if( !$db->Execute( $sql ))
	   {
	   	   $error .= "\n".$db->ErrorMsg()."[$sql]";
	   }
	   else
	   {
	   	   dating( $db, $datestring, $datelist );
	   	   foreach( $datelist as $date)
	   	   {
	   	   	   $sql = "INSERT INTO {$db_prefix}dating(collectionid,imageid,`from`,`to`) VALUES('$collectionid', '$imageid', {$date['from']}, {$date['to']})";
			   $sqls .= "\n".$sql;
			   if( !$db->Execute( $sql ))
			   {
			   	   $error .= "\n".$db->ErrorMsg()."[$sql]";
		   	   }
		   }

		   $sql = "update {$db_prefix}dating d,  {$db_prefix}meta m".
		   			" set d.metaid=m.id".
		   			" where m.collectionid = '$collectionid' and m.imageid = '$imageid'".
		   			" and m.collectionid = d.collectionid and m.imageid = d.imageid";
		   if( !$db->Execute( $sql ))
		   {
		   	   $error .= "\n".$db->ErrorMsg()."[$sql]";
	   	   }
	   }

   }
   
	// clear temporary values in session
	
	if (isset($_SESSION['tempvals']))
	{
		unset($_SESSION['tempvals']);
	}
   
	// save additional fields for archaeology
	if ($edit['type'] == 'archaeology')
	{
		// $db->debug = true;
		
		$sql = "DELETE FROM {$db_prefix}archaeology WHERE collectionid=$collectionid AND imageid=$imageid;";
		$sqls .= "\n".$sql;
		if( !$db->Execute( $sql ))
		{
			   $error .= "\n".$db->ErrorMsg()."[$sql]";
		}
		else
		{
			$sql =	"INSERT INTO {$db_prefix}archaeology (".
					"  `collectionid`, `imageid`".
					" ,`category_fn`, `category`".
					" ,`iconography_fn`, `iconography` ".
					" ,`dating_ext_fn`, `dating_ext` ".
					" ,`material_ext_fn`, `material_ext` ".
					" ,`location_ext_fn`, `location_ext` ".
					" ,`obj_culture_fn`, `obj_culture` ".
					" ,`obj_culthistory_fn`, `obj_culthistory` ".
					" ,`obj_topography_fn`, `obj_topography` ".
					" ,`obj_arch_structelems_fn`, `obj_arch_structelems` ".
					" ,`obj_arch_tenement_fn`, `obj_arch_tenement` ".
					" ,`obj_arch_funcbuild_fn`, `obj_arch_funcbuild` ".
					" ,`obj_arch_amusement_fn`, `obj_arch_amusement` ".
					" ,`obj_arch_economy_fn`, `obj_arch_economy` ".
					" ,`obj_arch_sacral_fn`, `obj_arch_sacral` ".
					" ,`obj_arch_sepulchre_fn`, `obj_arch_sepulchre` ".
					" ,`obj_arch_military_fn`, `obj_arch_military` ".
					" ,`obj_mosaic_fn`, `obj_mosaic` ".
					" ,`obj_painting_fn`, `obj_painting` ".
					" ,`obj_sculpture_fn`, `obj_sculpture` ".
					" ,`obj_portrait_fn`, `obj_portrait` ".
					" ,`obj_ceramic_vascularforms_fn`, `obj_ceramic_vascularforms` ".
					" ,`obj_ceramic_groups_fn`, `obj_ceramic_groups` ".
					" ,`obj_toreutics_fn`, `obj_toreutics` ".
					" ,`obj_jewellery_fn`, `obj_jewellery` ".
					" ,`obj_glass_fn`, `obj_glass` ".
					" ,`obj_glyptics_fn`, `obj_glyptics` ".
					" ,`obj_numismatics_fn`, `obj_numismatics` ".
					" ,`obj_textiles_fn`, `obj_textiles` ".
					" ,`obj_misc_fn`, `obj_misc` ".
					" ,`obj_epigraphy_fn`, `obj_epigraphy` ".
					" ,`obj_methods_fn`, `obj_methods` ".
					" ,`obj_reception_fn`, `obj_reception` ".
					" ) VALUES (".
					$collectionid.",".$imageid.",".
					$db->qstr(trim($edit['category_fn'])).",".
					$db->qstr(trim($edit['category'])).",".
					$db->qstr(trim($edit['iconography_fn'])).",".
					$db->qstr(trim($edit['iconography'])).",".
					$db->qstr(trim($edit['dating_ext_fn'])).",".
					$db->qstr(trim($edit['dating_ext'])).",".
					$db->qstr(trim($edit['material_ext_fn'])).",".
					$db->qstr(trim($edit['material_ext'])).",".
					$db->qstr(trim($edit['location_ext_fn'])).",".
					$db->qstr(trim($edit['location_ext'])).",".
					$db->qstr(trim($edit['obj_culture_fn'])).",".
					$db->qstr(trim($edit['obj_culture'])).",".
					$db->qstr(trim($edit['obj_culthistory_fn'])).",".
					$db->qstr(trim($edit['obj_culthistory'])).",".
					$db->qstr(trim($edit['obj_topography_fn'])).",".
					$db->qstr(trim($edit['obj_topography'])).",".
					$db->qstr(trim($edit['obj_arch_structelems_fn'])).",".
					$db->qstr(trim($edit['obj_arch_structelems'])).",".
					$db->qstr(trim($edit['obj_arch_tenement_fn'])).",".
					$db->qstr(trim($edit['obj_arch_tenement'])).",".
					$db->qstr(trim($edit['obj_arch_funcbuild_fn'])).",".
					$db->qstr(trim($edit['obj_arch_funcbuild'])).",".
					$db->qstr(trim($edit['obj_arch_amusement_fn'])).",".
					$db->qstr(trim($edit['obj_arch_amusement'])).",".
					$db->qstr(trim($edit['obj_arch_economy_fn'])).",".
					$db->qstr(trim($edit['obj_arch_economy'])).",".
					$db->qstr(trim($edit['obj_arch_sacral_fn'])).",".
					$db->qstr(trim($edit['obj_arch_sacral'])).",".
					$db->qstr(trim($edit['obj_arch_sepulchre_fn'])).",".
					$db->qstr(trim($edit['obj_arch_sepulchre'])).",".
					$db->qstr(trim($edit['obj_arch_military_fn'])).",".
					$db->qstr(trim($edit['obj_arch_military'])).",".
					$db->qstr(trim($edit['obj_mosaic_fn'])).",".
					$db->qstr(trim($edit['obj_mosaic'])).",".
					$db->qstr(trim($edit['obj_painting_fn'])).",".
					$db->qstr(trim($edit['obj_painting'])).",".
					$db->qstr(trim($edit['obj_sculpture_fn'])).",".
					$db->qstr(trim($edit['obj_sculpture'])).",".
					$db->qstr(trim($edit['obj_portrait_fn'])).",".
					$db->qstr(trim($edit['obj_portrait'])).",".
					$db->qstr(trim($edit['obj_ceramic_vascularforms_fn'])).",".
					$db->qstr(trim($edit['obj_ceramic_vascularforms'])).",".
					$db->qstr(trim($edit['obj_ceramic_groups_fn'])).",".
					$db->qstr(trim($edit['obj_ceramic_groups'])).",".
					$db->qstr(trim($edit['obj_toreutics_fn'])).",".
					$db->qstr(trim($edit['obj_toreutics'])).",".
					$db->qstr(trim($edit['obj_jewellery_fn'])).",".
					$db->qstr(trim($edit['obj_jewellery'])).",".
					$db->qstr(trim($edit['obj_glass_fn'])).",".
					$db->qstr(trim($edit['obj_glass'])).",".
					$db->qstr(trim($edit['obj_glyptics_fn'])).",".
					$db->qstr(trim($edit['obj_glyptics'])).",".
					$db->qstr(trim($edit['obj_numismatics_fn'])).",".
					$db->qstr(trim($edit['obj_numismatics'])).",".
					$db->qstr(trim($edit['obj_textiles_fn'])).",".
					$db->qstr(trim($edit['obj_textiles'])).",".
					$db->qstr(trim($edit['obj_misc_fn'])).",".
					$db->qstr(trim($edit['obj_misc'])).",".
					$db->qstr(trim($edit['obj_epigraphy_fn'])).",".
					$db->qstr(trim($edit['obj_epigraphy'])).",".
					$db->qstr(trim($edit['obj_methods_fn'])).",".
					$db->qstr(trim($edit['obj_methods'])).",".
					$db->qstr(trim($edit['obj_reception_fn'])).",".
					$db->qstr(trim($edit['obj_reception'])).")";
	
			$sqls .= "\n".$sql;
			if( !$db->Execute( $sql ))
			{
				   $error = $db->ErrorMsg()."[$sql]";
			}
		}
	}

	$smarty->assign( $params['error'], $error );
	if( isset( $params['sql'] ))
	{
		  $smarty->assign( $params['sql'], $sqls );
	}
}


/*
* queries db for existing id of a record which matches $text
* if no record found, inserts a new record
* @return array of id, soundstring, and text of record
*/
function get_or_set_values($db, $db_prefix, $dilpsid, $field, $fieldtext, $recordid) {
//    $name1 = get_or_set_values($db, $db_prefix, $edit['id'], 'name', $edit['name1text'], $edit['name1id']);
    global $config;
    include_once($config['includepath'].'thesauri/soundex_fr.php');

    // $db->debug = true;

    switch ($field) {

        case 'location' :
            $table = 'location';
            break;

        case 'name' :
            $table = 'artist';
            break;

        default:
            $id['is_error'] = true;
            $id['error_msg'] = "\n" . __FILE__ ."::".__LINE__.": Unrecognized field parameter: $field\n";
            return $id;
    }

    $table = $db_prefix . $table;
    $text = trim($fieldtext);

    if ($text == '') {
        $result['id'] = 0;
        $result[$field] = $text;
        $result['sounds'] = '';
    } else {
        if ($recordid == 'new') {
            $sql = "select id,  $field, sounds from $table where lower('$text') = trim(lower($field))";
        } else {
            $sql = "select id,  $field, sounds from $table where id = '$recordid'";
        }

        //bk: here, may need to handle multiple results - user should be able to pick from available locations
        //    or specify a new hierarchy for the given location
        // for now, just take the first result
        // hopefully, the thesaurus will be comprehensive enough, so that this won't be a problem
        $rs = $db->GetRow($sql);
        if ($rs === false) {

            $result['is_error'] = true;
            $result['error_msg'] = "\n".$db->ErrorMsg()."[$sql]";

        } else if (empty($rs)) {

        	// sometimes 'new' is not set correctly, workaround this
        	
        	/*
            if ($recordid != 'new') {

                $result['is_error'] = true;
                $result['error_msg'] = "\nNo record found, when id should exist [$sql]";

            } else {
                $result = false;
            }
            */
        	
        	$result = false;

        } else {
            $result = $rs;
        }
    }

    // if no matching record was found, insert a new one and get it's id
    if ($result === false) {

        $tdb = new thesaurusDB($db, $db_prefix);

        $sounds = $tdb->get_sounds_string($text);

        if ($field == 'location') {
            $sql = "insert into $table (src, source_id, location, loc_type, sounds) ".
                "values ('dilps',".$db->qstr($dilpsid).",".$db->qstr($text).", '83002/inhabited place',".$db->qstr($sounds).")";
        } else if ($field == 'name') {
            $sql = "insert into $table (src, name, sounds) ".
                "values ('dilps',".$db->qstr($text).",".$db->qstr($sounds).")";
        } else {
            $sql = "error";
        }
//die("about to insert: $sql");
        if (!$db->Execute($sql)) {
            $result['is_error'] = true;
            $result['error_msg'] = "\n".$db->ErrorMsg()."[$sql]";
        } else {
            $result['id'] = $db->Insert_ID();
            $result[$field] = $text;
            $result['sounds'] = $sounds;
        }
    }

    return $result;
}

?>