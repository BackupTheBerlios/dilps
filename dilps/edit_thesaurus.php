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
 * -------------------------------------------------------------
 * File:    edit_thesaurus.php
 * Purpose: Allows changing or deleting artist names / location names / institution names
 * Notes:   $query['element'] indicates what to change: 
 *                name = artist name
 *                location = location
 *                institution = institution
 *          institutions don't have a thesaurus. the list of institution for a city is created by a "select distinct instition from meta where locationid = x;".
 * -------------------------------------------------------------
 */

// import standard libraries and configuraiton values
require('includes.inc.php');
// read sessiond id from get/post
if (isset($_REQUEST['PHPSESSID']))
{
	$sessionid = $_REQUEST['PHPSESSID'];
}
else
{
	$sessionid = '';
}
$error = false;
$success = false;
$query = array();
$tpl = 'edited_thesaurus.tpl';
if( is_array( $_REQUEST['query'] )) {
	$query = $_REQUEST['query'];
} else {
    $query = array();
}

$elementid = $db->quote($query['elementid']);
$row = false;
if (empty($query['editaction'])) {

    // this is a new request to change an element: get information necessary and show template
    
    // db and db_prefix are global variables available here
    switch ($query['element']) {
        case 'name':
            $sql = "select * from {$db_prefix}artist where id = $elementid";
            break;
        case 'location':
            $sql = "select * from {$db_prefix}location where id = $elementid";
            break;
        case 'institution':
            $sql = "select * from {$db_prefix}meta where id = $elementid";
            break;
        default:
            $error = 'err_missingparam';
            break;
    }
    if (!$error) {
        if (!$row = $db->GetRow($sql)) {
            $error = 'err_norecord';
        }
        $smarty->assign('row',$row);
    }
    $tpl = 'edit_thesaurus.tpl';
} else if ($query['editaction'] == 'update') {
    list($success, $error) = updateThesaurusEntry($elementid, $query);
} else if ($query['editaction'] == 'delete') {
    list($success, $error) = deleteThesaurusEntry($elementid, $query);
} else {
    $error = 'err_missingparam';
}
if ($error) {
    // get language-appropriate messge
    $error = getErrorMessage($error);
}

showTemplate($tpl, $success, $error, $row);


function showTemplate($tpl, $success, $error, $row = false, $options = false) {
    global $smarty, $sessionid, $query, $config;
    $smarty->assign('sessionid',$sessionid);
    $smarty->assign('row',$row);
    $smarty->assign('options',$options);
    $smarty->assign( 'query', $query );
    $smarty->assign('success',$success);
    $smarty->assign('error',$error);
    $smarty->display( $config['skin'].DIRECTORY_SEPARATOR.$tpl );
    exit;
}

