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


//example: creates a QueryWhere representing the clause "(name like '%eve%' and (location='Berlin' or location='Dresden'))"
/*
$atoms = array();
$connectors = array();
$atoms[]= $qw->atom('title', 'eve', 'like');
$phrase = $qs->phrase($atoms, $connectors);
$qw->addPhrase($phrase);

$atoms= array();
$connectors = array();
$atoms[]= $qw->atom('location', 'Berlin', '=');
$connectors[]= 'or'
$atoms[]= $qw->atom('location', 'Dresden', '=');
$phrase = $qw->phrase($atoms, $connectors);
$qw->addPhrase($phrase, 'and');

$where = $qw->toSQL();

// not so concise, but lends itself to building queries from unknown input
*/

class QueryWhere {
    /* 
    queryStructure = array(phrases, connectors) 
    phrase = array(atoms, connectors)
    connector = array ({and | or})
    atom = array(field, val, operator, not)
    */
    var /*public*/ $queryStructure = array(
                            'phrases'=>array(),
                            'connectors'=>array()
                            );
    
    /**
     * constructor
     *
     * @return Query
     */
    function QueryWhere() {
        die ('unimplemented: '.__CLASS__.'::'.__FUNCTION__.' ('.__LINE__.':'.__FILE__.')');
    }
    
    /**
     * add a phrase to the queryWhere
     *
     * @param array $phrase
     * @param array $connector // if '', doesn't add a connector
     */
    function addPhrase($phrase, $connector = '') {
       
        die ('unimplemented: '.__CLASS__.'::'.__FUNCTION__.' ('.__LINE__.':'.__FILE__.')');
    }
    
    /**
     * returns SQL where-phrase represented by this object 
     * 
     * example return value: "(name like '%eve%' and (location='Berlin' or location='Dresden'))'
     * if the queryStructure is empty, this function will return "1";
     *
     * @return string sql where clause
     */
    function toSQL() {
        die ('unimplemented: '.__CLASS__.'::'.__FUNCTION__.' ('.__LINE__.':'.__FILE__.')');
    }
    
    /**
     * returns an array from the passed values
     *
     * @param string 
     */
    
    /**
     * returns an array created from the passed values
     *
     * @param string $field
     * @param string $val
     * @param string $operator
     * @param boolean $not = false  // if $not is true, then the operator will be negated (e.g. != or "not like")
     * @return array atom
     */
    function atom($field, $val, $operator, $not = false) {
       die ('unimplemented: '.__CLASS__.'::'.__FUNCTION__.' ('.__LINE__.':'.__FILE__.')');
    }

    /**
     * returns a phrase array created atoms and connectors
     *
     * @param string $atoms
     * @param string $connectors
     * @return array 
     */
    function phrase($atoms, $connectors) {
       die ('unimplemented: '.__CLASS__.'::'.__FUNCTION__.' ('.__LINE__.':'.__FILE__.')');
    }
}

?>