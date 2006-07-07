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
 * class Library
 */
class Library
{

     /*** Attributes: ***/

    /**
     * full host name including port number if non-standard.  Exception: the local dilps
     * @access private
     */
    var $host;
    /**
     * remote access interface url (e.g. soap url)
     * @access private
     */
    var $accessURL;
    /**
     * e.g. dilps or easydb
     * @access private
     */
    var $libraryType;
    /**
     * web access point to this library (or a description of it)
     * @access private
     */
    var $informationURL;
    /**
     * @access private
     */
    var $active;
    /**
     * @access private
     */
    var $librarian = null;

    /**
     * constructor
     * 
     * returns a Library object
     * 
     * @param int $libraryId
     * @param int $libraryType
     * @return Library
     * @access public
     */
    function Library($libraryId, $libraryType)
    {
        die ('unimplemented: '.__CLASS__.'::'.__FUNCTION__.' ('.__LINE__.':'.__FILE__.')');
    }

    /**
     * returns this Library's  Librarian
     * 
     * @return Librarian
     * @access public
     */
    function getLibrarian()
    {
        // if librarian is null, create new Librarian of appropriate type
        // return $this->librarian;
        die ('unimplemented: '.__CLASS__.'::'.__FUNCTION__.' ('.__LINE__.':'.__FILE__.')');
    }

} // end of Library
?>
