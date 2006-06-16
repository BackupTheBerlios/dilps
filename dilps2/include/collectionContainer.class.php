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
include_once( 'collectionLocal.class.php' );
include_once( 'collectionRemote.class.php' );


class collectionContainer extends collection
{
  /**
  * @var array $collections an array of objects
  */
  var $collections;
  
  /**
  * @var object $coll an collection
  */
  var $coll;
  
  /**
  * Constructor
  * @param object $dilps as reference
  */
  
  function collectionContainer(&$dilps)
  {
    $this->collections['local'] = new collectionLocal($dilps); 
    //$this->collections['remote'] = new collectionRemote($dilps);
  }

  /**
  * getImage
  *
  * @param integer $coll_id  
  * @param integer $img_id  
  */
  function getImage( $coll_id, $img_id, $data = false )
  {
    if(!($coll = $this->findColl( $coll_id ))) return false;
    return $coll->getImage($coll_id, $img_id, $data);
  }
  
  /**
  * loadImageData
  *
  * @param integer $coll_id  
  * @param integer $img_id  
  */
  
  function loadImageData($coll_id, $img_id)
  {
    if(!($coll = $this->findColl( $coll_id ))) return false;
    return $coll->loadImageData($coll_id, $img_id);
  }
  
  /**
  * find   
  *
  * @param integer $coll_id  collection id
  * @return mixed collection as object|false;
  */
  
  function findColl( $coll_id )
  { 
    foreach( $this->collections as $c )
    {
      if( $c->hasCollection( $coll_id ))
      {
        return $c;
      }
    }
    return false;
  }
  
  /**
  * does a collecton exists?
  *
  * @param integer $coll_id collection id
  * @return boolean
  */
  
  function hasCollection( $coll_id )
  { 
    foreach( $this->collections as $c )
    {
      if( $c->hasCollection( $coll_id ))
      {
        return true;
      }
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
    foreach ($this->collections as $c){
      $c->setQuery($query);
      print_r ( $c->query);
      $c->buildQuery();
    }
  }
  
  /**
  * build query of $this->query
  *
  * pure virtual function  
  *
  */
  function buildQuery()
  {
    foreach ($this->collections as $c){
      //$c->buildQuery();
    }
  }
}

?>
