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
 * class ItemDescription
 * description of a LibraryItem.  used to search for matching LibraryItems.
 */
/******************************* Abstract Class ****************************
  ItemDescription does not have any pure virtual methods, but its author
  defined it as an abstract class, so you should not use it directly.
  Inherit from it instead and create only objects from the derived classes
*****************************************************************************/

class ItemDescription
{
    
    var /*QueryWhere*/ $description = null;
    /**
     * constructor
     *
     * @return ItemDescription
     */
    function ItemDescription() {
        die ('unimplemented: '.__CLASS__.'::'.__FUNCTION__.' ('.__LINE__.':'.__FILE__.')');
    }
    
    /**
     * get description 
     *
     * @return array
     */
    function getDescription() {
        die ('unimplemented: '.__CLASS__.'::'.__FUNCTION__.' ('.__LINE__.':'.__FILE__.')');
        return $this->description;
    }
    
    /**
     * creates description from submitted form values
     *
     * @param array $request
     * @return boolean  success?
     */
    function setDescriptionFromFormValues($request) {
        // set the value of $this->description.
        // see include/htmlquery.inc.php::html_to_db_query and include/htmlquery.inc.php::transform_query et. al for version 1 implementation
        die ('abstract function: child class should implement this. '.__CLASS__.'::'.__FUNCTION__.' ('.__LINE__.':'.__FILE__.')');
    }
    
} // end of ItemDescription
?>
