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
 * File:     function.archaeology_element.php
 * Type:     function
 * Name:     archaeology_element
 * Purpose:  query additional data from the archaeology table
 * -------------------------------------------------------------
 */

global $config;
require_once( $config['includepath'].'tools.inc.php' );

function smarty_function_query_ext_element($params, &$smarty)
{
	if (empty($params['type'])) {
        $smarty->trigger_error("assign: missing 'type' parameter");
        return;
    } else {
        $type = $params['type'];
    }
	
    if (empty($params['fieldnames'])) {
        $smarty->trigger_error("assign: missing 'fieldnames' parameter");
        return;
    }
    
    if (empty($params['values'])) {
        $smarty->trigger_error("assign: missing 'values' parameter");
        return;
    }

    if (empty($params['query'])) {
        $smarty->trigger_error("assign: missing 'query' parameter");
        return;
    } else {
        $query = $params['query'];
    }
    
   	if (empty($params['element'])) {
        $smarty->trigger_error("assign: missing 'element' parameter");
        return;
    }
    else {
    	$element = $params['element'];
    }
    
	//debug($query);
	global $db, $db_prefix;
	
	extractID($query['id'],$collectionid,$imageid);
	
	$fieldnames = array();
	$values		= array();
	
	global $_SESSION;
	
	if (isset($_SESSION[$element."_fn"]) && isset($_SESSION[$element]))
	{
		$fieldnames = $_SESSION[$element."_fn"];
		$values		= $_SESSION[$element];
		
		$sql		= "element {$element} loaded from session";
	}
	else 
	{
		// load fieldnames and values for the specified element
		$sql = 	"SELECT `".$element."_fn` as fn, `".$element."` as value ".
				"FROM {$db_prefix}{$type} ".
				"WHERE".
	    		" collectionid=".$collectionid.
	    		" AND imageid=".$imageid;
		
		$row = $db->GetRow( $sql );
	
		/*
		if (trim($row['fn'] != ""))
		{
			$fieldnames = explode("; ",trim($row['fn']));
		}
		if (trim($row['value'] != ""))
		{
			$values 	= explode("; ",trim($row['value']));
		}
		*/
		
		$fieldnames = $row['fn'];
		$values = $row['value'];
	}

	/*
	print_r($fieldnames);
	print_r($values);
	*/
	
	$smarty->assign($params['fieldnames'], $fieldnames);
	$smarty->assign($params['values'], $values);

	 if( !empty($params['sql'])) {
		     $smarty->assign($params['sql'], $sql);
	 }
}
?>
