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
 * class LibraryItemResource
 * 
 */
/******************************* Abstract Class ****************************
  LibraryItemResource does not have any pure virtual methods, but its author
  defined it as an abstract class, so you should not use it directly.
  Inherit from it instead and create only objects from the derived classes
*****************************************************************************/

class LibraryItemResource
{

     /*** Attributes: ***/

    /**
     * @access public
     */
    var $id;
    /**
     * @access public
     */
    var $libraryId;
    /**
     * @access public
     */
    var $resourceType;
    /**
     * @access public
     */
    var $name;
    /**
     * @access public
     */
    var $description;
    /**
     * url for resource
     * @access public
     */
    var $url;  
    
    /**
     * constructor
     *
     * @return LibraryItemResource
     */
    function LibraryItemResource() {
        die ('unimplemented: '.__CLASS__.'::'.__FUNCTION__.' ('.__LINE__.':'.__FILE__.')');
    }

    /**
     * sets any of the settable fields of this LibraryItemResource
     *
     * @param array details (fieldname=>value)
     * @return boolean
     * @abstract
     * @access public
     */
    function setDetails( $details )
    {
        die ('abstract class - subclass must implement this function. '. __CLASS__.'::'.__FUNCTION__);            
    } // end of member function setDetails

    /**
     * performs a mutation operation on the resource (e.g. resize, rotate, etc)
     *
     * @param String action specifies how to alter this resource
     * @param array actionDetails contains key=>value pairs that correspond to the action.  (e.g. 'rotate'=>180)
     * @return boolean
     * @abstract
     * @access public
     */
    function alter($action,  $actionDetails = array())
    {
        // switch statement for $action here.
        // alternatively, implement a seperate function for each possible action (e.g. rotate(), resize(), etc.)

        die ('abstract class - subclass must implement this function. '. __CLASS__.'::'.__FUNCTION__);            
    } // end of member function alter



} // end of LibraryItemResource
?>
