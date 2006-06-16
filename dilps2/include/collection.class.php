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

include_once( 'Image.class.php' );

/**
* Baseclass
*/

class collection
{
  /**
  * @var array $coll_id collection id
  */
  var $coll_id;
  
  /**
   * @var object $dilps 
  */
  var $dilps;
 
  /**
  * @var array $query search query 
  */
  var $query;

  /**
  * Constructor
  * @param object $dilps dilps object as reference
  */
  function collection(&$dilps)
  {
    $this->dilps = $dilps;
    $this->coll_id = array();
    $this->query = array();
  }
  
  /**
  * get $coll_id
  *
  * @return integer cellection id
  */
  function getCollId()
  {
    return ($this->coll_id); 
  }
  
  /**
  * add id to $coll_id
  *
  * @param integer $id id of a collection
  */
  function addCollId($id)
  {
    $this->coll_id[] = $id; 
  }
  
  /**
  * getImage
  *
  * pure virtual function  
  *
  * @param integer $coll_id  collection id
  * @param integer $img_id  image id 
  * @return Image Image object
  */
  function getImage( $coll_id, $img_id, $data = false)
  {
    die( "pure virtual function called" );
  }
  
  /**
  * loadImageData
  *
  * pure virtual function  
  *
  * @param integer $coll_id collection id
  * @param integer $img_id image id
  */
  function loadImageData($coll_id,$img_id)
  {
    die( "pure virtual function called" );
  }
  
  /**
  * does a collecton exists?
  *
  * @param integer $coll_id collection id
  * @return boolean true|false
  */
  
  function hasCollection($coll_id)
  { 
    foreach ($this->coll_id as $id)
    {
      if( $id == $coll_id ) return true;
    }
    return false;
  }
  
  /**
  * set $query to $this->query
  *
  * @param array $query search query 
  */
  
  function setQuery($query)
  { 
    $this->query = $query;
  }

  
  /**
  * build query of $this->query
  *
  * pure virtual function  
  *
  */
  function buildQuery()
  {
    die( "pure virtual function called" );
  }
}

?>
