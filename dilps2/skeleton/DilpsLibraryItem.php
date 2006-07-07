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
 * class DilpsLibraryItem
 */
class DilpsLibraryItem extends LibraryItem
{

    var $id;
    
    /**
     * @access public
     * @static 
     */
    var $STATUS_NEW = 'new';
    var $STATUS_EDITED = 'edited';  //nicht freigegeben
    var $STATUS_REVIEWED = 'reviewed';  //freigegeben
    
    /**
     * constructor
     * 
     * @param id
     * @access public
     * @return DilpsLibraryItem
     */
    function DilpsLibraryItem($id) {
        // create this item from details stored in db
    }
    
    
    /**
     * sets any of the detail fields provided in $details.  
     *
     * @param array details      
     * @return boolean
     * @access public
     */
    function setDetails( $details )
    {
        die ('unimplemented: '.__CLASS__.'::'.__FUNCTION__.' ('.__LINE__.':'.__FILE__.')');        
    } // end of member function setDetails

    /**
     * sets status, e.g. neue, freigegeben, nicht freigegeben
     *
     * @param int status      
     * @return boolean
     * @access public
     */
    function setStatus( $status )
    {
        die ('unimplemented: '.__CLASS__.'::'.__FUNCTION__.' ('.__LINE__.':'.__FILE__.')');        
    } // end of member function setStatus

    /**
     * gets an array of LibraryItem that are related to this LibraryItem
     *
     * @return array
     * @access public
     */
    function getRelatedItems( )
    {
        die ('unimplemented: '.__CLASS__.'::'.__FUNCTION__.' ('.__LINE__.':'.__FILE__.')');        
    } // end of member function getRelatedItems

    /**
     * remove a resource from this item
     *
     * @param int resourceId      
     * @return boolean
     * @access public
     */
    function removeResource( $resourceId )
    {
        die ('unimplemented: '.__CLASS__.'::'.__FUNCTION__.' ('.__LINE__.':'.__FILE__.')');        
    } // end of member function removeResource

    /**
     * adds a resource to this item
     *
     * @param LibraryItemResource resource      
     * @return boolean
     * @access public
     */
    function addResource( $resource )
    {
        die ('unimplemented: '.__CLASS__.'::'.__FUNCTION__.' ('.__LINE__.':'.__FILE__.')');        
    } // end of member function addResource



} // end of DilpsLibraryItem
?>
