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

 * File:     function.image_isremote.php

 * Type:     function

 * Name:     collection_isremote

 * Purpose:  tests if an image is part of a remote collection

 * -------------------------------------------------------------

 */


global $config;
include_once($config['includepath'].'tools.inc.php');

function smarty_function_image_isremote($params, &$smarty)
{
    if (empty($params['isremote'])) {
        $smarty->trigger_error("assign: missing 'isremote' parameter");
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
    
    if (empty($params['imageid'])) {
    	$smarty->trigger_error("assign: missing 'imageid' parameter");
        return;
    }
    else {
    	$imageid = $params['imageid'];
    }
    
    // check for host entry
    $sql = "SELECT {$db_prefix}img.img_baseid as baseid, host FROM {$db_prefix}img,{$db_prefix}img_base WHERE {$db_prefix}img.imageid=".intval($imageid)
    		." AND {$db_prefix}img.collectionid=".intval($collectionid)
    		." AND {$db_prefix}img.collectionid={$db_prefix}img_base.collectionid"
    		." AND {$db_prefix}img.img_baseid={$db_prefix}img_base.img_baseid";
    	
	$row =	$db->GetRow( $sql );
	
	$baseid	= $row['baseid'];
	$host	= $row['host'];
    
 	if ($host != 'localhost' && $host != 'local' && $host != '') {
 		$isremote = 'yes';
 	} else {
 		$isremote = 'no';
 	}
 	
    $smarty->assign($params['isremote'], $isremote);
    
    if( !empty($params['sql'])) {
		     $smarty->assign($params['sql'], $sql);
	 }

}

?>

