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
 * class DilpsSystem
 */
class DilpsSystem
{

     /*** Attributes: ***/

    /**
     * @access private
     */
    var $accessController;
    /**
     * @access private
     */
    var $db;

    /**
     * constructor
     * 
     * get database connection and accessController
     *
     * @return DilpsSystem
     */
    function DilpsSystem() {
        die ('unimplemented: '.__CLASS__.'::'.__FUNCTION__.' ('.__LINE__.':'.__FILE__.')');
        
    }
    

    /**
     * get Library objects
     *
     * @param array typeFilter If any library types are listed in the values of typeFilter, then only Libraries of that type will be returned.  If typeFilter is an empty array (the default), no filtering will be done
     * @param boolean onlyActive return only Libraries marked active
     * @return array
     * @access public
     */
    function getLibraries( $typeFilter = array(),  $onlyActive = true )
    {
        // query db and create appropriate Library objects
        die ('unimplemented: '.__CLASS__.'::'.__FUNCTION__.' ('.__LINE__.':'.__FILE__.')');
    }
    
    /**
     * get Librarian objects
     *
     * @param array typeFilter If any library types are listed in the values of typeFilter, then only Librarians for that type will be returned.  If typeFilter is an empty array (the default), no filtering will be done
     * @param boolean onlyActive return only Libraries marked active
     * @return array of Librarians
     * @access public
     */
    function getLibrarians( $typeFilter = array(),  $onlyActive = true )
    {
        // query db and create appropriate Librarian objects
        die ('unimplemented: '.__CLASS__.'::'.__FUNCTION__.' ('.__LINE__.':'.__FILE__.')');
    }
    
    /**
     * get Librarian for local Library
     *
     * @return LocalDilpsLibrarian
     * @access public
     */
    function getLocalLibrarian() {
        die ('unimplemented: '.__CLASS__.'::'.__FUNCTION__.' ('.__LINE__.':'.__FILE__.')');
    }
    
    /**
     * get Librarian for specified Library
     *
     * @return Librarian
     * @access public
     */
    function getLibrarian($libraryId) {
        die ('unimplemented: '.__CLASS__.'::'.__FUNCTION__.' ('.__LINE__.':'.__FILE__.')');
    }
    
    /**
     * gets a list of all collections from all libraries
     *
     */
    function getCollectionList() {
        die ('unimplemented: '.__CLASS__.'::'.__FUNCTION__.' ('.__LINE__.':'.__FILE__.')');
    }

} // end of DilpsSystem
?>
