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


class collectionRemote extends collection
{
  /**
  * Benutzerliste
  * @var object $db
  * @var string $db_prefix
  */
  
  var $db;
  var $db_prefix;
  
  /**
  * Constructor
  * @param object $db as reference
  * @param string $db_prefix as reference
  */
  
  function collectionRemote(&$dilps)
  {
    //collection::collection( $dilps );

    $sql = 'SELECT * FROM '.$dilps->db_prefix.'collection where host = "remote" and active = 1';
    $result = $dilps->db->Execute( $sql );
    
    while( !$result->EOF ) 
    {
      $this->addCollId($result->fields['collectionid']); 
      $result->MoveNext();
    }
  }

  function hasCollection(&$coll_id)
  {
    foreach ($this->coll_id as $id)
    {
      if( $id == $coll_id ) return true;
    }  return false;
  }
  
  
  function getImage($coll_id,$img_id)
   {
//     $sql = 'SELECT * FROM '.$db_prefix.'meta where collectionid = '. $coll_id.'  and imageid = '. $img_id;
     
     return new Image( $this, $coll_id, $img_id );
   }
   
   function getImageData( $coll_id, $img_id )
   {
   
   }
}

?>
