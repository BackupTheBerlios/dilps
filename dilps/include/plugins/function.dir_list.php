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
 * File:     function.basedir_list.php
 * Type:     function
 * Name:     basedir_list
 * Purpose:  assign the basedir_list to a template var
 * -------------------------------------------------------------
 */
function smarty_function_dir_list($params, &$smarty)
{
    if (empty($params['var'])) {
        $smarty->trigger_error("assign: missing 'var' parameter");
        return;
    }
    
    if (empty($params['dir'])) {
    	$smarty->trigger_error("assign: missing 'dir' parameter");
    	return;
    }
    
    $dirs = array();
    
    $base = $params['dir'];

    $dirhandle = opendir($base);
		
	while (false !== ($file = readdir ($dirhandle))) {
		if (is_dir($base.$file) and $file != '.' and $file != '..'){
			$dirs[] = array ("name" => $file);
		}
	}
	
	if (empty($dirs))
		$dirs[] = array("name" => "no_subdirs");
	 
    $smarty->assign($params['var'], $dirs);
	 
}
?>