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
 * class FolderManager
 * 
 * used to manage folders, which are users personal collections of LibraryItems
 * 
 */
class FolderManager
{

    /**
     * constructor
     *
     * @return FolderManager
     */
    function FolderManager() {
        die ('unimplemented: '.__CLASS__.'::'.__FUNCTION__.' ('.__LINE__.':'.__FILE__.')');    
    }
    
    /**
     * add a new Folder
     *
     * @param Folder Folder      
     * @param int parentFolderId if 0, will be added at the top level
     * @return boolean
     * @access public
     */
    function addFolder( $Folder,  $parentFolderId = 0 )
    {
        die ('unimplemented: '.__CLASS__.'::'.__FUNCTION__.' ('.__LINE__.':'.__FILE__.')');
    } // end of member function addFolder

    /**
     * remove a Folder
     *
     * @param int FolderId      
     * @return boolean
     * @access public
     */
    function removeFolder( $FolderId )
    {
        die ('unimplemented: '.__CLASS__.'::'.__FUNCTION__.' ('.__LINE__.':'.__FILE__.')');
    } // end of member function removeFolder

    /**
     * set the settable Folder details
     *
     * @param int $FolderId
     * @param array $details (fieldname=>value array)
     * @return boolean
     * @access public
     */
    function updateFolder( $FolderId, $details )
    {
        die ('unimplemented: '.__CLASS__.'::'.__FUNCTION__.' ('.__LINE__.':'.__FILE__.')');
    } // end of member function updateFolder

    /**
     *
     * @param int parentFolderId if 0, then get all top-level Folders
     * @return array
     * @access public
     */
    function getFolders( $parentFolderId = 0 )
    {
        die ('unimplemented: '.__CLASS__.'::'.__FUNCTION__.' ('.__LINE__.':'.__FILE__.')');
    } // end of member function getFolders


    /**
     * gets a list of all Folders of the user
     *
     * @param int $userId
     * @return array
     * @access public
     */
    function getUserFolders( $userId )
    {
        die ('unimplemented: '.__CLASS__.'::'.__FUNCTION__.' ('.__LINE__.':'.__FILE__.')');
    } // end of member function getFolders

} // end of FolderManager
?>
