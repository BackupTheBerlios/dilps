<?php
/*
   +----------------------------------------------------------------------+
   | DILPS - Distributed Image Library System                             |
   +----------------------------------------------------------------------+
   | Copyright (c) 2002-2004 Juergen Enge                                 |
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
* @author fabian thommen <job@fabtho.net>
*/

include_once( 'collectionContainer.class.php' );
include_once( 'error.class.php' );

/**
 * Basisklasse
 * @package Authentication
 */

 /**
  * Liste aller Benutzerlogins
  * @author Juergen Enge <juergen@info-age.net>
  * @copyright 2002 Juergen Enge
  */

class dilps
{
   /**
    * Benutzerliste
    * @var object $db
    * @var string $db_prefix
    * @var object $coll
    * @var array $query search query
    * @var object $error error handling
    */
    
   var $db;
   var $db_prefix;
   var $coll;
   var $query;
   var $error;
   
   /**
    * constructor   
    *  
    * @param object $db db handler as ref
    * @param string $db_prefix db table prefix as ref
    */
    
   function dilps(&$db,&$db_prefix)
   {
      $this->error = new error();
      $this->db = $db;
      $this->db_prefix = $db_prefix;
      $this->coll = new collectionContainer($this);
   }

   function getImage( $coll_id, $img_id)
   {
      $coll =& $this->coll;
      return $coll->getImage( $coll_id, $img_id);
   }
   
   function setQuery( $query )
   {
      return $this->coll->setQuery( $query );
   }
}

?>
