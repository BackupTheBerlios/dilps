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

 * File:     function.mygroup_isin.php

 * Type:     function

 * Name:     mygroup_isin

 * Purpose:  tests if an image is in the specified group

 * -------------------------------------------------------------

 */


global $config;
include_once($config['includepath'].'tools.inc.php');

function smarty_function_mygroup_isin($params, &$smarty)
{
    if (empty($params['ingroup'])) {
        $smarty->trigger_error("assign: missing 'ingroup' parameter");
        return;
    }
    
    if (empty($params['changeable'])) {
        $smarty->trigger_error("assign: missing 'changeable' parameter");
        return;
    }

    //print_r($params);

    global $db, $db_prefix, $user;

    // $db->debug = true;

 

    if (empty($params['cid'])) {

    	$smarty->trigger_error("assign: missing 'cid' parameter");
        return;
    }
    else {
    	$collectionid = $params['cid'];
    }

    

    if (empty($params['groupid'])) {
    	$smarty->trigger_error("assign: missing 'groupid' parameter");
        return;
    }
    else {
    	$groupid = $params['groupid'];
    }

    

     if (empty($params['imageid'])) {

    	$smarty->trigger_error("assign: missing 'imageid' parameter");

        return;

    } else {

    	$imageid = $params['imageid'];

    }
    
    // search all subgroups, too    

 	$sql = "SELECT * FROM ".$db_prefix."img_group WHERE "
 			."collectionid=".$db->qstr($collectionid)
 			." AND imageid=".$db->qstr($imageid)
 			.get_groupid_where($groupid,$db,$db_prefix,true); 	

 	$rs  = $db->Execute ($sql);
 	
 	// print_r($rs->fields);

 	if ($rs->RecordCount() > 0) {
 		$ingroup = 'yes';
 	} else {
 		$ingroup = 'no';
 	}

 	$changeable = 'no';
 	
 	$sql2 = "SELECT * FROM ".$db_prefix."group WHERE "
 			."id = ".$db->qstr($groupid);

 	$rs2  = $db->Execute($sql2);

 	/*
 	print_r($user);
 	
 	print_r($rs2->fields);
 	*/
 	
 	if ($rs2)
 	{
 		if (($user["login"] == $rs2->fields["owner"]) || ($user["editgroups"])) {
 			$changeable = 'yes';
 		}
 	}
 	
 	// echo ("ingroup: {$ingroup}, changeable: {$changeable}");

    $smarty->assign($params['ingroup'], $ingroup);
    
    $smarty->assign($params['changeable'], $changeable);

    if( !empty($params['sql'])) {
		     $smarty->assign($params['sql'], $sql);
	 }

}

?>

