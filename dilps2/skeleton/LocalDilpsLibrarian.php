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
 * class LocalDilpsLibrarian
 * Handles requests for the local dilps library from users of the local dilps system
 */
class LocalDilpsLibrarian extends Libarian
{
    /**
     * @var GroupManager groupManager
     * @access private
     */
    var $groupManager;
    
    
    /**
     * constructor
     *
     * @param Library $library
     * @param User $user
     * @return LocalDilpsLibrarian
     */
    function LocalDilpsLibrarian($library, $user) {
        die ('unimplemented: '.__CLASS__.'::'.__FUNCTION__.' ('.__LINE__.':'.__FILE__.')');    
    }
    
    /**
     * gets the group manager
     *
     */
    function getGroupManager() {
        die ('unimplemented: '.__CLASS__.'::'.__FUNCTION__.' ('.__LINE__.':'.__FILE__.')');    
        // if $this->groupManager is null, create groupManager
        // return $this->groupManager;
    }
    
    /**
     * if user has appropriate permissions, creates a new Collection in the Library
     *
     * @param Collection collection      
     * @return boolean
     * @access public
     */
    function addCollection( $collection )
    {
        // - create new collection
        // - add collection to library
            die ('unimplemented: '.__CLASS__.'::'.__FUNCTION__.' ('.__LINE__.':'.__FILE__.')');
    } // end of member function addCollection

    /**
     * if user has appropriate permissions, removes this collection from the Library
     *
     * @param int collectionId      
     * @return boolean
     * @access public
     */
    function removeCollection( $collectionId )
    {
        die ('unimplemented: '.__CLASS__.'::'.__FUNCTION__.' ('.__LINE__.':'.__FILE__.')');
    } // end of member function removeCollection

    /**
     * if user has appropriate permissions, sets Collection details 
     *
     * @param int collectionId      
     * @param array details  (fieldname=>value array)
     * @return boolean
     * @access public
     */
    function setCollectionDetails( $collectionId, $details )
    {
        die ('unimplemented: '.__CLASS__.'::'.__FUNCTION__.' ('.__LINE__.':'.__FILE__.')');
    } // end of member function setCollectionDetails

    /**
     * if user has appropriate permissions, calls the Collection::removeItem() function
     *
     * @param int collectionId      
     * @param int itemId      
     * @return boolean
     * @access public
     */
    function removeCollectionItem( $collectionId,  $itemId )
    {
        die ('unimplemented: '.__CLASS__.'::'.__FUNCTION__.' ('.__LINE__.':'.__FILE__.')');
    } // end of member function removeCollectionItem

    /**
     * if user has appropriate permissions, calls the appropriate LibraryItem::setDetails() function
     *
     * @param int itemId      
     * @param array details      
     * @return boolean
     * @access public
     */
    function setItemDetails( $itemId,  $details )
    {
        die ('unimplemented: '.__CLASS__.'::'.__FUNCTION__.' ('.__LINE__.':'.__FILE__.')');
    } // end of member function setItemDetails

    /**
     * if user has appropriate permissions, calls the appropriate LibraryItem::addResource() function
     *
     * @param int itemId      
     * @param LibraryItemResource resource      
     * @return boolean
     * @access public
     */
    function addItemResource( $itemId,  $resource )
    {
        die ('unimplemented: '.__CLASS__.'::'.__FUNCTION__.' ('.__LINE__.':'.__FILE__.')');
    } // end of member function addItemResource

    /**
     * if user has appropriate permissions, calls the appropriate LibraryItem::removeResource() function
     *
     * @param int itemId      
     * @param int resourceId      
     * @return boolean
     * @access public
     */
    function removeItemResource( $itemId,  $resourceId )
    {
        die ('unimplemented: '.__CLASS__.'::'.__FUNCTION__.' ('.__LINE__.':'.__FILE__.')');
    } // end of member function removeItemResource

    /**
     * if user has appropriate permissions, calls the appropriate LibraryItemResource::setDetails() function
     *
     * @param int resourceId      
     * @param array details (array: fieldname=>value)     
     * @return boolean
     * @access public
     */
    function setResourceDetails( $resourceId,  $details )
    {
        die ('unimplemented: '.__CLASS__.'::'.__FUNCTION__.' ('.__LINE__.':'.__FILE__.')');
    } // end of member function setResourceDetails

    /**
     * if user has appropriate permissions, calls the appropriate LibraryItemResource::alter() function
     *
     * @param int resourceId      
     * @param String action      
     * @param array actionDetails provides any additional information necessary for the action.  for example, if the action is "rotate", and a 90 degree left rotation is desired, actionDetails could be: array('degrees'=>90)
     * @return boolean
     * @access public
     */
    function alterResource( $resourceId,  $action,  $actionDetails = array() )
    {
        die ('unimplemented: '.__CLASS__.'::'.__FUNCTION__.' ('.__LINE__.':'.__FILE__.')');
    } // end of member function alterResource


    /**
     * get
     *
     * @param QueryWhere $queryWhere
     */
    function getArtists($queryWhere) {
        
    }
    
    function getLocations($queryWhere) {
        
    }
    
    function getInstitutions($queryWhere) {
        
    }

} // end of LocalDilpsLibrarian
?>