function updateThesaurusEntry($elementid, $query) {
    // wouldn't it be nice if our database supported transactions? ;\
    $success = false;
    $error = false;
    global $db, $db_prefix;
    $newvalue = $db->quote($query['newvalue']);
    switch ($query['element']) {
        case 'name':
            $sql = "select * from {$db_prefix}artist where id = $elementid";
            if ($row = $db->GetRow($sql)) {
                $artistid = $db->quote($row['id']);
                $newartistid = $artistid;
                if ($artistid != "'0'") {  // don't update the '0' = noplace record
                    // if there's an already existing entry for the specified value, delete the current row
                    $src = $db->quote($row['src']);
                    $name = $db->quote($row['name']);
                    $sql = "select * from {$db_prefix}artist where name = $newvalue and src = $src and id != $artistid";
                    if ($existingrow = $db->getRow($sql)) {
                        // the specified new value already exists as a previous entry; delete this entry and change everything to point to the existing entry
                        $sql = "delete from {$db_prefix}artist where id = $artistid";
                        if ($result = $db->Execute($sql)) {
                            $newartistid = $db->quote($existingrow['id']);
                        } else {
                            $error = 'err_removing_old_row';
                        }
                        $newsounds = $db->quote($existingrow['sounds']);
                    } else {
                        // no existing entry matches the new value; so update the current record
                        $tdb = getThesaurusDB();
                        $sounds = $tdb->get_sounds_string($query['newvalue']);
                        $newsounds = $db->quote($sounds);
                        $sql = "update {$db_prefix}artist set name = $newvalue, sounds = $newsounds where id=$artistid";
                        if (!$result = $db->Execute($sql)) {
                            $error = 'err_updateerror';
                        }
                    }
                    if (!$error) {
                        $sql = "update {$db_prefix}meta"
                               ." set name1id = $newartistid,"
                               ." name1 = $newvalue,"
                               ." name1sounds = $newsounds"
                               ." where name1id=$artistid";
                        if ($result = $db->Execute($sql)) {
                            $sql = "update {$db_prefix}meta"
                                   ." set name2id = $newartistid,"
                                   ." name2 = $newvalue,"
                                   ." name2sounds = $newsounds"
                                   ." where name2id=$artistid";
                            if ($result = $db->Execute($sql)) {
                                $success = true;        
                            } else {
                                $error = 'err_update_child_table_2';
                            }
                        } else {
                            $error = 'err_update_child_table_1';
                        }
                    }
                } else {
                    $error = 'err_unsafe_update_requested';
                }
            } else {
                $error = 'err_norecord';
            }
            break;
        case 'location':
            $sql = "select * from {$db_prefix}location where id = $elementid";
            if ($row = $db->GetRow($sql)) {
                $locationid = $db->quote($row['id']);
                $newlocationid = $locationid;
                if ($locationid != "'0'") {  
                    if (!empty($query['newvalueid'])) {
                        $id = $db->quote($query['newvalueid']);
                        $sql = "select * from {$db_prefix}location where id = $id";
                    } else {
                        $sql = "select * from {$db_prefix}location where location = $newvalue and id != $locationid order by length(hierarchy)";    
                    }
                    $existingrecords = $db->getAll($sql);
                    if ($existingrecords !== false) {
                        switch (count($existingrecords)) {
                            case 0:
                                $existing = false;
                                break;
                            case 1:
                                $existing = true;
                                $existingrow = $existingrecords[0];
                                break;
                            default:
                                $options = array ('locations' => $existingrecords);
                                showTemplate('edit_thesaurus_new.tpl', true, false, $row, $options);
                                exit;
                        }
                        if ($existing) {
                            $sql = "delete from {$db_prefix}location where id = $locationid";
                            if ($result = $db->Execute($sql)) {
                                $newlocationid = $db->quote($existingrow['id']);
                                $newsounds = $db->quote($existingrow['sounds']);
                            } else {
                                $error = 'err_removing_old_row';
                            }
                        } else {
                            $tdb = getThesaurusDB();
                            $sounds = $tdb->get_sounds_string($query['newvalue']);
                            $newsounds = $db->quote($sounds);
                            $sql = "update {$db_prefix}location set location = $newvalue, sounds = $newsounds, hierarchy='', src='dilps' where id=$locationid";
                            if (!$result = $db->Execute($sql)) {
                                $error = 'err_updateerror';
                            }
                        }
                        if (!$error) {
                            $sql = "update {$db_prefix}meta"
                                   ." set locationid = $newlocationid,"
                                   ." location = $newvalue,"
                                   ." locationsounds = $newsounds"
                                   ." where locationid=$locationid";
                            if ($result = $db->Execute($sql)) {
                                $success = true;        
                            } else {
                                $error = 'err_update_child_table';
                            }
                        }
                    } else {
                        $error = 'err_dberror';
                    }
                } else {
                    // don't update the '0' = noplace record
                    $error = 'err_unsafe_update_requested';
                }
            } else {
                $error = 'err_norecord';
            }
            break;
        case 'institution':
            $sql = "select * from {$db_prefix}meta where id = $elementid";
            if ($row = $db->GetRow($sql)) {
                $locationid = $db->quote($row['locationid']);
                $old = $db->quote($row['institution']);
                if ($locationid != "'0'" && strlen($old) > 2) {  
                    $sql = "update {$db_prefix}meta set institution=$newvalue"
                           ." where locationid = $locationid"
                           ." and institution = $old";
                    if ($row = $db->Execute($sql)) {
                        $success = true;        
                    } else {
                        $error = 'err_updateerror';
                    }
                } else {
                    // we shouldn't be updating empty institutions (this would update all empty institutions for the given location)
                    $error = 'err_unsafe_delete_requested';
                }
            } else {
                $error = 'err_norecord';
            }
            break;
        default:
            $error = 'err_missingparam';
            break;
    }
    return (array($success, $error));
}

