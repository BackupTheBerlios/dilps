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
 * determine the correct template for editing archaeology fields
 * -------------------------------------------------------------
 * File:     	edit_arch_element.php
 * Purpose:  	determines the correct template for editing a
 *				multiple choice archaeology field
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

$query = array();
if( is_array( $_REQUEST['query'] ))
	$query = $_REQUEST['query'];
	
// print_r($_REQUEST);

switch( $query['element'] )
{
	case 'category':
	   $tpl = 'ac_edit_category.tpl';
		break;
	case 'dating_ext':
	   $tpl = 'ac_edit_dating_ext.tpl';
		break;
	case 'iconography':
	   $tpl = 'ac_edit_iconography.tpl';
		break;
	case 'material_ext':
	   $tpl = 'ac_edit_material_ext.tpl';
		break;
	case 'obj':
	   $tpl = 'ac_edit_obj.tpl';
		break;
	default:
	   $tpl = 'ac_edit_'.$query['element'].'.tpl';
}

$smarty->assign('sessionid',$sessionid);
$smarty->assign( 'query', $query );


$smarty->display( $config['skin'].DIRECTORY_SEPARATOR.$tpl );

//phpinfo();
?>
