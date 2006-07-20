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
 * class LibraryItem
 * 
 * A single LibraryItem can, theoretically, belong to many Collections.  Therefore, any database representation
 * of a LibraryItem should not have the collectionId in the LibraryItem base table.
 * 
 */
class LibraryItem
{

     /*** Attributes: ***/

    /**
     * @access public
     */
    var $id;
    /**
     * @access public
     */
    var $type;
    /**
     * @access private
     */
    var $libraryId;
    /**
     * @access private
     */
    var $collectionId;
    
    /**
     * constructor
     */
    function LibraryItem() {
        die ('unimplemented: '.__CLASS__.'::'.__FUNCTION__.' ('.__LINE__.':'.__FILE__.')');
    }

    /**
     * get all available information about this object
     *
     * standard fields: author / title / date / location / source
     * subclasses should massage any appropriate data into these standard fields, setting them to an empty string if there is no appropriate value
     * any number of implementation-specific further fields are possible
     *
     * @return array
     * @abstract
     * @access public
     */
    function getDetails( )
    {
        /* dummy implementation:
           return array (
                    'author'=>'john doe', 
                    'title'=>'The Wheel', 
                    'date' =>'About 1970'
                    'location' => 'Ontario, Canada',
                    'source'   => 'SK Merion: La joie de vivre - die nie gesehenen Meisterwerke der Barnes Collection. Berlin 1993
Seite: 157
ISBN: 3-463-40221-1',
                        );
        */
        die ('abstract class - subclass must implement this function. '. __CLASS__.'::'.__FUNCTION__);        
    } // end of member function getDetails

    /**
     *
     * @return array
     * @abstract
     * @access public
     */
    function getResources( )
    {
        die ('abstract class - subclass must implement this function. '. __CLASS__.'::'.__FUNCTION__);
          // possible dummy response:
            return array(
                            0 => /*Image*/ $img1,
                            1 => /*Image*/ $img2,
                            2 => /*Book*/  $book1
                ); 
    } // end of member function getResources

    /**
     *
     * @param int type type of template: e.g. overview, display, edit
     * @return String
     * @abstract
     * @access public
     */
    function getTemplate( $type )
    {
        die ('abstract class - subclass must implement this function. '. __CLASS__.'::'.__FUNCTION__);
    } // end of member function getTemplate

    /**
     *  gets basic information about this item
     *
     * this information can be used to fill in the text fields in an overview template 
     *
     * standard fields: author / title 
     * any number of implementation-specific further fields are possible
     *
     * @return array
     * @abstract
     * @access public
     */
    function getOverview( )
    {
        /*
           dummy implementation:
           return array (
                    'author'=>'john doe', 
                    'title'=>'The Wheel', 
                        );
           // where, for example, resource_type 1 indicates a picture, and 23 indicates  
        */
        die ('abstract class - subclass must implement this function. '. __CLASS__.'::'.__FUNCTION__);
    } // end of member function getOverview

    /**
     * (implement? if so, then maybe we don't need getTemplate())
     *
     * @param int viewType type of view to render
     * @return String
     * @abstract
     * @access public
     */
    function render( $viewType )
    {
        die ('abstract class - subclass must implement this function. '. __CLASS__.'::'.__FUNCTION__);
    } // end of member function render



} // end of LibraryItem
?>
