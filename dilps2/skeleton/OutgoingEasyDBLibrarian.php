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
 * class OutgoingEasyDBLibrarian
 * Handles requests to a remote EasyDB Library from a local dilps user
 */
class OutgoingEasyDBLibrarian extends Librarian
{
    /**
     * constructor
     *
     * @return OutgoingEasyDBLibrarian
     */
    function OutgoingEasyDBLibrarian() {
        die ('unimplemented: '.__CLASS__.'::'.__FUNCTION__.' ('.__LINE__.':'.__FILE__.')');
    }
    
    /**
     * gets a count of matching items in the remote EasyDB 
     *
     * @param ItemDescription properties description of items for which count is desired
     * @return int
     * @access public
     */
    function getItemCount( $properties )
    {
        // query remote library via SOAP
        die ('unimplemented: '.__CLASS__.'::'.__FUNCTION__.' ('.__LINE__.':'.__FILE__.')');
    } // end of member function getItemCount
    
} // end of OutgoingEasyDBLibrarian
?>
