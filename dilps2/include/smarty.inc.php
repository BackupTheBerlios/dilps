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
* smarty include file
* -------------------------------------------------------------
* File:     smarty.inc.php
* Purpose:  provided by smarty installation
* -------------------------------------------------------------
*/
//error_reporting(E_ALL);

/**
* smarty config
*/

$smarty = new Smarty();
$smarty->template_dir = $config['skinBase'];
$smarty->compile_dir = $config['smartyBase'].'template_c/';
$smarty->cache_dir = $config['smartyBase'].'cache/';
$smarty->plugins_dir[] = $config['includepath'].'plugins/';

$smarty->force_compile = true;
$smarty->caching = false;
$smarty->compile_check = true;
$smarty->debugging = true;

?>
