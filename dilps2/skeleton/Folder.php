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
 * class Folder
 * 
 * a Folder is a user's personal collection of LibraryItems.  The Folder can be public (visible to all) or 
 * not (visible only to the creator)
 */
class Folder
{

     /*** Attributes: ***/

    /**
     * @access public
     */
    var $id;
    /**
     * @access public
     */
    var $name;
    /**
     * @access public
     */
    var $description;
    /**
     * if not active, it's not available for viewing
     * @access public
     */
    var $active;
    /**
     * if not public, then it is only visible to the group creator
     * @access public
     */
    var $public;
    /**
     * id of creating user
     * @access public
     */
    var $creator;
    /**
     * @access public
     */
    var $parentId;

    /**
     * constructor
     *
     * @return Folder
     */
    function Folder() {
        die ('unimplemented: '.__CLASS__.'::'.__FUNCTION__.' ('.__LINE__.':'.__FILE__.')');    
    }
    
    /**
     * adds item to folder
     *
     * @param  int $libraryId id of Library
     * @param  int $itemId id of LibraryItem
     * @return boolean
     */
    function addItemToFolder($libraryId, $itemId) {
        die ('unimplemented: '.__CLASS__.'::'.__FUNCTION__.' ('.__LINE__.':'.__FILE__.')');    
    }

    /**
     * remove item from folder
     *
     * @param  int $folderItemId
     * @return boolean
     */
    function removeItemFromFolder($folderItemId) {
        die ('unimplemented: '.__CLASS__.'::'.__FUNCTION__.' ('.__LINE__.':'.__FILE__.')');    
    }
    
    /**
     * gets list of items in folder
     *
     * @return array of LibraryItems, keyed by folderItemId
     */
    function getItemsInFolder() {
        die ('unimplemented: '.__CLASS__.'::'.__FUNCTION__.' ('.__LINE__.':'.__FILE__.')');    
    }
    
} // end of Folder
?>
