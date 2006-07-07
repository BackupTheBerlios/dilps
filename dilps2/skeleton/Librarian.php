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
 * class Librarian
 * All requests information about Library Collections and Items  need to be made to a Librarian
 */
/******************************* Abstract Class ****************************
  Librarian does not have any pure virtual methods, but its author
  defined it as an abstract class, so you should not use it directly.
  Inherit from it instead and create only objects from the derived classes
*****************************************************************************/

class Librarian
{

     /*** Attributes: ***/

    /**
     * @access public
     */
    var $role;
    /**
     * @access private
     */
    var $accessController;
    /**
     * @access private
     */
    var $library;
    
    /**
     * constructor
     *
     * @param Library $library
     * @param User $user
     * @return Librarian
     */
    function Librarian($library, $user) {
        $this->library = $library;
        $this->user = $user;
    }
    

    /**
     * like getItemDetails(), but returns only basic information
     *
     * @param ItemDescription properties      
     * @return array fieldname=>value
     * @abstract
     * @access public
     */
    function getItemOverviews( $properties )
    {
        die ('abstract class - subclass must implement this function. '. __CLASS__.'::'.__FUNCTION__);
    } // end of member function getItemOverviews

    /**
     * gets detailed description of LibraryItems
     *
     * @param array itemIds      
     * @return array fieldname=>value
     * @abstract
     * @access public
     */
    function getItemDetails( $itemIds )
    {
        die ('abstract class - subclass must implement this function. '. __CLASS__.'::'.__FUNCTION__);
        
    } // end of member function getItemDetails

    /**
     *
     * @param int itemId      
     * @return array of LibraryItems (possibly empty array)
     * @abstract
     * @access public
     */
    function getItemResources( $itemId)
    {
        
        die ('abstract class - subclass must implement this function. '. __CLASS__.'::'.__FUNCTION__);
    } // end of member function getItemResource

    /**
     *
     * @return array
     * @abstract
     * @access public
     */
    function getCollections( )
    {
        
        die ('abstract class - subclass must implement this function. '. __CLASS__.'::'.__FUNCTION__);
        
    } // end of member function getCollections



} // end of Librarian
?>
