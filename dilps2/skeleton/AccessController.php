<?php
/*      
   +----------------------------------------------------------------------+
   | DILPS - Distributed Image Library System                             |
   +----------------------------------------------------------------------+
   | Copyright (c) 2002-2006 Juergen Enge                                 |
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

// note: change this so that it finds the file.  "$cfg->dirroot/somedir/DilpsDefines.php", for example.

require_once("DilpsDefines.php");

/**
 * class AccessController
 * 
 * this class is used to verify user permissions for librarys or their objects
 * assumed is that there is a database table behind this with the following columns:
 * objectType int unsigned,
 * objectId int unsigned,
 * userGroupId int unsigned,
 * permission int unsigned
 * 
 * objectType (e.g. DL_COLLECTION) and permission values (e.g. DL_AC_VIEW) are defined in DilpsDefines.php
 */
class AccessController
{

    /**
     * Constructor
     *
     * @return AccessController
     */
    function AccessController() {
        die ('unimplemented: '.__CLASS__.'::'.__FUNCTION__.' ('.__LINE__.':'.__FILE__.')');
        
    }

    /**
     * based on user's groups, check whether user has permission to perform the given action
     *
     * @param User user
     * @param int objectType
     * @param int action
     * @return boolean
     * @access public
     */
    function userHasPermission( $user,  $objectType,  $action )
    {
        die ('unimplemented: '.__CLASS__.'::'.__FUNCTION__.' ('.__LINE__.':'.__FILE__.')');
    }
    

} // end of AccessController
?>
