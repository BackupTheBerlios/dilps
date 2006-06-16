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


class Image
{
  /**
  * @var object $coll collecton object
  * @var integer $coll_id collection id
  * @var integer $img_id  image id
  * @var arrary $data data of an image
  */
 
  var $coll;
  var $coll_id;
  var $img_id;
  var $data;
  
  /**
  * Constructor
  *
  * set attributs
  *
  *
  * @param object $coll collecton object as reference
  * @param integer $coll_id collection id
  * @param integer $img_id  image id
  * @param array date data of an image, set to false
  */
  
  function Image(&$coll, $coll_id, $img_id, $data = false)
  {
    // paranoia
    //    if( !$coll->HasCollection($coll_id)) return false;
    
    $this->coll =& $coll;
    $this->coll_id = $coll_id;
    $this->img_id = $img_id;
    $this->data = $data;
    
    //$dilps =& $coll->dilps; 
    //$db =& $dilps->db; 
  }
  
  /**
  *
  */
  function loadImageData()
  {
    /**
    * to access object in php4
    */
    $coll = $this->coll;
    $this->data = $coll->loadImageData($this->coll_id, $this->img_id);
    return ($this->data != false);
  }

  function getImageData()
  {
    return $this->data;
  }
  
}

?>