function deleteThesaurusEntry($elementid, $query) {
    // wouldn't it be nice if our database supported transactions? ;\
    $success = false;
    $error = false;
    global $db, $db_prefix;
    switch ($query['element']) {
        case 'name':
            // if deleting 1st artist, replace all name1 fields with the values from name2 fields
            // if deleting 2nd artist, set all name2 fields to default empty values
            $sql = "select * from {$db_prefix}artist where id = $elementid";
            if ($row = $db->GetRow($sql)) {
                $artistid = $db->quote($row['id']);
                if ($artistid != "'0'") {  // don't delete the '0' = noone record
                    $sql = "delete from {$db_prefix}artist where id=$artistid";
                    if ($result = $db->Execute($sql)) {
                        $sql = "update {$db_prefix}meta set"
                               ." name1id = name2id, name1=name2, name1sounds=name2sounds,"
                               ." name2id = 0, name2=null, name2sounds=null"
                               ." where name1id=$artistid";
                        if ($result = $db->Execute($sql)) {
                            $sql = "update {$db_prefix}meta set name2id=0, name2=null, name2sounds=null where name2id=$artistid";
                            if ($result = $db->Execute($sql)) {
                                $success = true;        
                            } else {
                                $error = 'err_update_child_table_2';
                            }
                        } else {
                            $error = 'err_update_child_table_1';
                        }
                    } else {
                        $error = 'err_updateerror';
                    }
                } else {
                    $error = 'err_unsafe_update_requested';
                }
            } else {
                $error = 'err_norecord';
            }
            break;
        case 'location':
            $sql = "select * from {$db_prefix}location where id = $elementid";
            if ($row = $db->GetRow($sql)) {
                $locationid = $db->quote($row['id']);
                if ($locationid != "'0'") {  // don't delete the '0' = noplace record
                    $sql = "delete from {$db_prefix}location where id=$locationid";
                    if ($result = $db->Execute($sql)) {
                        $sql = "update {$db_prefix}meta set locationid = 0, location='', locationsounds='' where locationid=$locationid";
                        if ($result = $db->Execute($sql)) {
                            $success = true;        
                        } else {
                            $error = 'err_update_child_table';
                        }
                    } else {
                        $error = 'err_updateerror';
                    }
                } else {
                    $error = 'err_unsafe_update_requested';
                }
            } else {
                $error = 'err_norecord';
            }
            break;
        case 'institution':
            $sql = "select * from {$db_prefix}meta where id = $elementid";
            if ($row = $db->GetRow($sql)) {
                $locationid = $db->quote($row['locationid']);
                $old = $db->quote($row['institution']);
                if ($locationid != "'0'" && strlen($old) > 2) {  // we shouldn't be updating empty institutions (this would update all empty institutions for the given location)
                    $sql = "update {$db_prefix}meta set institution=''"
                           ." where locationid = $locationid"
                           ." and institution = $old";
                    if ($result = $db->Execute($sql)) {
                        $success = true;        
                    } else {
                        $error = 'err_updateerror';
                    }
                } else {
                    $error = 'err_unsafe_update_requested';
                }
            } else {
                $error = 'err_norecord';
            }
            break;
        default:
            $error = 'err_missingparam';
            break;
    }
    return (array($success, $error));
}

function getThesaurusDB() {
    global $config, $db, $db_prefix;
    include_once($config['includepath'].'thesaurusDB.class.php');
    $tdb = new thesaurusDB($db, $db_prefix);
    return $tdb;
}

function getErrorMessage($key) {
    global $smarty, $config;
    include_once($config['smartyBase'].'Config_File.class.php');
    $path = $config['skinBase'].$config['skin'].'/'.$config['language'];
    $file = 'edit_thesaurus.conf';
    $cf = new Config_File($path);
    $message = $cf->get($file, null, $key);
    if (!$message) {
        $message = "[[$key]]";
    }
    return $message;
}
?>
