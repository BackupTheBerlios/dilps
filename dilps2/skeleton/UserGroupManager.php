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



/**
 * class UserGroupManager
 * 
 * this class is used to manage user groups
 * 
 * users and usergroups are related by a relation table:
 * 
 * usergroup table:
 * id int unsigned,
 * name varchar(50),
 * unique (name)
 * 
 * user_usergroup table:
 * userid int unsigned,  <-- user.id
 * usergroupid int unsigned,  <-- usergroup.id
 * unique (userid, usergroupid)
 * 
 * user table:
 * id,
 * ...
 * 
 */
class UserGroupManager
{

    /**
     * Constructor
     *
     * @return UserGroupManager
     */
    function UserGroupManager() {
        die ('unimplemented: '.__CLASS__.'::'.__FUNCTION__.' ('.__LINE__.':'.__FILE__.')');
    }
    
    /**
     * create a new Group
     *
     * @param array $groupinfo
     * @return boolean
     */
    function createGroup($groupinfo) {
        // make sure user is authorized to do this
        die ('unimplemented: '.__CLASS__.'::'.__FUNCTION__.' ('.__LINE__.':'.__FILE__.')');
    }
    
    /**
     * gets a list of all groups
     *
     * @return array of arrays
     */
    function getGroups() {
        die ('unimplemented: '.__CLASS__.'::'.__FUNCTION__.' ('.__LINE__.':'.__FILE__.')');
    }
    
    /**
     * update group with new information
     *
     * @param array $groupinfo, with id field
     * @return boolean
     */
    function alterGroup($groupinfo) {
        // make sure user is authorized to do this
        die ('unimplemented: '.__CLASS__.'::'.__FUNCTION__.' ('.__LINE__.':'.__FILE__.')');
    }

    
    /**
     * removes all users from group and removes group
     *
     * probably don't want to allow removing some groups (e.g. superuser)
     * 
     * @param int $groupId
     */
    function removeGroup($groupId) {
        // make sure user is authorized to do this
        die ('unimplemented: '.__CLASS__.'::'.__FUNCTION__.' ('.__LINE__.':'.__FILE__.')');
    }
    
    /**
     * add user to group
     *
     * @param int $userId
     * @param int $groupId
     * @return boolean
     */
    function addUserToGroup($userId, $groupId) {
        // make sure user is authorized to do this
        die ('unimplemented: '.__CLASS__.'::'.__FUNCTION__.' ('.__LINE__.':'.__FILE__.')');
    }
    
    /**
     * remove user from group
     *
     * @param int $userId
     * @param int $groupId
     * @return boolean
     */
    function removeUserFromGroup($userId, $groupId) {
        // make sure user is authorized to do this
        die ('unimplemented: '.__CLASS__.'::'.__FUNCTION__.' ('.__LINE__.':'.__FILE__.')');
    }
    
    /**
     * checks if user is in group
     *
     * @param int $userId
     * @param int $groupId
     * @return boolean
     */
    function isUserInGroup($userId, $groupId) {
        die ('unimplemented: '.__CLASS__.'::'.__FUNCTION__.' ('.__LINE__.':'.__FILE__.')');
    }

    /**
     * checks if user is in named group
     *
     * @param int $userId
     * @param string $groupName
     * @return boolean
     */
    function isUserInNamedGroup($userId, $groupName) {
        die ('unimplemented: '.__CLASS__.'::'.__FUNCTION__.' ('.__LINE__.':'.__FILE__.')');
    }

}
?>
