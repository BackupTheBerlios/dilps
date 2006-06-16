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

include_once( 'collection.class.php' );

class collectionLocal extends collection
{
  /**
  * collection
  * @var array $coll_id
  */
  
  var $coll_id;
  
  /**
  * Constructor
  * @param object $dilps as reference
  */
  
  function collectionLocal(&$dilps)
  {
    /**
    * for use of $db and $db_prefix in loadImgData
    */
    parent::collection($dilps);
    
    $sql = 'SELECT * FROM '.$dilps->db_prefix.'collection where host = "local" and active = 1';
    $result = $dilps->db->Execute( $sql );
    
    while( !$result->EOF ) 
    {
      $this->addCollId($result->fields['collectionid']); 
      $result->MoveNext();
    }
  }
  
  /**
  * @param string $coll_id collection id
  * @param string $img_id  image_id
  * @param object $data
  * @return Image Image object 
  */
  function getImage( $coll_id, $img_id, $data = false)
  {
    return new Image( $this, $coll_id, $img_id, $data );
  }
  
  function loadImageData($coll_id, $img_id)
  {
    /**
    * to access object in php4
    */
    $dilps =& $this->dilps;
    $db =& $dilps->db;
    
    $sql = 'SELECT * FROM '.$dilps->db_prefix.'img where collectionid = '.$coll_id.' and imageid = '.$img_id.'';
    $result = $db->GetRow( $sql );
    
    if( !$result) 
    {
      // error
      $error = 'img does not exist';
      return false;
    }
    return $result;
  }
  
  /**
  * build query of $this->query
  *
  */
  function buildQuery()
  {
    $sql = '';
    
    foreach($this->query as $and){
      if (is_string($and)){
        $sql .= $and.' AND ';
      } else {
        foreach($and as $or){
          $sql .= $or.' OR ';
        }
        //substr_replace($sql,-4, ) 
      }
    }
    print $sql;
  }
  
}

?>
